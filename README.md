# Hermes + Ollama en local con Docker 🐳🤖

> **Una IA que vive en TU computadora.** Open-source, tuya, y no depende de nadie.

Esto no es un chat más. **[Hermes](https://nousresearch.com/)** (el agente open-source de Nous Research) es un asistente de IA que corre en tu propia máquina con un modelo de lenguaje servido por **[Ollama](https://ollama.com/)**. Tus conversaciones se procesan **localmente**, sin pagar por uso de API y sin que tus datos salgan de tu PC.

Cuando tu IA vive en la nube de otro, te la pueden cortar de un día para el otro. Acá corre en tu máquina: **mientras la tengas prendida, es tuya y no te la apaga nadie.** Dejás de alquilar tu inteligencia — ahora es tuya.

> 📺 **Video paso a paso (YouTube):** https://www.youtube.com/@FacundoCorengia — **(PEGAR EL ENLACE DIRECTO DEL VIDEO ANTES DE PUBLICAR)**
>
> <!-- TODO: cuando esté subido, generar el enlace con UTM desde /utms (utm_source=github) para atribuir el tráfico del repo. -->

<!-- TODO: GIF / captura del chat de Hermes respondiendo en la terminal (lo más potente para empujar el clone). Va acá arriba. -->

✅ Funciona en **Windows** y **macOS** (y Linux). No hace falta saber programar: vas a **copiar y pegar** unos pocos comandos de Docker. Te explico cada paso y qué vas a ver en pantalla.

---

## 🚫 Seamos honestos (antes de arrancar)

Esto **NO es Fable 5 ni Opus**. Es un modelo que corre en TU compu — privado, gratis y tuyo — pero hoy **no le llega ni cerca a los grandes de la nube.** Para tareas pesadas vas a seguir queriendo esos.

No es magia: **hay que configurarlo bien y pide una máquina decente** (RAM y paciencia). Lo que ganás acá es que es tuyo, nadie te lo apaga, y mejora solo con el tiempo y con mejor hardware. Si buscás el modelo más potente del mundo, esto no es para eso. Si querés tu propia IA, sin depender de nadie, seguí leyendo.

---

## 📑 Índice

- [¿Qué es esto y por qué lo querés?](#-qué-es-esto-y-por-qué-lo-querés)
- [Qué hace ESTE repo (y qué es del propio Hermes)](#-qué-hace-este-repo-y-qué-es-del-propio-hermes)
- [¿Qué es cada cosa? (glosario rápido)](#-qué-es-cada-cosa-glosario-rápido)
- [Antes de empezar: requisitos](#-antes-de-empezar-requisitos)
- [Paso 0 — Instalar los programas](#-paso-0--instalar-los-programas-necesarios)
- [Paso 1 — Descargar el proyecto](#-paso-1--descargar-el-proyecto)
- [Paso 2 — Levantar Ollama y bajar el modelo](#-paso-2--levantar-ollama-y-bajar-el-modelo)
- [Paso 3 — Iniciar sesión y elegir modelo](#-paso-3--iniciar-sesión-en-hermes-y-elegir-el-modelo)
- [Paso 4 — Chatear con Hermes](#-paso-4--chatear-con-hermes)
- [🔌 Si te da error de puerto ocupado](#-si-te-da-error-de-puerto-ocupado)
- [Y ahora qué: hacia lo que viste en el video](#-y-ahora-qué-hacia-lo-que-viste-en-el-video)
- [Cambiar el modelo de IA](#-cambiar-el-modelo-de-ia)
- [Cómo funciona (para curiosos)](#-cómo-funciona-para-curiosos)
- [Qué hay en el repo](#-qué-hay-en-el-repo)
- [Comandos útiles](#-comandos-útiles)
- [Darle a Hermes acceso a una carpeta tuya](#-darle-a-hermes-acceso-a-una-carpeta-tuya-opcional)
- [Privacidad y costo](#-privacidad-y-costo)
- [Desinstalar / liberar espacio](#-desinstalar--liberar-espacio)
- [Problemas comunes](#-problemas-comunes)
- [Cómo se reparte con Claude Code](#-cómo-se-reparte-con-claude-code)
- [¿Quién armó esto?](#-quién-armó-esto)
- [Créditos](#-créditos)
- [Licencia](#-licencia)

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

Lo más importante para que no haya humo: **este repo te deja Hermes corriendo 100% local y un chat en la terminal.** Esa es la base. Las capacidades grandes que ves en el video (canales como Telegram/WhatsApp, tareas programadas, memoria, skills) son funciones **nativas del agente Hermes de Nous Research** que se activan **adentro de Hermes** una vez que iniciás sesión.

| Capacidad | Estado |
|---|---|
| Chat con IA **100% local** (`hermes chat`) | ✅ lo arma este repo |
| **Sin costo de API** (el modelo corre en tu PC) | ✅ lo arma este repo |
| **Windows / macOS / Linux** | ✅ lo arma este repo |
| **GPU NVIDIA** (override de Docker) · **Apple Metal**: la usa Ollama nativo en Mac | ✅ NVIDIA con un flag · Metal corre sola en Mac |
| Cambiar de modelo desde `.env` | ✅ lo arma este repo |
| Darle acceso a **una carpeta tuya** (workspace) | ✅ lo arma este repo (opcional) |
| Telegram · WhatsApp · Discord · Slack · Email | ⚙️ función del agente Hermes — se activa adentro de Hermes |
| Tareas programadas (crons) · Memoria · Skills | ⚙️ función del agente Hermes — se activa adentro de Hermes |

**¿Qué hago con lo del repo entonces?** Tenés a Hermes andando en tu máquina y le hablás por la terminal. Eso ya es un montón: es tu IA, tuya, sin que nada salga de tu PC. A partir de ahí, conectarle Telegram, ponerle crons y darle memoria se hace **adentro de Hermes** una vez logueado.

> ⚠️ Para activar canales, crons o memoria, mirá la doc oficial del agente en **[nousresearch.com](https://nousresearch.com/)**. Acá no te voy a tirar comandos inventados: si un paso no está en este repo, te mando a la fuente real en vez de hacerte humo.

---

## 🧠 ¿Qué es cada cosa? (glosario rápido)

Si estos nombres te suenan a chino, leé esto una vez y listo:

- **Docker** — un programa que corre aplicaciones dentro de "cajas" aisladas (contenedores), así no instalás mil cosas a mano. Se instala una vez.
- **`docker compose`** — el comando con el que vas a manejar todo (levantar, bajar el modelo, chatear). Viene incluido en Docker Desktop.
- **Ollama** — el motor que descarga y ejecuta el modelo de IA en tu máquina.
- **Hermes** — el agente con el que vas a chatear (usa el modelo que sirve Ollama).
- **El modelo** — el "cerebro". Por defecto usamos `qwen3:8b` (liviano, ~5 GB). Se cambia con **una sola variable** (ver [Cambiar el modelo](#-cambiar-el-modelo-de-ia)).
- **Puerto** — un número (como `8080`) por donde dos programas se hablan. Si uno ya está ocupado, lo cambiás en un archivo (ver [error de puerto](#-si-te-da-error-de-puerto-ocupado)).

---

## ✅ Antes de empezar: requisitos

| | |
|---|---|
| 💾 **Espacio en disco** | **~15 GB libres** (modelo `qwen3:8b` ~5 GB + imágenes de Docker ~3-5 GB + margen). Docker Desktop ocupa su propio espacio aparte. |
| 🧠 **Memoria (RAM)** | **16 GB recomendado.** Con 8 GB anda pero al límite y lento (en CPU, el modelo + Windows + Docker se comen casi todo). |
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

**1. Docker Desktop** — el programa principal.
- Descargalo: **https://www.docker.com/products/docker-desktop/** → *Download for Mac*.
  - **¿No sabés qué Mac tenés?** Menú **Apple () → Acerca de esta Mac**. Si dice **"Chip Apple M1/M2/M3…"**, elegí **Apple Silicon**. Si dice **"Procesador Intel"**, elegí **Intel**.
- Instalalo (arrastrá Docker a *Aplicaciones*) y **abrilo**. Esperá a que diga **"Running"**. Dejalo abierto.

**2. Ollama** — el motor del modelo (en Mac corre nativo para usar la GPU de Apple).
- Descargalo: **https://ollama.com/download/mac** e instalá la app. **Abrila una vez** (instala el comando `ollama`).
- Ollama no abre ventana: aparece un ícono de llama 🦙 en la barra de menú. **Dejalo abierto** mientras uses Hermes.

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
4. Entrá a la carpeta hasta ver adentro `docker-compose.yml`. **Esa** es la correcta.
5. En la terminal escribí `cd ` (con un espacio) y pegá la ruta entre comillas. Verificá con `dir` (Windows) o `ls` (Mac) que se vea `docker-compose.yml`.

</details>

---

## 🚀 Paso 2 — Levantar Ollama y bajar el modelo

> Asegurate de que **Docker Desktop esté abierto y "Running"** antes de seguir. Todos los comandos se corren **desde adentro de la carpeta** `dios-ia-hermes-local`.

**1) Creá tu archivo de configuración** (copia del ejemplo):

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
ollama pull qwen3:8b
```

**4) Apuntá Hermes a tu Ollama nativo.** Abrí `.env` y dejá esta línea así (cambiá `ollama` por `host.docker.internal`):
```dotenv
OPENAI_BASE_URL=http://host.docker.internal:11434/v1
```

**5) Construí la imagen de Hermes:**
```bash
docker compose build hermes
```

</details>

---

## 🔑 Paso 3 — Iniciar sesión en Hermes y elegir el modelo

Esto se hace **una sola vez**. Son dos comandos.

**1) Iniciá sesión** (la única parte que usa internet):

```bash
docker compose run --rm --service-ports hermes "hermes setup --portal"
```

- Hermes te muestra una **dirección web (URL)** en la terminal. Copiala (seleccionar + **Ctrl+C**) y abrila en tu navegador.
- **Creá tu cuenta o iniciá sesión en Nous Research** y **autorizá**. Cuando el navegador llegue a una página tipo `http://localhost:8080`, **salió bien**: cerrá esa pestaña y volvé a la terminal.

> El `--service-ports` es lo que abre el puerto `8080` para que el navegador pueda volver al programa. Si te da un **error de puerto ocupado**, mirá [esta sección](#-si-te-da-error-de-puerto-ocupado) (se arregla en 10 segundos).

**2) Elegí el modelo:**

```bash
docker compose run --rm hermes "hermes model"
```

Se abre una lista. Movete con las **flechas** y elegí **`qwen3:8b`** (o el que pusiste en `.env`) con **ENTER**.

---

## 💬 Paso 4 — Chatear con Hermes

```bash
docker compose run --rm hermes
```

> El chat vive **dentro de esta ventana de terminal**: escribí tu mensaje y apretá **ENTER**. La **primera respuesta puede tardar unos segundos** mientras se carga el modelo (aunque parezca colgado, esperá). Para **salir**, escribí `exit` y ENTER (o **Ctrl + C**).
>
> ```
> > Hola, ¿quién sos?
> Soy Hermes, tu agente de IA corriendo en local…
> ```

> ⚠️ El chat solo funciona **después** de haber hecho el Paso 2 (modelo descargado) y el Paso 3 (login). En **Windows/Linux**, si cerraste Docker o hiciste `docker compose down`, primero volvé a levantar Ollama: `docker compose --profile bundled up -d ollama`. En **Mac**, tené abierta la app de Ollama.

---

## 🔌 Si te da error de puerto ocupado

El login del Paso 3 abre el puerto **`8080`** para que el navegador pueda volver. Si ya tenés otro programa usando ese puerto, vas a ver algo como:

```
Bind for 127.0.0.1:8080 failed: port is already allocated
```

**Solución (10 segundos):** elegí otro puerto libre en el archivo `.env`. Abrilo y agregá (o cambiá) esta línea:

```dotenv
HERMES_OAUTH_PORT=8081
```

Guardá y **volvé a correr el comando del Paso 3**. Ahora el login usa el `8081` (el navegador va a volver a `http://localhost:8081`, todo automático).

> 🔎 **¿Querés ver qué está usando el 8080?**
> - 🪟 Windows: `netstat -ano | findstr :8080`
> - 🍏 Mac / 🐧 Linux: `lsof -i :8080`

> ℹ️ **El puerto de Ollama (11434) NO se publica** — Hermes le pega por la red interna de Docker, así que **no choca** con un Ollama nativo que ya tengas. Solo si querés exponerlo para debug, descomentá las líneas `ports:` del servicio `ollama` en `docker-compose.yml` y poné `OLLAMA_HOST_PORT` a un puerto libre en `.env`.

---

## 🔭 Y ahora qué: hacia lo que viste en el video

Hasta acá tenés **la base: Hermes corriendo 100% local y un chat en la terminal.** Eso ya es tu IA, tuya, sin que nada salga de tu compu.

En el video viste más que un chat: a Hermes hablándote por **Telegram**, corriendo **tareas solas** y **acordándose** de lo que hacés. Que quede clarísimo, sin humo:

- **Lo que arma este repo:** Hermes + Ollama en local, iniciar sesión, elegir modelo, chatear y darle acceso a una carpeta tuya.
- **Lo que es del propio Hermes (se activa adentro de Hermes):** los **canales** (Telegram, WhatsApp, Discord, Slack, Email), las **tareas programadas (crons)**, la **memoria** y las **skills**. La guía oficial está en **[nousresearch.com](https://nousresearch.com/)**.

> No te voy a tirar un `hermes telegram ...` o `hermes cron ...` que no esté verificado contra la doc oficial. Si no lo confirmé, te mando a la fuente real — eso es lo opuesto al humo.

---

## 🔧 Cambiar el modelo de IA

El modelo se elige con **una sola línea** en el archivo `.env`:

```dotenv
OLLAMA_MODEL=qwen3:8b
```

Cambiá ese valor por cualquier modelo de **[ollama.com/library](https://ollama.com/library)** (poné el nombre **tal cual aparece ahí**):

| Modelo | Tamaño | Para qué |
|---|---|---|
| `qwen3:8b` | ~5 GB | Liviano, anda en casi cualquier PC **(por defecto)** |
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

## 📂 Qué hay en el repo

```
.
├── docker-compose.yml        # Define los servicios: ollama, pull-model, hermes
├── docker-compose.gpu.yml    # Activa la GPU NVIDIA (se agrega con -f, solo si hay)
├── Dockerfile.hermes         # Imagen del agente Hermes
└── .env.example              # Variables (la principal: OLLAMA_MODEL)
```

---

## 🧰 Comandos útiles

> Todos se corren **desde adentro de la carpeta del proyecto**. Si abriste una terminal nueva: `cd dios-ia-hermes-local`.

```bash
docker compose run --rm hermes                       # chatear
docker compose run --rm hermes "hermes model"        # cambiar de modelo
docker compose run --rm hermes "hermes setup --portal"  # volver a iniciar sesión
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
3. Volvé a abrir el chat → tus archivos están en `/workspace` dentro de Hermes.

---

## 🔒 Privacidad y costo

- **¿Necesito internet?** Sí, **una sola vez** para: descargar el proyecto, bajar el modelo (~5 GB) y activar tu cuenta de Hermes (el login del Paso 3). Después, la IA corre en tu propia máquina.
- **¿Por qué me pide "iniciar sesión" si es local?** Ese login activa tu cuenta del **agente Hermes** (Nous Research), no manda el modelo a la nube. Las respuestas las genera el modelo local de Ollama en tu PC.
- **¿Tiene costo?** No pagás por uso del modelo local. Si la cuenta de Hermes tuviera algún costo o límite, verificalo en [nousresearch.com](https://nousresearch.com/).

---

## 🗑️ Desinstalar / liberar espacio

Parados en la carpeta del proyecto:

```bash
# 1) Borrar el modelo descargado y la config
docker compose --profile bundled down -v

# 2) Borrar las imágenes de Docker (esto ocupa varios GB y NO lo borra el paso 1)
docker rmi hermes-agent:local ollama/ollama:latest ubuntu:22.04
```
3. Borrá la carpeta del proyecto.
4. (Opcional) Desinstalá **Docker Desktop**, y en Mac también la app de **Ollama**.

---

## 🩺 Problemas comunes

**"Docker no está corriendo"** → Abrí **Docker Desktop** y esperá a que diga *Running*. Después reintentá.

**Windows: Docker no arranca / pide WSL 2 o "WSL kernel version too low"** → Reiniciá la PC una vez. Si sigue, abrí PowerShell y corré `wsl --update`, después reabrí Docker Desktop. ¿Nunca instalaste Docker o no te arranca? Guía en video paso a paso: **https://www.youtube.com/watch?v=ZyBBv1JmnWQ**

**`port is already allocated` (puerto 8080)** → Ver [Si te da error de puerto ocupado](#-si-te-da-error-de-puerto-ocupado): poné `HERMES_OAUTH_PORT=8081` en `.env` y reintentá.

**El login (URL) no se abre** → Copiá la dirección web que muestra Hermes y pegala vos mismo en el navegador. Tras autorizar, volvé a la terminal.

**El build de Hermes falla / no encuentra el comando `hermes`** → Reintentá `docker compose build hermes` (Docker cachea lo ya bajado). Verificá que tengas internet. Si persiste, es del instalador de Nous Research → revisá [nousresearch.com](https://nousresearch.com/).

**`could not select device driver "nvidia"`** → Tenés GPU NVIDIA pero Docker todavía no la puede usar. En Windows: actualizá Docker Desktop y activá **WSL2**. Igual podés correr sin el `-f docker-compose.gpu.yml` y va en CPU.

**Mac: el chat dice que no puede conectar con Ollama** → Casi siempre Ollama volvió a escuchar solo en `127.0.0.1`. Corré `launchctl setenv OLLAMA_HOST 0.0.0.0:11434`, cerrá la app de Ollama (ícono → Quit) y reabrila. Confirmá que `.env` tenga `OPENAI_BASE_URL=http://host.docker.internal:11434/v1`.

**Responde lento** → Sin GPU el modelo corre en CPU. Probá un modelo más liviano (ej. `qwen3:4b` de [ollama.com/library](https://ollama.com/library)) o usá una máquina con GPU.

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
