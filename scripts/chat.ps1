# Abre un chat con Hermes en Windows. Se asegura de que Ollama esté arriba.
#   .\scripts\chat.ps1
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

if (-not (Test-Path ".env")) { Copy-Item ".env.example" ".env" }

# Modo "bundled" (Ollama en Docker): levantarlo si no está. Modo "host": no hace falta.
if (Get-Content ".env" | Where-Object { $_ -match "^OPENAI_BASE_URL=http://ollama:" }) {
  docker compose --profile bundled up -d ollama
}

docker compose run --rm hermes
