# AGENTS.md — Guía para agentes de IA

Este archivo es el **mapa operativo para un agente de IA** (Claude Code, Codex, Cursor o cualquiera) que esté corriendo **dentro de la carpeta de este repo**. Si un usuario te dice "instalámelo", "guiame" o "ponelo a andar", seguí esto al pie de la letra.

> 📖 El tutorial humano detallado vive en [`README.md`](./README.md). Cuando el usuario quiera pasos explicados para leer él, mandalo ahí. Este archivo es para **vos, el agente**.

---

## 🎯 Tu objetivo

Dejar a **Hermes + Ollama corriendo 100% local** en la máquina del usuario y el **chat abierto** en su terminal. Nada más. El repo entrega eso: el agente Hermes de Nous Research conectado a un modelo local servido por Ollama, charlando desde la terminal.

---

## 🧭 Cómo comportarte

- Hablá en **español simple y directo**. Asumí que el usuario puede no ser técnico.
- **Una cosa a la vez.** No tires 5 comandos juntos: explicá el paso, esperá, seguí.
- **No inventes comandos.** Usá solo lo que existe en este repo (los scripts de `scripts/`, `docker compose ...`, editar `.env`). Si dudás, leé el archivo antes de afirmar nada.
- **Sé honesto con los límites.** No prometas que "se hace todo solo". Hay tres cosas que vos NO podés hacer (ver más abajo) y tenés que decirlo claro y pasarle la posta al humano.
- **No alucines features.** Este repo NO arma Telegram, WhatsApp, Discord, Slack, mail, crons, memoria ni skills. Eso es del **agente Hermes de Nous Research** y se configura aparte → derivá a [nousresearch.com](https://nousresearch.com). Este repo solo entrega Hermes + Ollama local + chat en la terminal.
- Cuando algo falle, **leé el error real** (pedí que el humano te pegue lo que vio) y diagnosticá. No adivines.

---

## ✅ Lo que PODÉS ejecutar vos (agente)

Todo esto es **no interactivo** y seguro de correr en tu shell:

- **Detectar el sistema operativo** (`uname -s` en Mac/Linux, o saber que estás en Windows/PowerShell).
- **Chequear que Docker está corriendo:** `docker info`. Si falla, Docker no está abierto → frená (ver límites).
- **Chequear que el repo está completo** (que existan `docker-compose.yml`, `scripts/start.sh`, `.env.example`). Si el usuario no clonó bien, ayudalo a clonar.
- **Crear/leer/editar `.env`:**
  - Si no existe: `cp .env.example .env` (los scripts igual lo crean solos, pero podés adelantarlo).
  - Cambiar el modelo: editar la línea `OLLAMA_MODEL=` (por defecto `qwen3:8b`, ~5GB). Otros: `qwen3:14b` (~9GB), `llama3.1:8b` (~4.9GB), `hermes3` (~4.7GB).
  - No toques `OPENAI_BASE_URL` a mano: los scripts lo setean solos según el modo (Docker o host).
- **Montar una carpeta del host (workspace, opcional):** descomentar `WORKSPACE_PATH=./workspace` en `.env` **Y** la línea del volumen `- ${WORKSPACE_PATH:-./workspace}:/workspace` bajo el servicio `hermes` en `docker-compose.yml`.
- **Leer logs y errores y diagnosticar:** `docker compose ps`, `docker compose logs ollama`, leer la salida que el humano te pegue.

---

## 🛑 Lo que NO podés hacer — FRENÁ y pedíselo al humano

Hay tres cosas que un agente **no puede** resolver. Cuando llegues a una de estas, **pará, explicá qué falta y pedile al humano que lo haga él**:

1. **Instalar Docker Desktop y (en Mac) la app de Ollama.** Son **instaladores gráficos** (ventanas, aceptar términos, contraseña de administrador). Vos no clickeás ventanas. Pasale el link y esperá a que confirme que terminó:
   - Docker Desktop → https://www.docker.com/products/docker-desktop/
   - Ollama (Mac) → https://ollama.com/download/mac  ·  (Windows) → https://ollama.com/download/windows

2. **El inicio de sesión (OAuth) del asistente de configuración.** En el paso de setup, Hermes muestra una URL; el humano tiene que **abrirla en su navegador, iniciar sesión con su cuenta de Nous Research y autorizar**. Eso es sí o sí del humano.

3. **El asistente de configuración interactivo (apretar ENTER y elegir el modelo con las flechas).** Es una interfaz interactiva en la terminal (TUI). Hay que apretar ENTER para arrancar y mover con las **flechas** para elegir el modelo. Eso lo hace el humano.

### ⚠️ Lo más importante de todo

Los comandos **`start.sh` / `start.ps1` y `chat.sh` / `chat.ps1` son INTERACTIVOS** (esperan ENTER, muestran la URL del OAuth, abren el selector de modelo con flechas y arrancan el chat).

Si vos los corrés en un shell **capturado / sin terminal real** (como el Bash tool típico de un agente), esas partes **no funcionan**: no vas a poder apretar ENTER, ni ver bien la URL, ni mover las flechas, ni chatear.

👉 **Por eso esos comandos los corre EL HUMANO en su terminal visible.** Vos hacés la preparación (chequeos, clonar si falta, tocar `.env`/`docker-compose.yml`), le explicás exactamente qué va a pasar y qué tiene que hacer, y te quedás al lado para **leer los errores que te pegue y diagnosticar**.

---

## 📋 Guía paso a paso

Cada paso marca quién lo hace: **[AGENTE]** lo corrés vos · **[HUMANO]** se lo pedís a la persona.

### Paso 0 — Programas necesarios
- **[AGENTE]** Chequeá Docker: `docker info`.
  - Si responde OK → seguí.
  - Si dice que no está instalado o no corre → **[HUMANO]** pedile que **instale y abra Docker Desktop** (link arriba) y que avise cuando la ballena esté andando. Frená hasta entonces.
- **[AGENTE]** Si estás en **macOS**, chequeá Ollama nativo: `command -v ollama`.
  - En Mac, Ollama corre **nativo en el host** (Docker no puede usar la GPU Metal de Apple). Si falta → **[HUMANO]** pedile que instale la app de Ollama (https://ollama.com/download/mac) o `brew install ollama`. Sin esto, `start.sh` corta con *"Ollama no está instalado en el host"*.
  - En **Windows/Linux** no hace falta Ollama nativo: va dentro de Docker (modo "bundled"). En Windows con GPU NVIDIA hace falta Docker Desktop con backend WSL2.

### Paso 1 — Que el repo esté en su lugar
- **[AGENTE]** Verificá que estás dentro del repo y que están `docker-compose.yml` y `scripts/`. Si el usuario abrió el agente fuera de la carpeta o no clonó, ayudalo:
  ```bash
  git clone https://github.com/fcori47/dios-ia-hermes-local.git
  cd dios-ia-hermes-local
  ```

### Paso 2 — Preparar `.env` (opcional pero útil)
- **[AGENTE]** Si el usuario quiere otro modelo que no sea el `qwen3:8b` por defecto, creá `.env` (`cp .env.example .env`) y editá `OLLAMA_MODEL=`. Si no, dejá que los scripts lo creen solos.

### Paso 3 — Arranque + asistente de configuración  → **lo corre el HUMANO**
- **[AGENTE]** Explicale **antes** qué va a pasar para que no se asuste:
  1. El script detecta su SO y GPU, crea `.env` si falta, **descarga el modelo** (puede tardar varios minutos, `qwen3:8b` son ~5GB) y lanza el asistente de configuración.
  2. El asistente de configuración hace 4 chequeos. En el **[3/4]** Hermes va a **mostrar una URL** y a pedir **ENTER**: tiene que **abrir esa URL en el navegador, iniciar sesión en Nous Research y autorizar** (el navegador lo redirige a `http://localhost:8080`).
  3. En el **[4/4]** se abre un **selector de modelo**: que elija con las **flechas** y confirme con ENTER.
- **[HUMANO]** Que lo corra **en su terminal visible**:
  - **macOS / Linux:**
    ```bash
    bash scripts/start.sh
    ```
  - **Windows (PowerShell):**
    ```powershell
    powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1
    ```
- **[AGENTE]** Quedate disponible. Si algo falla, pedile que te **pegue el error** y diagnosticá (ej.: Docker apagado, Ollama que no responde, modelo que no terminó de bajar).

### Paso 4 — Chatear  → **lo corre el HUMANO**
- **[AGENTE]** Avisale que esto abre un **chat interactivo** en la terminal (también es interactivo, lo corre él).
- **[HUMANO]:**
  - **macOS / Linux:**
    ```bash
    bash scripts/chat.sh
    ```
  - **Windows (PowerShell):**
    ```powershell
    powershell -ExecutionPolicy Bypass -File .\scripts\chat.ps1
    ```

---

## 🔭 Cómo verificar que quedó andando

- **[AGENTE]** Verificá el modelo/Ollama, no un contenedor de Hermes. Los servicios `hermes` y `hermes-setup` corren con `docker compose run --rm` (efímeros: se borran al salir), así que **NO** queda ningún contenedor de Hermes en `docker compose ps` una vez que terminó el chat o el asistente. El único contenedor persistente es `ollama` (container_name `hermes-ollama`, `restart: unless-stopped`) y **solo en modo bundled** (Windows/Linux): ahí `docker compose ps` muestra `hermes-ollama`. En **modo host** (macOS) Ollama es nativo y **NO aparece** en `docker compose ps` → chequeá que el Ollama nativo responda.
- **[HUMANO]** La prueba real de que Hermes anda es que **abra el chat** (`chat.sh` / `chat.ps1`) y le escriba algo simple; si responde, está andando.
- Si montaron **workspace**: que le pida a Hermes listar archivos de `/workspace` y vea sus archivos del host.
- **No prometas más que eso.** Pedirle a Hermes que mande un Telegram, programe un cron o "se acuerde" de cosas **no va a andar** con este repo solo: eso necesita configuración extra del propio Hermes (ver abajo).

---

## 🆘 Si algo falla

1. **[AGENTE]** Pedile al humano el **error textual** y leelo. La mayoría son: Docker apagado (`docker info` falla), Ollama nativo no instalado/no escuchando en Mac, o el modelo que todavía está bajando.
2. Mandalo a la sección **[Problemas comunes](./README.md#-problemas-comunes)** del README.
3. Si nada alcanza, que **abra un issue**: https://github.com/fcori47/dios-ia-hermes-local/issues — con su SO, el comando que corrió y el error completo.

---

## 🚫 Lo que este repo NO hace (recordatorio honesto)

Este repo entrega **Hermes + Ollama local + chat en la terminal**. Punto.

**NO** configura Telegram, WhatsApp, Discord, Slack ni mail. **NO** arma crons ni tareas programadas. **NO** monta memoria ni skills.

Todo eso es **nativo del agente Hermes de Nous Research** y se configura por separado. Si el usuario lo pide, sé claro: *"Eso no lo hace este repo, es del propio Hermes"* → derivalo a **[nousresearch.com](https://nousresearch.com)**. No inventes pasos que acá no existen.
