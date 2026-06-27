# Hermes + Ollama en local con Docker 🐳🤖

> **Una IA que vive en TU computadora.** Open-source, tuya, y corre 100% en tu máquina.

Esto no es un chat más. **[Hermes](https://nousresearch.com/)** (el agente open-source de Nous Research) es un asistente de IA que corre en tu propia máquina con un modelo de lenguaje servido por **[Ollama](https://ollama.com/)**. Tus conversaciones se procesan **localmente**, sin pagar por uso de API y sin que tus datos salgan de tu PC.

Cuando tu IA vive en la nube de otro, te la pueden cortar de un día para el otro. Acá corre en tu máquina: **mientras la tengas prendida, es tuya y no te la apaga nadie.** Dejás de alquilar tu inteligencia — ahora es tuya.

> 📺 **¿Preferís seguirlo en video?** Está el paso a paso en el canal: **https://www.youtube.com/@FacundoCorengia**

✅ Funciona en **Windows** y **macOS** (y Linux). No hace falta saber programar: vas a **copiar y pegar** unos pocos comandos de Docker. Te explico cada paso y qué vas a ver en pantalla.

---

## 🚫 Seamos honestos (antes de arrancar)

Esto **NO es Fable 5 ni Opus**. Es un modelo que corre en TU compu — privado, gratis y tuyo — pero hoy **no le llega ni cerca a los grandes de la nube.** Para tareas pesadas vas a seguir queriendo esos.

No es magia: **hay que configurarlo bien y pide una máquina decente** (RAM y paciencia). Lo que ganás acá es que es tuyo, nadie te lo apaga, y mejora solo con el tiempo y con mejor hardware. Si buscás el modelo más potente del mundo, esto no es para eso. Si querés tu propia IA, sin depender de nadie, seguí leyendo.

> 🎒 **Lo que vas a necesitar (lista completa, sin sorpresas):** Docker Desktop · Git (o bajar un ZIP) · **~15 GB** de disco libres · internet **solo la primera vez** (para bajar el proyecto y el modelo) · y en **Mac**, además, la app de **Ollama**. Nada de tarjetas ni cuentas: el camino de esta guía es **100% local y sin registrarte en ningún lado**.

---

## 📑 Índice

**Para instalar (leé esto, en orden):**
- [Antes de empezar: requisitos](#-antes-de-empezar-requisitos)
- [Paso 0 — Instalar los programas](#-paso-0--instalar-los-programas-necesarios)
- [Paso 1 — Descargar el proyecto](#-paso-1--descargar-el-proyecto)
- [Paso 2 — Levantar Ollama y bajar el modelo](#-paso-2--levantar-ollama-y-bajar-el-modelo)
- [Paso 3 — Conectar Hermes con tu modelo local](#-paso-3--conectar-hermes-con-tu-modelo-local-sin-cuenta)
- [Paso 4 — Chatear con Hermes](#-paso-4--chatear-con-hermes)
- [Problemas comunes](#-problemas-comunes)

**Para leer cuando quieras (contexto y extras):**
- [¿Qué es esto y por qué lo querés?](#-qué-es-esto-y-por-qué-lo-querés)
- [Qué hace ESTE repo (y qué es del propio Hermes)](#-qué-hace-este-repo-y-qué-es-del-propio-hermes)
- [¿Qué es cada cosa? (glosario rápido)](#-qué-es-cada-cosa-glosario-rápido)
- [Cambiar el modelo de IA](#-cambiar-el-modelo-de-ia)
- [Cómo funciona (para curiosos)](#-cómo-funciona-para-curiosos)
- [Comandos útiles](#-comandos-útiles)
- [Darle a Hermes acceso a una carpeta tuya](#-darle-a-hermes-acceso-a-una-carpeta-tuya-opcional)
- [Privacidad y costo](#-privacidad-y-costo)
- [Y ahora qué: hacia lo que viste en el video](#-y-ahora-qué-hacia-lo-que-viste-en-el-video)
- [Desinstalar / liberar espacio](#-desinstalar--liberar-espacio)
- [Cómo se reparte con Claude Code](#-cómo-se-reparte-con-claude-code)
- [¿Quién armó esto?](#-quién-armó-esto) · [Créditos](#-créditos) · [Licencia](#-licencia)

---

## ✅ Antes de empezar: requisitos

| | |
|---|---|
| 💾 **Espacio en disco** | **~15 GB libres** (modelo `qwen3:8b` ~5 GB + imágenes de Docker ~3-5 GB + margen). Docker Desktop ocupa su propio espacio aparte. |
| 🧠 **Memoria (RAM)** | **16 GB recomendado.** Con 8 GB anda pero al límite y lento: el modelo + Windows + Docker se comen casi todo. ¿Tenés 8 GB? Usá un modelo más chico (`qwen3:4b`) y/o bajá el contexto (ver [Problemas comunes](#-problemas-comunes)). |
| 🖥️ **Sistema** | Windows 10/11, o macOS (Apple Silicon M1 o más nuevo recomendado), o Linux |
| 🎮 **Placa de video (GPU)** | **Opcional.** NVIDIA (Windows) o Apple Silicon (Mac) hacen que vaya más rápido. Sin GPU también funciona, más lento. |
| 🌐 **Internet** | **Solo la primera vez** (bajar el proyecto, el modelo ~5 GB y construir la imagen). Después la IA corre offline. |

---

## 🧩 Paso 0 — Instalar los programas necesarios

Hacé esto **una sola vez**. Elegí tu sistema operativo 👇

<details open>
<summary><b>🪟 Windows</b></summary>

<br>

**1. Docker Desktop** — el programa principal.
- Descargalo: **https://www.docker.com/products/docker-desktop/** → *Download for Windows*.
- Instalalo (siguiente, siguiente, finalizar). Si te pregunta por **WSL 2** (un componente de Windows que Docker necesita), aceptá. Si Windows te muestra una ventana azul de control de cuentas, tocá **Sí**.
- **Quizás tengas que reiniciar la PC** una vez para que WSL 2 quede activo. Es normal.
- **Abrí Docker Desktop.** La primera vez aceptá los términos (**Accept**). Si te pide iniciar sesión o crear cuenta, **NO hace falta**: tocá **"Continue without signing in"**.
- Esperá a que la ballena 🐳 deje de moverse y diga **"Running"** (abajo a la izquierda; también queda en la bandeja del sistema, al lado del reloj). **Dejá Docker Desktop abierto.**

> 🎥 **¿Nunca instalaste Docker o no te arranca en Windows?** Guía en video, paso a paso, para dejarlo funcionando: **https://www.youtube.com/watch?v=ZyBBv1JmnWQ**

**2. Git** — para descargar el proyecto.
- Descargalo: **https://git-scm.com/download/win** (opciones por defecto).
- *(Si no querés instalar Git, en el Paso 1 te muestro cómo bajarlo como ZIP.)*

> En Windows **no** instales Ollama aparte: corre solo, dentro de Docker.

**Cómo abrir la terminal (PowerShell):** apretá la tecla **Windows**, escribí `PowerShell`, y abrí *Windows PowerShell*.

</details>

<details>
<summary><b>🍏 macOS</b></summary>

<br>

> ⚠️ **En Mac necesitás DOS programas, no solo Docker:** Docker Desktop **y** la app de Ollama. Es así porque Docker en Mac no puede usar la GPU de Apple; por eso el modelo lo corre Ollama nativo (rápido) y solo Hermes va en Docker. Instalá los dos 👇

**1. Docker Desktop** — el programa principal.
- Descargalo: **https://www.docker.com/products/docker-desktop/** → *Download for Mac*.
  - **¿No sabés qué Mac tenés?** Menú **Apple () → Acerca de esta Mac**. Si dice **"Chip Apple M1/M2/M3…"**, elegí **Apple Silicon**. Si dice **"Procesador Intel"**, elegí **Intel**.
- Instalalo (arrastrá Docker a *Aplicaciones*) y **abrilo**. Esperá a que diga **"Running"**. Dejalo abierto.

**2. Ollama** — el motor del modelo (en Mac corre nativo para usar la GPU de Apple).
- Descargalo: **https://ollama.com/download/mac** e instalá la app. **Abrila una vez** (instala el comando `ollama`).
- Ollama no abre ventana: aparece un ícono de llama 🦙 en la barra de menú. **Dejalo abierto** mientras uses Hermes.
- **Importante:** después de abrir Ollama por primera vez, **cerrá la Terminal y abrila de nuevo** (así toma el comando `ollama`).

**3. Git** — para descargar el proyecto.
- Abrí la Terminal y escribí `git`. Si no lo tenés, macOS te ofrece instalarlo solo. *(O bajá el ZIP, ver Paso 1.)*

> 🔐 **Avisos de seguridad de macOS (son normales):** la primera vez que abrís Docker u Ollama, macOS puede decir *"no se puede abrir porque Apple no puede comprobar…"*. Clic en **Abrir**. Si no aparece, andá a **Ajustes → Privacidad y seguridad** y tocá **Abrir igualmente**.

**Cómo abrir la terminal (Terminal):** apretá **Cmd + Espacio**, escribí `Terminal`, y abrila.

</details>

---

## 📥 Paso 1 — Descargar el proyecto

En la terminal, pegá esto:

```bash
git clone https://github.com/fcori47/dios-ia-hermes-local.git
cd dios-ia-hermes-local
```

> 📁 Esto crea la carpeta `dios-ia-hermes-local` dentro de tu carpeta de usuario. El comando `cd` te mete **adentro** de esa carpeta: **todos los comandos siguientes se corren desde ahí**.

<details>
<summary><b>¿No tenés Git? Descargalo como ZIP</b></summary>

<br>

1. Entrá a **https://github.com/fcori47/dios-ia-hermes-local**
2. Botón verde **`< > Code`** → **Download ZIP**.
3. Clic derecho en el ZIP → **Extraer todo…**
4. **Ojo:** a veces queda una carpeta dentro de otra con el mismo nombre. Entrá hasta ver adentro el archivo `docker-compose.yml`. **Esa** es la carpeta correcta. Bajado como ZIP, suele llamarse **`dios-ia-hermes-local-main`** (con `-main` al final).
5. En la terminal escribí `cd ` (con un espacio) y **pegá la ruta de esa carpeta entre comillas**. Ejemplo en Windows:
   ```powershell
   cd "C:\Users\TuUsuario\Downloads\dios-ia-hermes-local-main\dios-ia-hermes-local-main"
   ```
6. Verificá con `dir` (Windows) o `ls` (Mac/Linux) que se vea `docker-compose.yml`.

> 💡 Anotá esa ruta: la vas a volver a usar cada vez que abras una terminal nueva (Paso 4 y Comandos útiles). Como tu carpeta termina en `-main`, **el comando `cd dios-ia-hermes-local` de los próximos pasos no te va a funcionar tal cual** — usá siempre tu ruta con `-main`.

</details>

---

## 🚀 Paso 2 — Levantar Ollama y bajar el modelo

> Asegurate de que **Docker Desktop esté abierto y "Running"** antes de seguir. Todos los comandos se corren **desde adentro de la carpeta** `dios-ia-hermes-local`.

**1) Creá tu archivo de configuración** (copia del ejemplo). Copiá **solo el comando de tu sistema**:

```powershell
Copy-Item .env.example .env      # 🪟 Windows (PowerShell)
```
```bash
cp .env.example .env             # 🍏 macOS / Linux
```

<details open>
<summary><b>🪟 Windows / 🐧 Linux — Ollama corre dentro de Docker</b></summary>

<br>

**2) Levantá Ollama:**

```bash
docker compose --profile bundled up -d ollama
```

> 🎮 **¿Tenés GPU NVIDIA?** Usá este comando en su lugar (acelera todo). Si no tenés, ignoralo:
> ```bash
> docker compose -f docker-compose.yml -f docker-compose.gpu.yml --profile bundled up -d ollama
> ```

**3) Bajá el modelo** (~5 GB, la primera vez tarda **10 a 40 min** según tu internet):

```bash
docker compose --profile bundled run --rm pull-model
```
> Vas a ver una barra `pulling … 42% ▕███▏ 2.1 GB/5.0 GB`. **Mientras el número suba, está todo bien.** ¿Se cortó? Volvé a correr el comando: continúa desde donde quedó.

**4) Construí la imagen de Hermes** (la primera vez baja e instala Hermes — tarda y muestra texto en inglés `apt-get`, `Installing`… es normal):

```bash
docker compose build hermes
```

</details>

<details>
<summary><b>🍏 macOS — Ollama corre nativo (usa la GPU de Apple)</b></summary>

<br>

En Mac **no** levantes Ollama en Docker (iría lentísimo). Usás el Ollama nativo que instalaste en el Paso 0:

**2) Hacé que Ollama acepte conexiones desde Docker** y reabrí la app:
```bash
launchctl setenv OLLAMA_HOST 0.0.0.0:11434
```
*(Cerrá la app de Ollama desde el ícono 🦙 → Quit, y volvé a abrirla.)*

**3) Bajá el modelo:**
```bash
ollama pull qwen3:8b      # o el que hayas puesto en OLLAMA_MODEL del .env
```

**4) Apuntá Hermes a tu Ollama nativo.** Abrí `.env` y cambiá esa línea (poné `host.docker.internal` en lugar de `ollama`):
```dotenv
OPENAI_BASE_URL=http://host.docker.internal:11434/v1
```

**5) Construí la imagen de Hermes:**
```bash
docker compose build hermes
```

</details>

---

## 🔑 Paso 3 — Conectar Hermes con tu modelo local (sin cuenta)

Esto se hace **una sola vez** y es **100% local: no necesitás crear ninguna cuenta ni iniciar sesión en ningún lado.** Le decimos a Hermes que use el modelo que ya está corriendo en tu Ollama.

```bash
docker compose run --rm hermes "hermes model"
```

Se abre un asistente en la terminal. Movételo con las **flechas** y **ENTER**:

1. Elegí la opción **"Custom endpoint"** (puede decir algo como *"Custom endpoint (self-hosted / VLLM / Ollama)"*). Si primero te muestra "More providers…", entrá ahí y buscá "Custom endpoint".
2. Cuando te pida la **URL**, pegá la de tu Ollama (es la misma que está en tu `.env`). **Va completa, terminada en `/v1`.** Si el campo ya trae algo escrito (ej. `http://localhost:11434`), **borralo** y pegá esta tal cual:
   - 🪟 **Windows / 🐧 Linux:** `http://ollama:11434/v1`
   - 🍏 **macOS:** `http://host.docker.internal:11434/v1`
3. **API key:** dejala **vacía** (apretá ENTER). Ollama no pide ninguna.
4. **Modelo:** te muestra los modelos que tenés en Ollama. Movételo con las **flechas** y elegí **`qwen3:8b`** (o el que pusiste en `.env`) con **ENTER**.
5. Si te pregunta por el **contexto (context length)**, poné **`32768`** (no lo dejes en blanco). El servidor Ollama ya sirve ese contexto — lo configuramos en el Paso 2.

Cuando termina, Hermes guarda esta configuración y ya queda listo para chatear. ✅

> 💡 **¿Por qué "Custom endpoint" y no iniciar sesión?** Hermes también tiene un modo que se loguea en el portal de Nous (en la nube). Acá **no lo usamos a propósito**: queremos que todo corra en tu máquina, sin cuenta y sin que nada salga de tu PC. Por eso apuntamos Hermes directo a tu Ollama local.

---

## 💬 Paso 4 — Chatear con Hermes

```bash
docker compose run --rm hermes
```

> El chat vive **dentro de esta ventana de terminal**: escribí tu mensaje y apretá **ENTER**. La **primera respuesta puede tardar unos segundos** (hasta un minuto sin GPU) mientras se carga el modelo — aunque parezca colgado, esperá. Para **salir**, escribí `exit` y ENTER (o **Ctrl + C**).
>
> ```
> > Hola, ¿quién sos?
> Soy Hermes, tu agente de IA corriendo en local…
> ```

> 🔁 **¿Abrís una terminal nueva otro día?** Primero volvé a la carpeta del proyecto: `cd dios-ia-hermes-local` *(o, si la bajaste como ZIP, tu ruta con `-main` del Paso 1)*. En **Windows/Linux**, si cerraste Docker o hiciste `docker compose --profile bundled down`, volvé a levantar Ollama antes de chatear: `docker compose --profile bundled up -d ollama`. En **Mac**, tené abierta la app de Ollama.

---

## 🔭 Y ahora qué: hacia lo que viste en el video

Hasta acá tenés **la base: Hermes corriendo 100% local y un chat en la terminal.** Eso ya es tu IA, tuya, sin que nada salga de tu compu.

En el video viste más que un chat: a Hermes hablándote por **Telegram**, corriendo **tareas solas** y **acordándose** de lo que hacés. Que quede clarísimo, sin humo:

- **Lo que arma este repo:** Hermes + Ollama en local, conectar el modelo, chatear y darle acceso a una carpeta tuya.
- **Lo que es del propio Hermes (se activa adentro de Hermes):** los **canales** (Telegram, WhatsApp, Discord, Slack, Email), las **tareas programadas (crons)**, la **memoria** y las **skills**. La guía oficial está en **[nousresearch.com](https://nousresearch.com/)**.

> No te voy a tirar un `hermes telegram ...` o `hermes cron ...` que no esté verificado contra la doc oficial. Si no lo confirmé, te mando a la fuente real — eso es lo opuesto al humo.

---

## 🤖 ¿Qué es esto y por qué lo querés?

Hermes es un **agente** de IA, no un chatbot. Eso quiere decir que no solo te responde: **hace tareas por vos**. Y al ser open-source y correr en tu máquina, tiene tres cosas que ningún servicio de la nube te da:

- **Es tuyo y es privado.** Tus conversaciones nunca salen de tu compu. Nadie te lo apaga ni te lo cambia las reglas de un día para el otro.
- **Es gratis.** No pagás API ni suscripción por usar el modelo: corre en tu propio hardware.
- **Es la base de algo más grande.** Lo que en un servicio de IA pagás todos los meses, acá lo armás una vez y es tuyo para siempre.

Elegí **Hermes** y no otro agente de moda porque, además de hacer tareas, está pensado para **aprender de cómo trabajás, recordarte**, y viene con foco fuerte en seguridad — no es solo "el agente del momento".

> 🚫 Recordá el reseteo de expectativas de arriba: el modelo local de hoy sirve para tareas, **no compite con Opus ni con los modelos grandes de la nube.** Esto es soberanía y privacidad, no el modelo más potente del mundo.

---

## 🧭 Qué hace ESTE repo (y qué es del propio Hermes)

Lo más importante para que no haya humo: **este repo te deja Hermes corriendo 100% local y un chat en la terminal.** Esa es la base. Las capacidades grandes que ves en el video (canales como Telegram/WhatsApp, tareas programadas, memoria, skills) son funciones **nativas del agente Hermes de Nous Research** que se activan **adentro de Hermes**.

| Capacidad | Estado |
|---|---|
| Chat con IA **100% local** (`hermes chat`) | ✅ lo arma este repo |
| **Sin cuenta y sin costo** (el modelo corre en tu PC) | ✅ lo arma este repo |
| **Windows / macOS / Linux** | ✅ lo arma este repo |
| **GPU NVIDIA** (override de Docker) · **Apple Metal**: la usa Ollama nativo en Mac | ✅ NVIDIA con un flag · Metal corre sola en Mac |
| Cambiar de modelo desde `.env` | ✅ lo arma este repo |
| Darle acceso a **una carpeta tuya** (workspace) | ✅ lo arma este repo (opcional) |
| Telegram · WhatsApp · Discord · Slack · Email | ⚙️ función del agente Hermes — se activa adentro de Hermes |
| Tareas programadas (crons) · Memoria · Skills | ⚙️ función del agente Hermes — se activa adentro de Hermes |

**¿Qué hago con lo del repo entonces?** Tenés a Hermes andando en tu máquina y le hablás por la terminal. Eso ya es un montón: es tu IA, tuya, sin que nada salga de tu PC. A partir de ahí, conectarle Telegram, ponerle crons y darle memoria se hace **adentro de Hermes**.

> ⚠️ Para activar canales, crons o memoria, mirá la doc oficial del agente en **[nousresearch.com](https://nousresearch.com/)**. Acá no te voy a tirar comandos inventados: si un paso no está en este repo, te mando a la fuente real en vez de hacerte humo.

---

## 🧠 ¿Qué es cada cosa? (glosario rápido)

Si estos nombres te suenan a chino, leé esto una vez y listo:

- **Docker** — un programa que corre aplicaciones dentro de "cajas" aisladas (contenedores), así no instalás mil cosas a mano. Se instala una vez.
- **`docker compose`** — el comando con el que vas a manejar todo (levantar, bajar el modelo, chatear). Viene incluido en Docker Desktop.
- **WSL 2** *(solo Windows)* — un componente de Windows que Docker necesita para funcionar. Docker te lo instala y activa solo; vos solo aceptás cuando te pregunta.
- **Ollama** — el motor que descarga y ejecuta el modelo de IA en tu máquina.
- **Hermes** — el agente con el que vas a chatear (usa el modelo que sirve Ollama).
- **El modelo** — el "cerebro". Por defecto usamos `qwen3:8b` (liviano, ~5 GB). Se cambia con **una sola variable** (ver [Cambiar el modelo](#-cambiar-el-modelo-de-ia)).
- **Endpoint / URL** — la dirección por donde dos programas se hablan. Acá Hermes le habla a Ollama en `http://ollama:11434/v1` (o `host.docker.internal` en Mac).
- **`.env`** — un archivo de texto con la configuración (qué modelo usar, etc.). Lo creás copiando `.env.example` y lo editás con cualquier editor de texto.
- **Descomentar** — quitarle el `#` del principio a una línea de un archivo para que pase a estar "activa".

---

## 🔧 Cambiar el modelo de IA

El modelo se elige con **una sola línea** en el archivo `.env`:

```dotenv
OLLAMA_MODEL=qwen3:8b
```

Cambiá ese valor por cualquier modelo de **[ollama.com/library](https://ollama.com/library)** (poné el nombre **tal cual aparece ahí**):

| Modelo | Tamaño | Para qué |
|---|---|---|
| `qwen3:4b` | ~2.6 GB | El más liviano, ideal para **8 GB de RAM** |
| `qwen3:8b` | ~5 GB | Liviano, va cómodo con 16 GB; con 8 GB anda justo **(por defecto)** |
| `qwen3:14b` | ~9 GB | Mejor calidad, necesita una PC/GPU decente |
| `qwen3:30b` | ~19 GB | Muy capaz, pesado (mucha RAM/GPU) |
| `hermes3` | ~4.7 GB | El modelo Hermes de Nous Research |
| `llama3.1:8b` | ~4.9 GB | Alternativa popular |

Después de cambiarlo, volvé a **bajar el nuevo modelo** y **seleccionarlo**:

```bash
# Windows / Linux:
docker compose --profile bundled run --rm pull-model
docker compose run --rm hermes "hermes model"

# macOS (Ollama nativo):
ollama pull <modelo>
docker compose run --rm hermes "hermes model"
```

**Borrar un modelo viejo (liberar espacio):**
```bash
docker compose --profile bundled exec ollama ollama rm <modelo>   # Windows / Linux
ollama rm <modelo>                                                # macOS
```

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

**¿Por qué en Mac es distinto?** Docker en macOS no puede usar la GPU de Apple. Si Ollama corriera dentro de Docker en una Mac, iría lentísimo (solo CPU). Por eso en Mac Ollama corre nativo (usa la GPU Metal) y solo Hermes va en Docker.

---

## 🧰 Comandos útiles

> Todos se corren **desde adentro de la carpeta del proyecto**. Si abriste una terminal nueva: `cd dios-ia-hermes-local` *(o tu ruta con `-main` si la bajaste como ZIP)*.

```bash
docker compose run --rm hermes                       # chatear
docker compose run --rm hermes "hermes model"        # cambiar / reconectar el modelo
docker compose run --rm hermes bash                  # abrir una terminal dentro de Hermes
docker compose --profile bundled up -d ollama        # levantar Ollama (Win/Linux) si lo bajaste
docker compose --profile bundled ps                  # ver qué está corriendo
docker compose --profile bundled logs ollama         # ver el log de Ollama
docker compose --profile bundled down                # parar todo (el modelo queda guardado)
```
> Salir del chat (`exit`) **no** apaga Ollama: en Windows/Linux sigue en segundo plano. Para liberar la RAM, usá `docker compose --profile bundled down`.

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
3. Volvé a abrir el chat → tus archivos están en `/workspace` dentro de Hermes. Probá: `> listá los archivos de /workspace`.

> 💡 Con un modelo chico como `qwen3:8b`, a veces el modelo te contesta en texto en vez de **usar la herramienta**. Si no la usó, pedíselo más directo ("usá la herramienta de archivos y listá /workspace") o probá un modelo más grande.

---

## 🔒 Privacidad y costo

- **¿Necesito internet?** Sí, **una sola vez**, para descargar el proyecto, bajar el modelo (~5 GB) y construir la imagen. Después, la IA corre **entera en tu máquina** vía Ollama, sin conexión.
- **¿Tengo que crear una cuenta?** **No.** Con el camino de esta guía (Paso 3 → "Custom endpoint"), Hermes apunta directo a tu Ollama local: no hay login, no hay registro, no sale nada de tu PC. *(Hermes tiene además un portal opcional en la nube de Nous con herramientas extra; este repo no lo usa.)*
- **¿Tiene costo?** No. El modelo corre en tu hardware: no pagás por uso ni suscripción.
- **¿Y mis datos?** Tus conversaciones se procesan localmente. No se mandan a ningún servidor.

---

## 🗑️ Desinstalar / liberar espacio

Parados en la carpeta del proyecto:

**1.** Borrá el modelo descargado y la config:
```bash
docker compose --profile bundled down -v
```
**2.** Borrá las imágenes de Docker (esto ocupa varios GB y NO lo borra el paso 1):
```bash
docker rmi hermes-agent:local ollama/ollama:latest ubuntu:22.04
```
**3.** Borrá la carpeta del proyecto.

**4.** (Opcional) Desinstalá **Docker Desktop**, y en Mac también la app de **Ollama**.

---

## 🩺 Problemas comunes

**"Docker no está corriendo"** → Abrí **Docker Desktop** y esperá a que diga *Running*. Después reintentá.

**Windows: Docker no arranca / pide WSL 2 o "WSL kernel version too low"** → Reiniciá la PC una vez. Si sigue, abrí PowerShell y corré `wsl --update`, después reabrí Docker Desktop. ¿Nunca instalaste Docker o no te arranca? Guía en video paso a paso: **https://www.youtube.com/watch?v=ZyBBv1JmnWQ**

**El build de Hermes falla / no encuentra el comando `hermes`** → Reintentá `docker compose build hermes` (Docker cachea lo ya bajado). Verificá que tengas internet. Si persiste, es del instalador de Nous Research → revisá [nousresearch.com](https://nousresearch.com/).

**En `hermes model` no veo "Custom endpoint"** → Suele estar dentro de una opción tipo **"More providers…"** o *"Other / Custom"*. Buscá la que te deje **escribir una URL a mano** y pegá la de Ollama (`http://ollama:11434/v1`, o `http://host.docker.internal:11434/v1` en Mac).

**El chat responde lento o se cuelga** → Sin GPU el modelo corre en CPU. Si tenés **poca RAM (8 GB)**: (1) usá un modelo más liviano (`qwen3:4b`), y/o (2) bajá el contexto en `.env` → poné `OLLAMA_CONTEXT_LENGTH=8192` (o `16384`), guardá y volvé a levantar Ollama (`docker compose --profile bundled up -d ollama`). Menos contexto = menos RAM.

**Hermes me responde cortado / no termina la frase** → Es un tema conocido con modelos de **razonamiento** (como `qwen3`, que "piensa" antes de responder): a veces los tokens de pensar se comen el presupuesto y la respuesta sale cortada ([issue oficial #46833](https://github.com/NousResearch/hermes-agent/issues/46833)). La salida más fácil para un no-técnico: usá un modelo que **no** razona por defecto — en `.env` poné `OLLAMA_MODEL=llama3.1:8b`, volvé a bajarlo (`docker compose --profile bundled run --rm pull-model`) y reconectalo (`docker compose run --rm hermes "hermes model"`). *(Avanzado: si sabés editar la config de Hermes, subí `max_tokens` a 16384.)*

**`could not select device driver "nvidia"`** → Tenés GPU NVIDIA pero Docker todavía no la puede usar. En Windows: actualizá Docker Desktop y activá **WSL2**. Igual podés correr sin el `-f docker-compose.gpu.yml` y va en CPU.

**Mac: el chat dice que no puede conectar con Ollama** → Casi siempre Ollama volvió a escuchar solo en `127.0.0.1`. Corré `launchctl setenv OLLAMA_HOST 0.0.0.0:11434`, cerrá la app de Ollama (ícono → Quit) y reabrila. Confirmá que `.env` tenga `OPENAI_BASE_URL=http://host.docker.internal:11434/v1`.

**Mac: "ollama: command not found"** → Abrí la app de Ollama una vez (instala el comando), después **cerrá y reabrí la Terminal**, volvé a entrar a la carpeta y reintentá. Si sigue: `brew install ollama`.

**`port is already allocated`** → El flujo de esta guía no publica puertos, así que no debería pasar. Si lo ves, probablemente activaste el portal opcional de Nous (puerto `8080`): cambiá `HERMES_OAUTH_PORT` en `.env` a otro puerto libre (ej. `8081`).

---

## 🧩 Cómo se reparte con Claude Code

Acá viene la parte que nadie cuenta: **Hermes no reemplaza a Claude Code. Lo completa.**

- Con **Claude Code** te sentás y **construís**: apps, sistemas, tu herramienta de laburo.
- **Hermes** es el que va a hacer lo **repetitivo** mientras construís. Una vez que le conectás los **canales** (Telegram/WhatsApp) y las **tareas programadas (crons)** —que se activan adentro de Hermes— puede contestar clientes, mandar seguimientos y correr tus rutinas solo.

> 🛠️ **Esto es la base de algo más grande: tu propio sistema operativo de IA — Claude Code + Hermes + Obsidian. Eso lo armamos en el próximo video.**

---

## 👋 ¿Quién armó esto?

Soy **Facu** — me dicen *el Dios de la IA*. Llevo 35+ proyectos de IA en producción y monto sistemas de verdad, no humo.

Este repo es el complemento del video. Si querés llevarlo más lejos:

- 🎯 **¿Sos freelancer o tenés una agencia y querés vivir de la IA?** Coaching 1 a 1 → **[facundocorengia.com](https://facundocorengia.com/)**
- 🏢 **¿Tenés una empresa y querés implementar IA de verdad adentro?** Consultoría → **[basdonax.com](https://basdonax.com/)**

Si te sirvió, dejale una ⭐ al repo y compartilo.

---

## 🆘 ¿Algo no anda?

Abrí un issue 👉 [Issues](https://github.com/fcori47/dios-ia-hermes-local/issues) contando: tu sistema (Windows / Mac / Linux), en qué paso te trabaste, y el **texto exacto del error** (copiá y pegá lo que dice la terminal).

---

## 🙏 Créditos

- **Este tutorial** — armado por **Facu, el Dios de la IA** ([facundocorengia.com](https://facundocorengia.com/) · [basdonax.com](https://basdonax.com/)).
- **Hermes** — agente de [Nous Research](https://nousresearch.com/).
- **Ollama** — [ollama.com](https://ollama.com/).
- Modelos **Qwen3** — Alibaba / comunidad open source.

## 📄 Licencia

[MIT](./LICENSE) — usalo, modificalo y compartilo libremente.
