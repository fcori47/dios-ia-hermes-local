#!/usr/bin/env bash
# Abre un chat con Hermes. Se asegura de que Ollama esté arriba según el modo.
#   macOS / Linux:  ./scripts/chat.sh
set -euo pipefail
cd "$(dirname "$0")/.."

[ -f .env ] || cp .env.example .env

# Modo "bundled" (Ollama en Docker): levantarlo si no está corriendo.
if grep -qE '^OPENAI_BASE_URL=http://ollama:' .env 2>/dev/null; then
  docker compose --profile bundled up -d ollama
else
  # Modo "host" (macOS): asegurar que Ollama nativo escuche en 0.0.0.0 (lo que el
  # contenedor necesita). Si no, delegamos en start.sh, que lo reinicia bien.
  if command -v lsof >/dev/null 2>&1 \
     && ! lsof -nP -iTCP:11434 -sTCP:LISTEN 2>/dev/null | grep -Eq '(\*|0\.0\.0\.0):11434'; then
    exec bash "$(dirname "$0")/start.sh" host
  fi
fi

docker compose run --rm hermes
