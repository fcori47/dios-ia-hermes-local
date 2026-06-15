#!/usr/bin/env bash
# Wizard de primer arranque de Hermes Agent (Hermes + Ollama).
# Uso:  docker compose run --rm hermes-setup
set -euo pipefail

OLLAMA_BASE=$(echo "${OPENAI_BASE_URL:-http://ollama:11434/v1}" | sed 's|/v1$||')
HERMES_MODEL="${HERMES_MODEL:-qwen3:8b}"
HERMES_HOME="${HERMES_HOME:-/hermes-config}"
OAUTH_PORT="${HERMES_OAUTH_PORT:-8080}"

mkdir -p "${HERMES_HOME}"

cat <<'BANNER'
================================================================
       Hermes AI Agent -- Wizard de Primer Arranque
================================================================
BANNER

echo ""
echo "Config de Hermes: ${HERMES_HOME}"
echo "Ollama en:        ${OLLAMA_BASE}"
echo "Modelo:           ${HERMES_MODEL}"
echo ""

# --------------------------------------------------------------------------
# 1. Verificar que Ollama responda
# --------------------------------------------------------------------------
echo "[ 1/4 ] Verificando conexión con Ollama..."
TAGS=$(curl -sf "${OLLAMA_BASE}/api/tags" 2>/dev/null || echo "")
if [ -z "$TAGS" ]; then
    echo ""
    echo "ERROR: No se puede conectar con Ollama en ${OLLAMA_BASE}"
    echo ""
    echo "  Si Ollama corre en Docker (Windows/Linux):"
    echo "    docker compose --profile bundled up -d ollama"
    echo "    docker compose --profile bundled logs ollama"
    echo ""
    echo "  Si Ollama corre nativo en el host (macOS):"
    echo "    - Abrí la app de Ollama (o corré 'ollama serve')."
    echo "    - Si sigue fallando, exportá  OLLAMA_HOST=0.0.0.0:11434  y reiniciá Ollama"
    echo "      para que el contenedor lo pueda alcanzar via host.docker.internal."
    exit 1
fi
echo "       Ollama online."
echo ""

# --------------------------------------------------------------------------
# 2. Verificar que el modelo esté descargado
# --------------------------------------------------------------------------
echo "[ 2/4 ] Verificando modelo '${HERMES_MODEL}'..."
if echo "$TAGS" | grep -Fq "\"${HERMES_MODEL}\"" 2>/dev/null || echo "$TAGS" | grep -Fq "\"${HERMES_MODEL}:" 2>/dev/null; then
    echo "       Modelo disponible."
else
    echo ""
    echo "ADVERTENCIA: '${HERMES_MODEL}' no aparece en Ollama todavía."
    echo "  Descargalo con:"
    echo "    Docker:  docker compose --profile bundled run --rm pull-model"
    echo "    Host:    ollama pull ${HERMES_MODEL}"
    echo ""
    read -rp "¿Continuar igual? [s/N] " confirm
    if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
        echo "Setup cancelado. Descargá el modelo primero."
        exit 1
    fi
fi
echo ""

# --------------------------------------------------------------------------
# 3. Setup / login de Hermes (OAuth portal)
# --------------------------------------------------------------------------
echo "[ 3/4 ] Setup de Hermes..."
echo ""
echo "================================================================"
echo "  IMPORTANTE: instrucciones del OAuth / Portal Login"
echo ""
echo "  Hermes va a mostrar una URL en esta terminal."
echo "  Abrila en el BROWSER DEL HOST (no dentro de Docker)."
echo ""
echo "  Tras autorizar, el browser redirige a:"
echo "    http://localhost:${OAUTH_PORT}"
echo "  Ese puerto está forwardeado del contenedor al host."
echo ""
echo "  Si la redirección falla, copiá la URL completa del browser"
echo "  y pegala acá cuando se pida."
echo "================================================================"
echo ""
read -rp "Presioná ENTER para iniciar el wizard de Hermes..."
echo ""

hermes setup --portal

echo ""
echo "       Setup de Hermes completado."
echo ""

# --------------------------------------------------------------------------
# 4. Selección de modelo
# --------------------------------------------------------------------------
echo "[ 4/4 ] Configurando modelo..."
echo ""
echo "Se abre 'hermes model' -- seleccioná '${HERMES_MODEL}' de la lista."
echo "(Flechas para navegar, ENTER para seleccionar)"
echo ""
read -rp "Presioná ENTER para abrir el selector de modelo..."
echo ""

hermes model

echo ""
cat <<'DONE'
================================================================
  Setup completado. Cómo usar Hermes:

  Chatear:
    docker compose run --rm hermes

  Abrir una shell dentro del contenedor:
    docker compose run --rm --entrypoint bash hermes

  Dar acceso a una carpeta del host:
    1. .env: descomentar WORKSPACE_PATH=./workspace (o tu ruta)
    2. docker-compose.yml: descomentar la línea del volumen
       workspace bajo el servicio 'hermes'
    3. docker compose run --rm hermes  ->  archivos en /workspace

  Repetir este setup:
    docker compose run --rm hermes-setup
================================================================
DONE
