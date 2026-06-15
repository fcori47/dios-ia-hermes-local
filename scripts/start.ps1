# =============================================================================
# Arranque de Hermes + Ollama para Windows (PowerShell).
# Detecta GPU NVIDIA y usa CUDA si está; sino CPU.
#   bundled (default) -> Ollama dentro de Docker (Docker Desktop + WSL2)
#   host              -> Ollama nativo en Windows (Hermes le pega via
#                        host.docker.internal)
#
# Uso:  .\scripts\start.ps1 [bundled|host]
# =============================================================================
param([ValidateSet("bundled","host")][string]$Mode = "bundled")

$ErrorActionPreference = "Stop"
# En PowerShell 7.4+ un exit-code != 0 de un comando nativo lanza error con Stop.
# Lo desactivamos para poder inspeccionar $LASTEXITCODE (la variable no existe en 5.1).
$PSNativeCommandUseErrorActionPreference = $false

function Info($m){ Write-Host ">>> $m" -ForegroundColor Cyan }
function Warn($m){ Write-Host "!!! $m" -ForegroundColor Yellow }
function Err ($m){ Write-Host "ERROR: $m" -ForegroundColor Red }

# Raíz del repo (este script vive en scripts\).
Set-Location (Join-Path $PSScriptRoot "..")

# Escribe/actualiza una variable en .env SIN BOM (compose no tolera BOM bien).
function Set-EnvVar($key, $val) {
  $lines = @(Get-Content ".env")
  $found = $false
  $out = @(foreach ($l in $lines) {
    if ($l -match ("^" + [regex]::Escape($key) + "=")) { $found = $true; "$key=$val" } else { $l }
  })
  if (-not $found) { $out += "$key=$val" }
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllLines((Resolve-Path ".env").Path, $out, $utf8NoBom)
}

# --- Docker ----------------------------------------------------------------
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Err "Docker no está instalado. Instalá Docker Desktop: https://www.docker.com/products/docker-desktop/"
  exit 1
}
try { docker info *>$null } catch {}
if ($LASTEXITCODE -ne 0) { Err "Docker no está corriendo. Abrí Docker Desktop y reintentá."; exit 1 }

# --- .env ------------------------------------------------------------------
if (-not (Test-Path ".env")) { Info "Creando .env desde .env.example"; Copy-Item ".env.example" ".env" }

$modelLine = Get-Content ".env" | Where-Object { $_ -match "^OLLAMA_MODEL=" } | Select-Object -Last 1
if ($modelLine) { $Model = ($modelLine -split "=", 2)[1].Trim() } else { $Model = "qwen3:8b" }
if (-not $Model) { $Model = "qwen3:8b" }
$env:OLLAMA_MODEL = $Model

Write-Host ""
Info "Modo:    $Mode"
Info "Modelo:  $Model"
Write-Host ""

if ($Mode -eq "host") {
  # =========================================================================
  # MODO HOST — Ollama nativo en Windows
  # =========================================================================
  if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
    Err "Ollama no está instalado. Descargalo: https://ollama.com/download/windows"
    exit 1
  }
  try { Invoke-RestMethod "http://localhost:11434/api/tags" -TimeoutSec 3 | Out-Null }
  catch { Err "Ollama no responde. Abrí la app de Ollama y reintentá."; exit 1 }

  Info "Descargando modelo '$Model' (si falta)..."
  ollama pull $Model

  Set-EnvVar "OPENAI_BASE_URL" "http://host.docker.internal:11434/v1"
  Info "Lanzando wizard de Hermes..."
  docker compose run --rm hermes-setup
}
else {
  # =========================================================================
  # MODO BUNDLED — Ollama dentro de Docker
  # =========================================================================
  $compose = @("-f", "docker-compose.yml")
  $gpu = $false
  if (Get-Command nvidia-smi -ErrorAction SilentlyContinue) {
    try { nvidia-smi *>$null } catch {}
    if ($LASTEXITCODE -eq 0) {
      Info "GPU NVIDIA detectada -> probando passthrough a Docker..."
      # Que nvidia-smi ande no garantiza que Docker pueda usar la GPU (hace falta
      # WSL2 con GPU). Probamos un contenedor con --gpus all; si falla, vamos a CPU.
      try { docker run --rm --gpus all --entrypoint true ollama/ollama:latest *>$null } catch {}
      if ($LASTEXITCODE -eq 0) { $gpu = $true }
    }
  }
  if ($gpu) {
    Info "Passthrough OK -> aceleración CUDA."
    $compose += @("-f", "docker-compose.gpu.yml")
  } else {
    Warn "Sin GPU NVIDIA usable -> Ollama en CPU (más lento con modelos grandes)."
  }

  Set-EnvVar "OPENAI_BASE_URL" "http://ollama:11434/v1"

  Info "Levantando Ollama en Docker..."
  docker compose @compose --profile bundled up -d ollama

  Info "Descargando modelo '$Model' (puede tardar varios minutos)..."
  docker compose @compose --profile bundled run --rm pull-model

  Info "Lanzando wizard de Hermes..."
  docker compose @compose run --rm hermes-setup
}

Write-Host ""
Info "Todo listo. Para chatear con Hermes:"
Write-Host "    docker compose run --rm hermes"
