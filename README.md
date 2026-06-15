# Hermes + Ollama en local con Docker 🐳🤖

Corré el agente de IA **[Hermes](https://nousresearch.com/)** (de Nous Research) con un modelo de lenguaje **que se ejecuta en tu propia computadora** gracias a **[Ollama](https://ollama.com/)**. Tus conversaciones se procesan **localmente**, sin pagar por uso de API.

> _(Ojo: la **instalación** sí necesita internet una vez — para bajar el modelo (~5 GB) y hacer el login inicial de Hermes. Después, la IA responde en tu máquina. Más detalle en [Privacidad y costo](#-privacidad-y-costo).)_

> 📺 **Video del tutorial:** _(pegá acá el link de YouTube cuando lo subas)_

✅ Funciona en **Windows** y **macOS** (y Linux). No hace falta saber programar: vas a **copiar y pegar** unos pocos comandos. Te explico cada paso y qué vas a ver en pantalla.

---

## 🧠 ¿Qué es cada cosa? (en 30 segundos)

- **Docker** — un programa que corre aplicaciones dentro de "cajas" aisladas (contenedores), así no instalás mil cosas a mano. Se instala una vez.
- **Ollama** — el motor que descarga y ejecuta el modelo de IA en tu máquina.
- **Hermes** — el agente con el que vas a chatear (usa el modelo que sirve Ollama).
- **El modelo** — el "cerebro". Por defecto usamos `qwen3:8b` (liviano, ~5 GB). Se cambia con **una sola variable**.
- **Puerto** — un número (como `11434`) por donde dos programas se hablan dentro de tu PC. Si el README menciona uno, no tenés que tocar nada.

---

## ✅ Antes de empezar: requisitos

| | |
|---|---|
| 💾 **Espacio en disco** | **~15 GB libres** (modelo `qwen3:8b` ~5 GB + imágenes de Docker ~3-5 GB + margen). Docker Desktop ocupa su propio espacio aparte. |
| 🧠 **Memoria (RAM)** | 8 GB mínimo |
| 🖥️ **Sistema** | Windows 10/11, o macOS (Apple Silicon M1 o más nuevo recomendado) |
| 🎮 **Placa de video (GPU)** | **Opcional.** NVIDIA (Windows) o Apple Silicon (Mac) hacen que vaya más rápido. Sin GPU también funciona, más lento. |

---

## 🧩 Paso 0 — Instalar los programas necesarios

Hacé esto **una sola vez**. Elegí tu sistema operativo 👇

<details open>
<summary><b>🪟 Windows</b></summary>

<br>

**1. Docker Desktop** — el programa principal.
- Descargalo: **https://www.docker.com/products/docker-desktop/** → *Download for Windows*.
- Instalalo (siguiente, siguiente, finalizar). Si te pregunta por **WSL 2** (un componente de Windows que Docker necesita), aceptá. Si Windows te muestra una ventana azul de control de cuentas preguntando si permitís cambios, tocá **Sí**.
- **Quizás tengas que reiniciar la PC** una vez para que WSL 2 quede activo. Es normal.
- **Abrí Docker Desktop.** La primera vez te pide aceptar los términos (**Accept**). Si aparece una pantalla para iniciar sesión o crear cuenta, **NO hace falta**: tocá **"Continue without signing in"** (o **Skip**).
- Esperá a que el ícono de la ballena 🐳 deje de moverse y diga **"Running"** (ese cartelito está **abajo a la izquierda**, es chiquito; la ballena también queda en la **bandeja del sistema**, al lado del reloj, a veces detrás de la flechita **^**). **Dejá Docker Desktop abierto.**

**2. Git** — para descargar el proyecto.
- Descargalo: **https://git-scm.com/download/win** (se instala solo con las opciones por defecto).
- *(Si no querés instalar Git, en el Paso 1 te muestro cómo bajarlo como ZIP.)*

> En Windows **no** instales Ollama aparte: corre solo, dentro de Docker.

**Cómo abrir la terminal (PowerShell):** apretá la tecla **Windows**, escribí `PowerShell`, y abrí *Windows PowerShell*.

</details>

<details>
<summary><b>🍏 macOS</b></summary>

<br>

**1. Docker Desktop** — el programa principal.
- Descargalo: **https://www.docker.com/products/docker-desktop/** → *Download for Mac*.
  - **¿No sabés qué Mac tenés?** Menú **Apple () arriba a la izquierda → Acerca de esta Mac**. Si dice **"Chip Apple M1/M2/M3/M4…"**, elegí **Apple Silicon**. Si dice **"Procesador Intel"**, elegí **Intel**.
- Instalalo (arrastrá Docker a *Aplicaciones*) y **abrilo**. Al arrancar te puede pedir tu **contraseña de Mac** para terminar de instalarse: es normal. Esperá a que diga **"Running"**. Dejalo abierto.

**2. Ollama** — el motor del modelo (en Mac corre nativo para usar la GPU de Apple).
- Descargalo: **https://ollama.com/download/mac** e instalá la app. **Abrila una vez** (instala el comando `ollama` que usa el script del Paso 2).
  - Ollama **no abre ninguna ventana**: aparece un ícono de llama 🦙 arriba a la derecha, en la **barra de menú**. Si lo ves ahí, está corriendo.
  - **Dejá Ollama abierto mientras uses Hermes.**

**3. Git** — para descargar el proyecto.
- Abrí la Terminal y escribí `git`. Si no lo tenés, macOS te ofrece instalarlo solo. *(O bajá el ZIP, ver Paso 1.)*

> 🔐 **Avisos de seguridad de macOS (son normales):** la primera vez que abrís Docker u Ollama, macOS puede decir *"…no se puede abrir porque Apple no puede comprobar…"*. Hacé clic en **Abrir**. Si no aparece el botón, andá a **Ajustes del Sistema → Privacidad y seguridad**, bajá hasta el aviso de la app y tocá **Abrir igualmente**.

**Cómo abrir la terminal (Terminal):** apretá **Cmd + Espacio**, escribí `Terminal`, y abrila.

</details>

---

## 📥 Paso 1 — Descargar el proyecto

En la terminal, pegá esto:

```bash
git clone https://github.com/fcori47/dios-ia-hermes-local.git
cd dios-ia-hermes-local
```

> 📁 Esto crea la carpeta `dios-ia-hermes-local` dentro de tu carpeta de usuario (`C:\Users\TU-USUARIO` en Windows, o tu carpeta personal en Mac). El comando `cd` te mete **adentro** de esa carpeta: **todos los pasos siguientes se corren desde ahí**.

<details>
<summary><b>¿No tenés Git? Descargalo como ZIP (alternativa sin Git)</b></summary>

<br>

1. Entrá a **https://github.com/fcori47/dios-ia-hermes-local**
2. Botón verde **`< > Code`** → **Download ZIP**.
3. Clic derecho en el ZIP → **Extraer todo…** → **Extraer**.
4. Entrá a la carpeta que se creó. **Ojo:** a veces queda una carpeta dentro de otra con el mismo nombre. Seguí entrando hasta ver adentro el archivo `docker-compose.yml` y la carpeta `scripts`. **Esa** es la carpeta correcta.
5. Con esa carpeta abierta en el explorador, copiá la ruta de la barra de direcciones, y en la terminal escribí `cd ` (con un espacio) y pegá la ruta entre comillas. Ejemplo:
   ```powershell
   cd "C:\Users\TuUsuario\Downloads\dios-ia-hermes-local-main\dios-ia-hermes-local-main"
   ```
6. Verificá que estás bien: `dir` (Windows) o `ls` (Mac) tiene que mostrar `docker-compose.yml` y la carpeta `scripts`.

</details>

---

## 🚀 Paso 2 — Arrancar (descarga el modelo y prepara todo)

> Asegurate de que **Docker Desktop esté abierto y "Running"** antes de seguir.

**🪟 Windows** (en PowerShell):
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1
```

**🍏 macOS / Linux** (en Terminal):
```bash
bash scripts/start.sh
```

Esto trabaja solo: detecta tu sistema y tu placa de video, descarga el modelo y deja todo listo.

> ⏳ **La primera vez tarda (10 a 40 minutos, según tu internet y tu PC).** Vas a ver **muchísimo texto en inglés** pasando por la pantalla, más o menos en este orden:
> 1. Docker baja el motor de Ollama (`Pulling…`, `Downloading`).
> 2. Se **descarga el modelo (~5 GB)**. Vas a ver una barra con porcentaje y velocidad, tipo `pulling … 42% ▕███▏ 2.1 GB/5.0 GB`. **Mientras el número suba, está todo bien, aunque vaya lento.**
> 3. Docker **construye la app de Hermes**: líneas que empiezan con `#1`, `#2`…, y palabras como `apt-get`, `Installing`.
>
> **TODO ESTO ES NORMAL, no es un error.** No cierres la ventana aunque parezca que no pasa nada por varios minutos.

> 🔌 **¿Se cortó la descarga?** Si cerraste la terminal sin querer, se cayó internet o se apagó la PC, **no perdiste lo descargado**. Volvé a correr el comando de arriba y la descarga continúa desde donde quedó. Podés repetirlo las veces que haga falta.

> ✅ **¿Cómo sabés que va bien?** Cuando termina, en la **misma ventana** aparece automáticamente el asistente de Hermes con este cartel:
> ```
> ================================================================
>        Hermes AI Agent -- Wizard de Primer Arranque
> ================================================================
> ```
> 🟢 **Importante:** el asistente se queda **esperando que vos aprietes una tecla** (vas a ver *"Presioná ENTER…"*). **No cierres nada ni escribas otro comando** — seguí directo con el **Paso 3** acá mismo. Si te alejaste durante la descarga, al volver lo vas a encontrar esperándote.

---

## 🔑 Paso 3 — Iniciar sesión en Hermes y elegir el modelo

Esto sigue en la **misma terminal del Paso 2** (no hay que escribir ningún comando nuevo). El asistente avanza en 4 pasitos (`[1/4]`…`[4/4]`) y te va a pedir dos cosas:

1. **Iniciar sesión (cuenta de Nous Research — este paso usa internet, es la única parte online):**
   - Primero el asistente te pide **apretar ENTER** para empezar. Recién **después de ENTER** aparece una **dirección web (URL)** en la terminal.
   - **Para copiar la URL:** seleccionala con el mouse y **Ctrl+C** (o clic derecho). Abrila en tu navegador con **Ctrl+V**.
   - **Creá tu cuenta o iniciá sesión en Nous Research** y **autorizá**. Cuando el navegador te lleve a una página tipo `http://localhost:8080`, **salió bien**: cerrá esa pestaña y volvé a la terminal.
2. **Elegir el modelo:** se abre una lista. Movete con las **flechas** y elegí **`qwen3:8b`** con **ENTER**.

> ℹ️ Si en algún momento te pregunta **`¿Continuar igual? [s/N]`**, significa que el modelo no terminó de descargarse. Escribí **`s`** y ENTER, o cancelá con **`n`**, esperá que termine el Paso 2 y reintentá. (Si apretás ENTER sin escribir nada, cancela.)

> 💡 **¿Se traba o querés cortar?** En cualquier momento podés cancelar lo que corre en la terminal con **Ctrl + C**, y volver a empezar con el comando del Paso 2 (no rompe nada).

Cuando aparezca **`Setup completado`** y luego **`Todo listo`**, ya está. 🎉

---

## 💬 Paso 4 — Chatear con Hermes

Primero, **abrí la terminal y entrá a la carpeta del proyecto**. Si abriste una terminal nueva (por ejemplo, volvés al otro día), pegá esto antes que nada:

```bash
cd dios-ia-hermes-local
```
*(Si la bajaste como ZIP, entrá a la carpeta donde la descomprimiste.)*

Después, abrí el chat:

**🪟 Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\chat.ps1
```

**🍏 macOS / Linux:**
```bash
bash scripts/chat.sh
```

> El chat vive **dentro de esta ventana de terminal**: escribí tu mensaje y apretá **ENTER**. La **primera respuesta de cada sesión puede tardar unos segundos** mientras se carga el modelo (aunque parezca colgado, esperá). Ejemplo:
> ```
> > Hola, ¿quién sos?
> Soy Hermes, tu agente de IA corriendo en local…
> ```
> Para **salir**, escribí `exit` y ENTER (o **Ctrl + C**).

> ⚠️ El chat solo funciona **después** de haber hecho el **Paso 2** (descarga del modelo) y el **Paso 3** (login) al menos una vez. El chat **no** descarga el modelo ni hace el login por vos.

> 💡 **Windows/Linux:** salir del chat **no apaga** Ollama (queda en segundo plano para que el próximo chat arranque al toque). Para liberar esa memoria, corré `docker compose down`.
> **macOS:** mantené la app de **Ollama** abierta. Si reiniciaste la Mac o cerraste Ollama, antes de chatear volvé a correr `bash scripts/start.sh`.

---

## 🔧 Cambiar el modelo de IA

El modelo se elige con **una sola línea** en el archivo `.env` (se crea solo la primera vez que arrancás):

```dotenv
OLLAMA_MODEL=qwen3:8b
```

Cambiá ese valor por cualquier modelo de **[ollama.com/library](https://ollama.com/library)**:

| Modelo | Tamaño | Para qué |
|---|---|---|
| `qwen3:8b` | ~5 GB | Liviano, anda en casi cualquier PC **(default)** |
| `qwen3:14b` | ~9 GB | Mejor calidad, necesita una PC/GPU decente |
| `qwen3:30b` | ~19 GB | Muy capaz, pesado (mucha RAM/GPU) |
| `hermes3` | ~4.7 GB | El modelo Hermes de Nous Research |
| `llama3.1:8b` | ~4.9 GB | Alternativa popular |

Después de cambiarlo, volvé a correr el comando del **Paso 2** para descargar el nuevo modelo y seleccionarlo.

**¿Querés la versión más nueva del mismo modelo?** Volvé a correr el Paso 2 sin cambiar nada: vuelve a descargar (`pull`) la última versión.

**Borrar un modelo viejo (liberar espacio).** Cada modelo que probás deja sus GB guardados. Para borrar solo uno:
```bash
# Windows / Linux (Ollama en Docker):
docker compose --profile bundled exec ollama ollama rm <modelo>
# macOS (Ollama nativo):
ollama rm <modelo>
```
Reemplazá `<modelo>` por el nombre exacto (ej. `qwen3:14b`). Para ver los descargados: `... ollama list`.

---

## 🧠 Cómo funciona (para curiosos)

```
┌──────────── Windows / Linux ────────────┐     ┌──────────────── macOS ───────────────────┐
│  ┌─────────┐        ┌──────────────────┐ │     │  ┌─────────┐         ┌───────────────────┐│
│  │ hermes  │ ─────▶ │ ollama (Docker)  │ │     │  │ hermes  │ ──────▶ │ ollama (NATIVO)   ││
│  │ (Docker)│        │ GPU NVIDIA o CPU │ │     │  │ (Docker)│         │ usa la GPU Metal  ││
│  └─────────┘        └──────────────────┘ │     │  └─────────┘         └───────────────────┘│
└──────────────────────────────────────────┘     └───────────────────────────────────────────┘
```

**¿Por qué en Mac es distinto?** Docker en macOS no puede usar la GPU de Apple. Si Ollama corriera dentro de Docker en una Mac, iría lentísimo (solo CPU). Por eso en Mac Ollama corre nativo (usa la GPU) y solo Hermes va en Docker. **Los scripts resuelven todo esto solos.**

---

## 📂 Qué hay en el repo

```
.
├── docker-compose.yml        # Define los servicios (ollama, hermes, ...)
├── docker-compose.gpu.yml    # Activa la GPU NVIDIA (se usa solo si hay)
├── Dockerfile.hermes         # Imagen del agente Hermes
├── .env.example              # Variables (la principal: OLLAMA_MODEL)
└── scripts/
    ├── start.sh / start.ps1  # Arranque con auto-detección (macOS·Linux / Windows)
    ├── chat.sh  / chat.ps1   # Abrir el chat (Win/Linux levanta Ollama solo; Mac: tené la app abierta)
    ├── pull-model.sh         # Descarga del modelo
    └── setup-hermes.sh       # Asistente de primer arranque
```

---

## 🧰 Comandos útiles

> Todos estos se corren **desde adentro de la carpeta del proyecto**. Si abriste una terminal nueva, primero hacé `cd dios-ia-hermes-local`.

**Chatear** (levanta Ollama si hace falta):
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\chat.ps1   # Windows
```
```bash
bash scripts/chat.sh                                          # macOS / Linux
```

**Repetir el asistente** (login / elegir modelo) — volvé a correr el Paso 2, que levanta Ollama y reabre el asistente:
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1   # Windows
```
```bash
bash scripts/start.sh                                          # macOS / Linux
```

**Otros** (funcionan igual en Windows y Mac):
```bash
docker compose ps                          # ver qué está corriendo
docker compose run --rm --entrypoint bash hermes   # abrir una terminal dentro de Hermes
docker compose down                        # parar todo (datos y modelo quedan guardados)
docker compose down -v                     # parar y BORRAR el modelo + config (las imágenes quedan)
```
> Salir del chat (`exit`) **no** apaga Ollama: en Windows/Linux sigue en segundo plano. Para liberar la RAM, usá `docker compose down`.

---

## 📎 Darle a Hermes acceso a una carpeta tuya (opcional)

1. En `.env`, descomentá y ajustá la ruta:
   ```dotenv
   WORKSPACE_PATH=./workspace          # o una ruta de tu PC
   ```
2. En `docker-compose.yml`, descomentá la línea del volumen bajo el servicio `hermes`:
   ```yaml
   - ${WORKSPACE_PATH:-./workspace}:/workspace
   ```
3. Volvé a abrir el chat → tus archivos están en `/workspace` dentro de Hermes.

---

## 🔒 Privacidad y costo

- **¿Necesito internet?** Sí, **una sola vez** para: descargar el proyecto, bajar el modelo (~5 GB) y activar tu cuenta de Hermes (el login del Paso 3). Después, la IA (el modelo) corre en tu propia máquina vía Ollama.
- **¿Por qué me pide "iniciar sesión" si es local?** Ese login es para activar tu cuenta de **Hermes** (el agente de Nous Research), no para mandar el modelo a la nube. Las respuestas las genera el modelo local de Ollama en tu PC.
- **¿Tiene costo?** No pagás por uso del modelo local: corre en tu hardware. Si la cuenta de Hermes tuviera algún costo o límite, verificalo en [nousresearch.com](https://nousresearch.com/).
- **¿Querés saber exactamente qué datos maneja la cuenta de Hermes** (login, telemetría)? Revisá los términos/privacidad en [nousresearch.com](https://nousresearch.com/).

---

## 🗑️ Desinstalar / liberar espacio

Parados en la carpeta del proyecto:

```bash
# 1) Borrar el modelo descargado y la config (los volúmenes)
docker compose down -v

# 2) Borrar las imágenes de Docker (esto es lo que ocupa varios GB y NO lo borra el paso 1)
docker rmi hermes-agent:local ollama/ollama:latest ubuntu:22.04
```
3. Borrá la carpeta del proyecto.
4. (Opcional) Si no vas a usar más Docker/Ollama, desinstalá **Docker Desktop**, y en Mac también la app de **Ollama**.

> ⚠️ `docker compose down -v` **no** borra las imágenes: sin el paso 2 te quedan varios GB ocupados.

---

## 🩺 Problemas comunes

**"Docker no está corriendo"** → Abrí **Docker Desktop** y esperá a que diga *Running*. Después reintentá.

**Windows: Docker no arranca / pide WSL 2 o "WSL kernel version too low"** → Reiniciá la PC una vez. Si sigue, abrí PowerShell y corré `wsl --update`, después reabrí Docker Desktop.

**Windows: `start.ps1 cannot be loaded because running scripts is disabled`** → Usá siempre el comando completo: `powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1` (no cambia nada en tu PC). Si bajaste el ZIP y dice *"is not digitally signed"*, desbloquealo: `Unblock-File .\scripts\start.ps1`.

**Mac: el chat dice que no puede conectar con Ollama** → Casi siempre es porque la app de Ollama volvió a escuchar solo en `127.0.0.1`. Lo más fácil: volvé a correr `bash scripts/start.sh` y después chateá. A mano: (1) cerrá Ollama (ícono en la barra de menú → **Quit**), (2) pegá `launchctl setenv OLLAMA_HOST 0.0.0.0:11434` (no necesitás entenderlo: le dice a Ollama que acepte conexiones desde Docker), (3) reabrí la app de Ollama, (4) reintentá.

**Mac: "Ollama no está instalado en el host"** → Abrí la app de Ollama una vez (instala el comando), después **cerrá y reabrí la Terminal**, volvé a entrar a la carpeta (`cd dios-ia-hermes-local`) y reintentá el Paso 2. Si sigue: `brew install ollama`.

**`could not select device driver "nvidia"`** → Tenés GPU NVIDIA pero Docker todavía no la puede usar. En Windows: actualizá Docker Desktop y activá **WSL2**. En Linux: instalá el [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html). Igual el script cae a CPU solo y sigue funcionando.

**Windows/Linux: `port is already allocated`** → Ya tenés otro Ollama usando el puerto 11434. No pasa nada: el contenedor no lo necesita publicado. Si querés, poné `OLLAMA_HOST_PORT=11435` en `.env`.

**Windows: ya tengo Ollama instalado y no quiero bajar el modelo dos veces** → Usá tu Ollama nativo (abierto y corriendo) con: `powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1 host`. Así Hermes le pega a ese Ollama y no descarga otra copia del modelo dentro de Docker.

**El login se queda esperando / "puerto 8080 ocupado"** → Otro programa usa el 8080. Editá `.env`, agregá `HERMES_OAUTH_PORT=8081`, y volvé a correr el Paso 2.

**El login (URL) no se abre** → Copiá la dirección web que muestra Hermes y pegala vos mismo en el navegador. Tras autorizar, volvé a la terminal.

**Responde lento** → Sin GPU el modelo corre en CPU. Probá uno más chico (`qwen3:8b`) o usá una máquina con GPU.

---

## 🙏 Créditos

- **Hermes** — agente de [Nous Research](https://nousresearch.com/).
- **Ollama** — [ollama.com](https://ollama.com/).
- Modelos **Qwen3** — Alibaba / comunidad open source.

## 📄 Licencia

[MIT](./LICENSE) — usalo, modificalo y compartilo libremente.
