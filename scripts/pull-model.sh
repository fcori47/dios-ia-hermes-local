#!/usr/bin/env bash
# Descarga el modelo de Ollama (host o contenedor).
# - En modo "bundled" lo invoca el servicio pull-model del docker-compose.
# - En modo "host" (macOS) lo llama el script start.sh sobre el Ollama nativo.
#
# Uso directo:  OLLAMA_MODEL=qwen3:8b ./scripts/pull-model.sh
set -euo pipefail

MODEL="${OLLAMA_MODEL:-qwen3:8b}"

echo ">>> Descargando modelo: ${MODEL}"
echo "    Puede tardar varios minutos (qwen3:8b ~5GB). No interrumpir."
echo ""

# El CLI de ollama respeta OLLAMA_HOST (ej: 'ollama:11434' dentro de Docker,
# o el default 127.0.0.1:11434 en el host).
ollama pull "${MODEL}"

echo ""
echo ">>> Modelo '${MODEL}' listo."
