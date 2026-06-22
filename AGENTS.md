# AGENTS.md — Guía para agentes de IA

Este archivo es el **mapa operativo para un agente de IA** (Claude Code, Codex, Cursor o cualquiera) que esté corriendo **dentro de la carpeta de este repo**. Si un usuario te dice "instalámelo", "guiame" o "ponelo a andar", seguí esto al pie de la letra.

> 📖 El tutorial humano detallado vive en [`README.md`](./README.md). Cuando el usuario quiera pasos explicados para leer él, mandalo ahí. Este archivo es para **vos, el agente**.

---

## 🎯 Tu objetivo

Dejar a **Hermes + Ollama corriendo 100% local** en la máquina del usuario y el **chat abierto** en su terminal. Nada más. El repo entrega eso: el agente Hermes de Nous Research conectado a un modelo local servido por Ollama, charlando desde la terminal.

> Este repo se maneja con **comandos `docker compose` directos** (no hay scripts de arranque). Vos podés correr los que NO son interactivos; el login, el selector de modelo y el chat los corre el humano.

---

## 🧭 Cómo comportarte

- Hablá en **español simple y directo**. Asumí que el usuario puede no ser técnico.
- **Una cosa a la vez.** No tires 5 comandos juntos: explicá el paso, esperá, seguí.
- **No inventes comandos.** Usá solo lo que existe en este repo: `docker compose ...` y editar `.env`. Si dudás, leé el archivo (`docker-compose.yml`, `.env.example`) antes de afirmar nada.
- **Sé honesto con los límites.** No prometas que "se hace todo solo". Hay cosas que vos NO podés hacer (ver más abajo) y tenés que decirlo claro y pasarle la posta al humano.
- **No alucines features.** Este repo NO arma Telegram, WhatsApp, Discord, Slack, mail, crons, memoria ni skills. Eso es del **agente Hermes de Nous Research** y se activa adentro de Hermes → derivá a [nousresearch.com](https://nousresearch.com). Este repo solo entrega Hermes + Ollama local + chat en la terminal.
- Cuando algo falle, **leé el error real** (pedí que el humano te pegue lo que vio) y diagnosticá. No adivines.

---

## ✅ Lo que PODÉS ejecutar vos (agente)

Todo esto es **no interactivo** y seguro de correr en tu shell:

- **Detectar el sistema operativo** (`uname -s` en Mac/Linux, o saber que estás en Windows/PowerShell).
- **Chequear que Docker está corriendo:** `docker info`. Si falla, Docker no está abierto → frená (ver límites).
- **Chequear que el repo está completo** (que existan `docker-compose.yml`, `Dockerfile.hermes`, `.env.example`). Si el usuario no clonó bien, ayudalo a clonar.
- **Crear/leer/editar `.env`:**
  - Si no existe: `cp .env.example .env` (Windows: `Copy-Item .env.example .env`).
  - Cambiar el modelo: editar la línea `OLLAMA_MODEL=` (por defecto `qwen3:8b`, ~5GB). Otros: `qwen3:14b` (~9GB), `llama3.1:8b` (~4.9GB), `hermes3` (~4.7GB).
  - **En macOS** (Ollama nativo), poné `OPENAI_BASE_URL=http://host.docker.internal:11434/v1`. En Windows/Linux dejá el default (`http://ollama:11434/v1`).
- **Levantar Ollama (Windows/Linux, modo bundled):** `docker compose --profile bundled up -d ollama` (con GPU NVIDIA: agregá `-f docker-compose.gpu.yml`).
- **Descargar el modelo (Windows/Linux):** `docker compose --profile bundled run --rm pull-model`.
- **Construir la imagen de Hermes:** `docker compose build hermes` (baja e instala Hermes; tarda la primera vez).
- **Montar una carpeta del host (workspace, opcional):** descomentar `WORKSPACE_PATH=./workspace` en `.env` **Y** la línea del volumen `- ${WORKSPACE_PATH:-./workspace}:/workspace` bajo el servicio `hermes` en `docker-compose.yml`.
- **Leer logs y diagnosticar:** `docker compose --profile bundled ps`, `docker compose --profile bundled logs ollama`, leer la salida que el humano te pegue.

---

## 🛑 Lo que NO podés hacer — FRENÁ y pedíselo al humano

Cuando llegues a una de estas, **pará, explicá qué falta y pedile al humano que lo haga él**:

1. **Instalar Docker Desktop y (en Mac) la app de Ollama.** Son **instaladores gráficos** (ventanas, aceptar términos, contraseña). Vos no clickeás ventanas. Pasale el link y esperá:
   - Docker Desktop → https://www.docker.com/products/docker-desktop/
   - Ollama (Mac) → https://ollama.com/download/mac

2. **El login (OAuth):** `docker compose run --rm --service-ports hermes "hermes setup --portal"`. Hermes muestra una URL; el humano tiene que **abrirla en su navegador, iniciar sesión en Nous Research y autorizar**. Es interactivo y online → del humano.

3. **El selector de modelo y el chat:** `docker compose run --rm hermes "hermes model"` (elegir con flechas + ENTER) y `docker compose run --rm hermes` (chat). Son interfaces interactivas en la terminal (TUI) → las corre el humano.

### ⚠️ Lo más importante de todo

Los comandos **`hermes setup --portal`, `hermes model` y `hermes chat`** (los `docker compose run --rm hermes ...`) son **INTERACTIVOS**: esperan ENTER, muestran la URL del OAuth, abren el selector con flechas y arrancan el chat.

Si vos los corrés en un shell **capturado / sin terminal real** (como el Bash tool típico de un agente), esas partes **no funcionan**: no vas a poder apretar ENTER, ver la URL, mover las flechas ni chatear.

👉 **Por eso esos `docker compose run --rm hermes ...` los corre EL HUMANO en su terminal visible.** Vos hacés la preparación (chequeos, clonar, tocar `.env`, levantar Ollama, bajar el modelo, `build`), le explicás qué va a pasar, y te quedás al lado para **leer los errores que te pegue y diagnosticar**.

---

## 📋 Guía paso a paso

Cada paso marca quién lo hace: **[AGENTE]** lo corrés vos · **[HUMANO]** se lo pedís a la persona.

### Paso 0 — Programas necesarios
- **[AGENTE]** Chequeá Docker: `docker info`.
  - OK → seguí. · No instalado/no corre → **[HUMANO]** que **instale y abra Docker Desktop** (link arriba) y avise cuando la ballena esté en *Running*. Frená hasta entonces.
- **[AGENTE]** Si estás en **macOS**, chequeá Ollama nativo: `command -v ollama`.
  - En Mac, Ollama corre **nativo en el host** (Docker no puede usar la GPU Metal). Si falta → **[HUMANO]** que instale la app (https://ollama.com/download/mac) o `brew install ollama`, la abra, y corra `launchctl setenv OLLAMA_HOST 0.0.0.0:11434` + reabra Ollama (para que el contenedor lo alcance).
  - En **Windows/Linux** no hace falta Ollama nativo: va dentro de Docker (modo "bundled"). Con GPU NVIDIA hace falta Docker Desktop con backend WSL2.

### Paso 1 — Que el repo esté en su lugar
- **[AGENTE]** Verificá que estás dentro del repo y que están `docker-compose.yml` y `Dockerfile.hermes`. Si no clonó:
  ```bash
  git clone https://github.com/fcori47/dios-ia-hermes-local.git
  cd dios-ia-hermes-local
  ```

### Paso 2 — Preparar y bajar todo  → **[AGENTE]** (no interactivo)
- **[AGENTE]** `cp .env.example .env` (Windows: `Copy-Item .env.example .env`). Si el usuario quiere otro modelo, editá `OLLAMA_MODEL=`. En **Mac**, poné también `OPENAI_BASE_URL=http://host.docker.internal:11434/v1`.
- **[AGENTE] Windows/Linux:**
  ```bash
  docker compose --profile bundled up -d ollama          # + -f docker-compose.gpu.yml si hay GPU NVIDIA
  docker compose --profile bundled run --rm pull-model    # baja el modelo (~5GB, tarda)
  docker compose build hermes                             # baja e instala Hermes (tarda)
  ```
- **[AGENTE] macOS:** pedí al humano que tenga Ollama abierto, y corré `docker compose build hermes`. El modelo lo baja el humano con `ollama pull qwen3:8b` (Ollama es nativo).

### Paso 3 — Login + elegir modelo  → **lo corre el HUMANO** (interactivo)
- **[AGENTE]** Explicale antes: el login abre una URL que tiene que autorizar en el navegador (Nous Research); después un selector de modelo con flechas.
- **[HUMANO]** en su terminal visible:
  ```bash
  docker compose run --rm --service-ports hermes "hermes setup --portal"   # login (autoriza en el navegador)
  docker compose run --rm hermes "hermes model"                            # elegir el modelo (flechas + ENTER)
  ```
- **[AGENTE]** Si da `port is already allocated` (8080 ocupado): editá `.env` → `HERMES_OAUTH_PORT=8081` y que reintente el login. Si falla otra cosa, pedí el error y diagnosticá.

### Paso 4 — Chatear  → **lo corre el HUMANO** (interactivo)
- **[HUMANO]:**
  ```bash
  docker compose run --rm hermes
  ```
  *(En Windows/Linux, si antes hizo `docker compose down`, primero `docker compose --profile bundled up -d ollama`.)*

---

## 🔭 Cómo verificar que quedó andando

- **[AGENTE]** El servicio `hermes` corre con `docker compose run --rm` (efímero: se borra al salir), así que **NO** queda contenedor de Hermes en `docker compose ps`. El único persistente es `ollama` (container_name `hermes-ollama`, `restart: unless-stopped`) y **solo en modo bundled** (Windows/Linux): ahí `docker compose --profile bundled ps` muestra `hermes-ollama`. En **modo host** (macOS) Ollama es nativo y **NO aparece** en `docker compose ps` → chequeá que el Ollama nativo responda (`curl http://localhost:11434/api/tags`).
- **[HUMANO]** La prueba real es que **abra el chat** (`docker compose run --rm hermes`) y escriba algo simple; si responde, anda.
- Si montaron **workspace**: que le pida a Hermes listar `/workspace`.
- **No prometas más que eso.** Telegram, crons o memoria **no andan** con este repo solo: son del propio Hermes (ver abajo).

---

## 🆘 Si algo falla

1. **[AGENTE]** Pedí el **error textual** y leelo. La mayoría: Docker apagado (`docker info` falla), puerto 8080 ocupado (`HERMES_OAUTH_PORT=8081`), Ollama nativo no escuchando en Mac, o el modelo todavía bajando.
2. Mandalo a **[Problemas comunes](./README.md#-problemas-comunes)** del README.
3. Si nada alcanza, que **abra un issue**: https://github.com/fcori47/dios-ia-hermes-local/issues — con su SO, el comando y el error completo.

---

## 🚫 Lo que este repo NO hace (recordatorio honesto)

Este repo entrega **Hermes + Ollama local + chat en la terminal**. Punto.

**NO** configura Telegram, WhatsApp, Discord, Slack ni mail. **NO** arma crons ni tareas programadas. **NO** monta memoria ni skills.

Todo eso es **nativo del agente Hermes de Nous Research** y se activa por separado. Si el usuario lo pide, sé claro: *"Eso no lo hace este repo, es del propio Hermes"* → derivalo a **[nousresearch.com](https://nousresearch.com)**. No inventes pasos que acá no existen.
