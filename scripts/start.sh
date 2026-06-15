#!/usr/bin/env bash
# =============================================================================
# Arranque de Hermes + Ollama para macOS y Linux.
# Detecta SO y GPU y elige el modo correcto:
#   macOS  -> Ollama NATIVO en el host (Docker no puede usar la GPU Metal)
#   Linux  -> Ollama en Docker (GPU NVIDIA si hay, sino CPU)
#
# Uso:  ./scripts/start.sh [host|bundled]   (sin argumento -> auto)
# =============================================================================
set -euo pipefail

# Ubicarse en la raíz del repo (este script vive en scripts/).
cd "$(dirname "$0")/.."

info() { printf '\033[1;36m>>> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m!!! %s\033[0m\n' "$*"; }
err()  { printf '\033[1;31mERROR: %s\033[0m\n' "$*" >&2; }

# Actualiza (o agrega) una variable en .env de forma portátil (sin sed -i).
set_env_var() {
  local key="$1" val="$2" tmp found=0
  tmp="$(mktemp)"
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in
      "${key}="*) printf '%s=%s\n' "$key" "$val"; found=1 ;;
      *)          printf '%s\n' "$line" ;;
    esac
  done < .env > "$tmp"
  [ "$found" -eq 0 ] && printf '%s=%s\n' "$key" "$val" >> "$tmp"
  mv "$tmp" .env
}

# --- Docker ----------------------------------------------------------------
if ! command -v docker >/dev/null 2>&1; then
  err "Docker no está instalado. Instalá Docker Desktop: https://www.docker.com/products/docker-desktop/"
  exit 1
fi
if ! docker info >/dev/null 2>&1; then
  err "Docker no está corriendo. Abrí Docker Desktop y volvé a intentar."
  exit 1
fi

# --- .env ------------------------------------------------------------------
[ -f .env ] || { info "Creando .env desde .env.example"; cp .env.example .env; }

OLLAMA_MODEL="$(grep -E '^OLLAMA_MODEL=' .env | tail -n1 | cut -d= -f2- | tr -d '[:space:]')"
OLLAMA_MODEL="${OLLAMA_MODEL:-qwen3:8b}"
export OLLAMA_MODEL

# --- Modo ------------------------------------------------------------------
OS="$(uname -s)"
MODE="${1:-}"
if [ -z "$MODE" ]; then
  [ "$OS" = "Darwin" ] && MODE="host" || MODE="bundled"
fi

echo ""
info "SO:      $OS"
info "Modo:    $MODE"
info "Modelo:  $OLLAMA_MODEL"
echo ""

if [ "$MODE" = "host" ]; then
  # =========================================================================
  # MODO HOST — Ollama nativo (recomendado en macOS)
  # =========================================================================
  if ! command -v ollama >/dev/null 2>&1; then
    err "Ollama no está instalado en el host."
    if [ "$OS" = "Darwin" ]; then
      echo "  brew install ollama      (o la app: https://ollama.com/download/mac)"
    else
      echo "  curl -fsSL https://ollama.com/install.sh | sh"
    fi
    exit 1
  fi

  # Ollama debe escuchar en 0.0.0.0 (no solo loopback) para que el contenedor
  # lo alcance via host.docker.internal. La app de Ollama por defecto bindea
  # SOLO 127.0.0.1 -> el contenedor recibiría "connection refused".
  ollama_on_all_ifaces() {
    if command -v lsof >/dev/null 2>&1; then
      lsof -nP -iTCP:11434 -sTCP:LISTEN 2>/dev/null | grep -Eq '(\*|0\.0\.0\.0):11434'
    else
      netstat -an 2>/dev/null | grep -i listen | grep -Eq '(\*|0\.0\.0\.0)[.:]11434'
    fi
  }

  if ! ollama_on_all_ifaces; then
    if curl -sf http://localhost:11434/api/tags >/dev/null 2>&1; then
      warn "Ollama escucha solo en loopback; el contenedor no podría alcanzarlo. Reiniciando en 0.0.0.0..."
      { [ "$OS" = "Darwin" ] && launchctl setenv OLLAMA_HOST 0.0.0.0:11434 2>/dev/null; } || true
      pkill -x ollama 2>/dev/null || pkill -f 'ollama serve' 2>/dev/null || true
      sleep 1
    fi
    info "Levantando Ollama (escuchando en 0.0.0.0:11434)..."
    OLLAMA_HOST=0.0.0.0:11434 nohup ollama serve >/tmp/ollama-hermes.log 2>&1 &
    OLLAMA_PID=$!
    disown "$OLLAMA_PID" 2>/dev/null || true
    info "Ollama en segundo plano (PID $OLLAMA_PID). Log: /tmp/ollama-hermes.log · detener: kill $OLLAMA_PID"
    for _ in $(seq 1 30); do
      ollama_on_all_ifaces && break
      sleep 1
    done
  fi
  if ! ollama_on_all_ifaces; then
    err "Ollama no quedó escuchando en 0.0.0.0:11434 (necesario para host.docker.internal)."
    err "En macOS: corré 'launchctl setenv OLLAMA_HOST 0.0.0.0:11434' y reiniciá la app de Ollama,"
    err "o cerrá la app de Ollama y volvé a correr este script."
    exit 1
  fi
  info "Ollama online en el host (0.0.0.0:11434)."

  info "Descargando modelo '$OLLAMA_MODEL' (si falta)..."
  ollama pull "$OLLAMA_MODEL"

  set_env_var "OPENAI_BASE_URL" "http://host.docker.internal:11434/v1"
  info "Lanzando wizard de Hermes..."
  docker compose run --rm hermes-setup

else
  # =========================================================================
  # MODO BUNDLED — Ollama dentro de Docker (Linux; también sirve en Windows
  # vía start.ps1)
  # =========================================================================
  COMPOSE=(-f docker-compose.yml)
  if command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi >/dev/null 2>&1; then
    info "GPU NVIDIA detectada -> probando passthrough a Docker..."
    # Que nvidia-smi ande NO garantiza que Docker pueda usar la GPU: hace falta el
    # NVIDIA Container Toolkit (Linux) o WSL2 con GPU (Windows). Probamos un
    # contenedor con --gpus all: si falla la selección de driver, caemos a CPU.
    if docker run --rm --gpus all --entrypoint true ollama/ollama:latest >/dev/null 2>&1; then
      info "Passthrough OK -> aceleración CUDA."
      COMPOSE+=(-f docker-compose.gpu.yml)
    else
      warn "GPU detectada pero Docker no puede usarla (falta NVIDIA Container Toolkit / WSL2 GPU) -> CPU."
    fi
  else
    warn "Sin GPU NVIDIA -> Ollama en CPU (más lento con modelos grandes)."
  fi

  set_env_var "OPENAI_BASE_URL" "http://ollama:11434/v1"

  info "Levantando Ollama en Docker..."
  docker compose "${COMPOSE[@]}" --profile bundled up -d ollama

  info "Descargando modelo '$OLLAMA_MODEL' (puede tardar varios minutos)..."
  docker compose "${COMPOSE[@]}" --profile bundled run --rm pull-model

  info "Lanzando wizard de Hermes..."
  docker compose "${COMPOSE[@]}" run --rm hermes-setup
fi

echo ""
info "Todo listo 🎉  Para chatear con Hermes:"
echo "    docker compose run --rm hermes"
