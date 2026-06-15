#!/usr/bin/env bash
# Abre un chat con Hermes. Se asegura de que Ollama esté arriba según el modo.
#   macOS / Linux:  ./scripts/chat.sh
set -euo pipefail
cd "$(dirname "$0")/.."

[ -f .env ] || cp .env.example .env

# En modo "bundled" (Ollama en Docker) hay que levantarlo si no está corriendo.
# En modo "host" (macOS) OPENAI_BASE_URL apunta a host.docker.internal -> no hace falta.
if grep -qE '^OPENAI_BASE_URL=http://ollama:' .env 2>/dev/null; then
  docker compose --profile bundled up -d ollama
fi

docker compose run --rm hermes
