# Hermes + Ollama en local con Docker 🐳🤖

> **Una IA que vive en TU computadora.** Open-source, tuya, y no depende de nadie.

Esto no es un chat más. **[Hermes](https://nousresearch.com/)** (el agente open-source de Nous Research) es un asistente de IA que corre en tu propia máquina con un modelo de lenguaje servido por **[Ollama](https://ollama.com/)**. Tus conversaciones se procesan **localmente**, sin pagar por uso de API y sin que tus datos salgan de tu PC.

Cuando tu IA vive en la nube de otro, te la pueden cortar de un día para el otro. Acá corre en tu máquina: **mientras la tengas prendida, es tuya y no te la apaga nadie.** Dejás de alquilar tu inteligencia — ahora es tuya.

> 📺 **Video paso a paso (YouTube):** https://www.youtube.com/@FacundoCorengia — **(PEGAR EL ENLACE DIRECTO DEL VIDEO ANTES DE PUBLICAR)**
>
> <!-- TODO: cuando esté subido, generar el enlace con UTM desde /utms (utm_source=github) para atribuir el tráfico del repo. -->

<!-- TODO: GIF / captura del chat de Hermes respondiendo en la terminal (lo más potente para empujar el clone). Va acá arriba. -->

✅ Funciona en **Windows** y **macOS** (y Linux). No hace falta saber programar: vas a **copiar y pegar** unos pocos comandos. Te explico cada paso y qué vas a ver en pantalla.

---

## 🚫 Seamos honestos (antes de arrancar)

Esto **NO es Fable 5 ni Opus**. Es un modelo que corre en TU compu — privado, gratis y tuyo — pero hoy **no le llega ni cerca a los grandes de la nube.** Para tareas pesadas vas a seguir queriendo esos.

No es magia: **hay que configurarlo bien y pide una máquina decente** (RAM y paciencia). Lo que ganás acá es que es tuyo, nadie te lo apaga, y mejora solo con el tiempo y con mejor hardware. Si buscás el modelo más potente del mundo, esto no es para eso. Si querés tu propia IA, sin depender de nadie, seguí leyendo.

---

## 📑 Índice

- [¿Qué es esto y por qué lo querés?](#-qué-es-esto-y-por-qué-lo-querés)
- [Qué hace ESTE repo (y qué es del propio Hermes)](#-qué-hace-este-repo-y-qué-es-del-propio-hermes)
- [Inicio rápido (si ya tenés Docker)](#-inicio-rápido-si-ya-tenés-docker)
- [¿Qué es cada cosa? (glosario rápido)](#-qué-es-cada-cosa-glosario-rápido)
- [Antes de empezar: requisitos](#-antes-de-empezar-requisitos)
- [Paso 0 — Instalar los programas](#-paso-0--instalar-los-programas-necesarios)
- [Paso 1 — Descargar el proyecto](#-paso-1--descargar-el-proyecto)
- [Paso 2 — Arrancar](#-paso-2--arrancar-descarga-el-modelo-y-prepara-todo)
- [Paso 3 — Iniciar sesión y elegir modelo](#-paso-3--iniciar-sesión-en-hermes-y-elegir-el-modelo)
- [Paso 4 — Chatear con Hermes](#-paso-4--chatear-con-hermes)
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
- [¿Algo no anda?](#-algo-no-anda)
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

Lo más importante para que no haya humo: **este repo te deja Hermes corriendo 100% local y un chat en la terminal.** Esa es la base. Las capacidades grandes que ves en el video (canales como Telegram/WhatsApp, tareas programadas, memoria, skills) son funciones **nativas del agente Hermes de Nous Research** que se activan **adentro de Hermes** una vez que iniciás sesión — **este repo no las configura (todavía).**

| Capacidad | Estado |
|---|---|
| Chat con IA **100% local** (`hermes chat`) | ✅ lo arma este repo |
| **Sin costo de API** (el modelo corre en tu PC) | ✅ lo arma este repo |
| **Windows / macOS / Linux** | ✅ lo arma este repo |
| **GPU NVIDIA** auto-detectada por los scripts · **Apple Metal**: la usa Ollama nativo en Mac (sin config del repo) | ✅ NVIDIA la arma este repo · Metal corre sola en Mac |
| Cambiar de modelo desde `.env` | ✅ lo arma este repo |
| Darle acceso a **una carpeta tuya** (workspace) | ✅ lo arma este repo (opcional) |
| Telegram · WhatsApp · Discord · Slack · Email | ⚙️ función del agente Hermes — se configura aparte |
| Tareas programadas (crons) | ⚙️ función del agente Hermes — se configura aparte |
| Memoria que aprende + skills auto-mejorables | ⚙️ función del agente Hermes — se configura aparte |
| Las 40+ herramientas de fábrica (terminal, archivos, navegador, código, imágenes, agenda) | ⚙️ vienen con el agente Hermes; cuáles quedan activas y cuáles piden configuración extra depende de Hermes |

**¿Qué hago con lo del repo entonces?** Tenés a Hermes andando en tu máquina y le hablás por la terminal. Eso ya es un montón: es tu IA, tuya, sin que nada salga de tu PC. Y a partir de ahí, conectarle Telegram, ponerle crons y darle memoria es el paso siguiente — lo vemos en [Y ahora qué](#-y-ahora-qué-hacia-lo-que-viste-en-el-video).

> ⚠️ Para activar canales, crons o memoria, mirá la doc oficial del agente en **[nousresearch.com](https://nousresearch.com/)**. Acá no te voy a tirar comandos inventados: si un paso no está en este repo, te mando a la fuente real en vez de hacerte humo.

---

## ⚡ Inicio rápido (si ya tenés Docker)

¿Ya tenés Docker corriendo y sos de los que prefieren los comandos directos? Tres líneas:

```bash
git clone https://github.com/fcori47/dios-ia-hermes-local.git && cd dios-ia-hermes-local
bash scripts/start.sh    # (o  .\scripts\start.ps1  en Windows) — descarga el modelo + inicia sesión
bash scripts/chat.sh     # (o  .\scripts\chat.ps1   en Windows) — chatear
```

> **🍏 En Mac:** además de Docker necesitás **Ollama instalado nativo** (corre la GPU de Apple). Si no lo tenés, `start.sh` te corta con *"Ollama no está instalado en el host"*. Instalalo primero — está explicado en el [Paso 0 (macOS)](#-paso-0--instalar-los-programas-necesarios).

> **¿Primera vez con Docker / no sos técnico?** Saltá al paso a paso detallado de abajo 👇 — está explicado todo, una cosa a la vez.

---

## 🧠 ¿Qué es cada cosa? (glosario rápido)

Si estos nombres te suenan a chino, leé esto una vez y listo:

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

> 🎥 **¿Nunca instalaste Docker o no te arranca en Windows?** Guía en video, paso a paso, para dejarlo funcionando: **https://www.youtube.com/watch?v=ZyBBv1JmnWQ**

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
2. **Elegir el modelo:** se abre una lista. Movete con las **flechas** y elegí **el modelo que configuraste en `.env`** (por defecto `qwen3:8b`) con **ENTER**.

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

> ⚠️ El chat solo funciona **después** de haber hecho el **Paso 2** (descarga del modelo) y el **Paso 3** (iniciar sesión) al menos una vez. El chat **no** descarga el modelo ni inicia sesión por vos.

> 💡 **Windows/Linux:** salir del chat **no apaga** Ollama (queda en segundo plano para que el próximo chat arranque al toque). Para liberar esa memoria, corré `docker compose down`.
> **macOS:** mantené la app de **Ollama** abierta. Si reiniciaste la Mac o cerraste Ollama, antes de chatear volvé a correr `bash scripts/start.sh`.

### 🧪 Probá que anda de verdad

Para confirmar que tu Hermes local hace cosas (y no quedó como un chat pelado), montale una carpeta tuya (ver [Darle a Hermes acceso a una carpeta tuya](#-darle-a-hermes-acceso-a-una-carpeta-tuya-opcional)) y pedile algo concreto:

```
> listá los archivos de /workspace
> creá un archivo prueba.txt con la palabra hola
```

Si te lista la carpeta o te crea el archivo, las herramientas de fábrica están respondiendo. **Ojo:** con un modelo chico como `qwen3:8b`, a veces el modelo te contesta en texto en vez de **disparar la herramienta** — no siempre la llama a la primera. Si no la usó, reformulá el pedido más directo ("usá la herramienta de archivos y listá /workspace") o probá un modelo más grande. Las demás herramientas (navegador, generación de imágenes, etc.) pueden pedir red o configuración extra — **eso depende del agente Hermes**, no de este repo (ver doc de Nous Research).

---

## 🔭 Y ahora qué: hacia lo que viste en el video

Hasta acá tenés **la base: Hermes corriendo 100% local y un chat en la terminal.** Eso ya es tu IA, tuya, sin que nada salga de tu compu.

En el video viste más que un chat: a Hermes hablándote por **Telegram**, corriendo **tareas solas** y **acordándose** de lo que hacés. Que quede clarísimo, sin humo:

- **Lo que arma este repo:** Hermes + Ollama en local, iniciar sesión, elegir modelo, chatear y darle acceso a una carpeta tuya. Punto.
- **Lo que es del propio Hermes (se configura aparte):** los **canales** (Telegram, WhatsApp, Discord, Slack, Email), las **tareas programadas (crons)**, la **memoria** y las **skills**. Son funciones del agente de Nous Research que se activan **adentro de Hermes** una vez logueado. La guía oficial está en **[nousresearch.com](https://nousresearch.com/)**.

> No te voy a tirar un `hermes telegram ...` o `hermes cron ...` que no esté verificado contra la doc oficial. Si no lo confirmé, te mando a la fuente real — eso es lo opuesto al humo.

**En el próximo video lo conectamos a Telegram y le ponemos tareas programadas**, y armamos la visión completa (ver [Cómo se reparte con Claude Code](#-cómo-se-reparte-con-claude-code)).

---

## 🔧 Cambiar el modelo de IA

El modelo se elige con **una sola línea** en el archivo `.env` (se crea solo la primera vez que arrancás):

```dotenv
OLLAMA_MODEL=qwen3:8b
```

Cambiá ese valor por cualquier modelo de **[ollama.com/library](https://ollama.com/library)**:

| Modelo | Tamaño | Para qué |
|---|---|---|
| `qwen3:8b` | ~5 GB | Liviano, anda en casi cualquier PC **(por defecto)** |
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

**¿Por qué en Mac es distinto?** Docker en macOS no puede usar la GPU de Apple. Si Ollama corriera dentro de Docker en una Mac, iría lentísimo (solo CPU). Por eso en Mac Ollama corre nativo (usa la GPU Metal por su cuenta) y solo Hermes va en Docker. **Los scripts resuelven todo esto solos.**

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

**Repetir el asistente** (iniciar sesión / elegir modelo) — volvé a correr el Paso 2, que levanta Ollama y reabre el asistente:
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

- **¿Necesito internet?** Sí, **una sola vez** para: descargar el proyecto, bajar el modelo (~5 GB) y activar tu cuenta de Hermes (el inicio de sesión del Paso 3). Después, la IA (el modelo) corre en tu propia máquina vía Ollama.
- **¿Por qué me pide "iniciar sesión" si es local?** Ese inicio de sesión es para activar tu cuenta de **Hermes** (el agente de Nous Research), no para mandar el modelo a la nube. Las respuestas las genera el modelo local de Ollama en tu PC.
- **¿Y la soberanía?** Cuando tu IA vive en la nube de otro, te la pueden cortar de un día para el otro. Acá corre en tu máquina: **mientras la tengas prendida, es tuya y no te la apaga nadie.**
- **¿Tiene costo?** No pagás por uso del modelo local: corre en tu hardware. Si la cuenta de Hermes tuviera algún costo o límite, verificalo en [nousresearch.com](https://nousresearch.com/).
- **¿Querés saber exactamente qué datos maneja la cuenta de Hermes** (inicio de sesión, telemetría)? Revisá los términos/privacidad en [nousresearch.com](https://nousresearch.com/).

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

**Windows: Docker no arranca / pide WSL 2 o "WSL kernel version too low"** → Reiniciá la PC una vez. Si sigue, abrí PowerShell y corré `wsl --update`, después reabrí Docker Desktop. ¿Nunca instalaste Docker o no te arranca? Guía en video paso a paso: **https://www.youtube.com/watch?v=ZyBBv1JmnWQ**

**Windows: `start.ps1 cannot be loaded because running scripts is disabled`** → Usá siempre el comando completo: `powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1` (no cambia nada en tu PC). Si bajaste el ZIP y dice *"is not digitally signed"*, desbloquealo: `Unblock-File .\scripts\start.ps1`.

**Windows: uso Ollama nativo (`start.ps1 host`) y el chat no conecta** → Si elegiste reusar tu Ollama nativo con `start.ps1 host`, **asegurate de que la app de Ollama esté abierta** antes de chatear (en Windows suele autoarrancar, pero si la cerraste, el chat falla con "connection refused"). Abrí Ollama y reintentá.

**Mac: el chat dice que no puede conectar con Ollama** → Casi siempre es porque la app de Ollama volvió a escuchar solo en `127.0.0.1`. Lo más fácil: volvé a correr `bash scripts/start.sh` y después chateá. A mano: (1) cerrá Ollama (ícono en la barra de menú → **Quit**), (2) pegá `launchctl setenv OLLAMA_HOST 0.0.0.0:11434` (no necesitás entenderlo: le dice a Ollama que acepte conexiones desde Docker), (3) reabrí la app de Ollama, (4) reintentá.

**Mac: "Ollama no está instalado en el host"** → Abrí la app de Ollama una vez (instala el comando), después **cerrá y reabrí la Terminal**, volvé a entrar a la carpeta (`cd dios-ia-hermes-local`) y reintentá el Paso 2. Si sigue: `brew install ollama`.

**`could not select device driver "nvidia"`** → Tenés GPU NVIDIA pero Docker todavía no la puede usar. En Windows: actualizá Docker Desktop y activá **WSL2**. En Linux: instalá el [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html). Igual el script cae a CPU solo y sigue funcionando.

**Windows/Linux: `port is already allocated`** → Ya tenés otro Ollama usando el puerto 11434. No pasa nada: el contenedor no lo necesita publicado. Si querés, poné `OLLAMA_HOST_PORT=11435` en `.env`.

**Windows: ya tengo Ollama instalado y no quiero bajar el modelo dos veces** → Usá tu Ollama nativo (abierto y corriendo) con: `powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1 host`. Así Hermes le pega a ese Ollama y no descarga otra copia del modelo dentro de Docker.

**El inicio de sesión se queda esperando / "puerto 8080 ocupado"** → Otro programa usa el 8080. Editá `.env`, agregá `HERMES_OAUTH_PORT=8081`, y volvé a correr el Paso 2.

**El inicio de sesión (URL) no se abre** → Copiá la dirección web que muestra Hermes y pegala vos mismo en el navegador. Tras autorizar, volvé a la terminal.

**Responde lento** → Sin GPU el modelo corre en CPU. Probá uno más chico (`qwen3:8b`) o usá una máquina con GPU.

---

## 🧩 Cómo se reparte con Claude Code

Acá viene la parte que nadie cuenta: **Hermes no reemplaza a Claude Code. Lo completa.**

- Con **Claude Code** te sentás y **construís**: apps, sistemas, tu herramienta de laburo.
- **Hermes** es el que va a hacer lo **repetitivo** mientras construís. Ojo: eso no sale de fábrica con este repo. Una vez que le conectás los **canales** (Telegram/WhatsApp) y las **tareas programadas (crons)** —que se configuran adentro de Hermes, no acá— recién ahí puede contestar clientes, mandar mails de seguimiento y correr tus rutinas solo.

La idea, cuando lo tengas armado completo, es esa: mientras vos construís algo con Claude Code, Hermes va contestando y dejando todo ordenado. No frenás lo tuyo y las cosas igual pasan. El destino es **un empleado de IA 24/7, en tu compu, mientras la tengas prendida, y tuyo** — pero los canales y los crons son **el paso siguiente**, no lo que arma este repo (ver [Y ahora qué](#-y-ahora-qué-hacia-lo-que-viste-en-el-video)).

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

Si seguiste los pasos y algo falla, **abrí un issue acá** 👉 [Issues](https://github.com/fcori47/dios-ia-hermes-local/issues) contando:

- tu sistema (Windows / Mac / Linux),
- en qué paso te trabaste,
- y el **texto exacto del error** (copiá y pegá lo que dice la terminal).

Si arreglaste algo o mejoraste un paso, los **Pull Requests** al README o a los scripts son bienvenidos.

---

## 🙏 Créditos

- **Este tutorial y los scripts** — armados por **Facu, el Dios de la IA** ([facundocorengia.com](https://facundocorengia.com/) · [basdonax.com](https://basdonax.com/)).
- **Hermes** — agente de [Nous Research](https://nousresearch.com/).
- **Ollama** — [ollama.com](https://ollama.com/).
- Modelos **Qwen3** — Alibaba / comunidad open source.

## 📄 Licencia

[MIT](./LICENSE) — usalo, modificalo y compartilo libremente.
