# Hermes + Ollama en local con Docker 🐳🤖

Corré el agente **[Hermes](https://nousresearch.com/)** de Nous Research **100% en tu máquina**, con un modelo de lenguaje **local servido por [Ollama](https://ollama.com/)** — sin pagar API, sin mandar tus datos a ningún lado.

> 📺 **Video del tutorial:** _(pegá acá el link de YouTube cuando lo subas)_

Funciona en **Windows, macOS y Linux**. Un solo script detecta tu sistema operativo y tu GPU y deja todo listo.

---

## ✨ Qué vas a tener

- 🧠 **Hermes** (el agente CLI de Nous Research) corriendo dentro de Docker.
- 🦙 **Ollama** sirviendo un modelo local — por defecto `qwen3:8b` (~5GB).
- 🔀 **El modelo se cambia con UNA variable** (`OLLAMA_MODEL` en `.env`).
- ⚡ **GPU NVIDIA automática** si tenés una; si no, corre en CPU.
- 🍏 **Modo nativo en Mac**: como Docker no puede usar la GPU de Apple, en macOS Ollama corre nativo y Hermes le pega desde el contenedor (todo automático).

---

## ✅ Requisitos

| | |
|---|---|
| **Docker Desktop** | [Windows](https://www.docker.com/products/docker-desktop/) · [macOS](https://www.docker.com/products/docker-desktop/) · [Linux](https://docs.docker.com/engine/install/) |
| **Disco** | ~5GB para `qwen3:8b` (más para modelos grandes) |
| **RAM** | 8GB mínimo para `qwen3:8b`; más para modelos grandes |
| **GPU** _(opcional)_ | NVIDIA acelera muchísimo. Sin GPU funciona igual, más lento. |
| **macOS** | Hace falta [Ollama para Mac](https://ollama.com/download/mac) (corre nativo y usa la GPU Metal) |

---

## 🚀 Inicio rápido

```bash
# 1. Cloná el repo
git clone https://github.com/fcori47/dios-ia-hermes-local.git
cd dios-ia-hermes-local
```

### macOS / Linux

```bash
./scripts/start.sh
```

### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1
```

> Windows bloquea por defecto la ejecución de scripts `.ps1`. El comando de arriba lo permite **solo para esa ejecución**, sin tocar la configuración de tu PC.

El script:
1. Crea tu `.env` desde `.env.example` (si no existe).
2. Detecta SO + GPU y elige el modo correcto.
3. Levanta Ollama y **descarga el modelo** (`qwen3:8b` por defecto).
4. Lanza el **wizard de Hermes** (login OAuth + selección de modelo).

Cuando termina, para chatear:

```bash
# macOS / Linux
./scripts/chat.sh
```
```powershell
# Windows
powershell -ExecutionPolicy Bypass -File .\scripts\chat.ps1
```

> Estos scripts levantan Ollama si hace falta y abren el chat. En modo bundled
> (Windows/Linux), si preferís el comando directo, primero asegurate de que Ollama
> esté arriba: `docker compose --profile bundled up -d ollama` y después
> `docker compose run --rm hermes`. En macOS no hace falta (Ollama corre nativo).

---

## 🔧 Cambiar el modelo

Editá una sola línea en `.env`:

```dotenv
OLLAMA_MODEL=qwen3:8b
```

Cualquier modelo de [ollama.com/library](https://ollama.com/library) sirve:

| Modelo | Tamaño | Notas |
|---|---|---|
| `qwen3:8b` | ~5GB | Liviano, corre en casi cualquier PC **(default)** |
| `qwen3:14b` | ~9GB | Mejor calidad, pide GPU/PC decente |
| `qwen3:30b` | ~19GB | Muy capaz, pesado (mucha RAM/VRAM) |
| `hermes3` | ~4.7GB | Modelo Hermes de Nous Research |
| `llama3.1:8b` | ~4.9GB | Alternativa popular |

Después de cambiarlo, volvé a correr el script de arranque para descargarlo y re-seleccionarlo en Hermes.

---

## 🧠 Cómo funciona (dos modos)

```
┌──────────── Windows / Linux (modo "bundled") ────────────┐
│                                                          │
│   ┌─────────────┐         ┌──────────────────────────┐  │
│   │   hermes    │ ──/v1──▶│  ollama  (Docker)         │  │
│   │  (Docker)   │         │  GPU NVIDIA si hay, sino  │  │
│   └─────────────┘         │  CPU                      │  │
│                           └──────────────────────────┘  │
└──────────────────────────────────────────────────────────┘

┌──────────────────── macOS (modo "host") ─────────────────┐
│                                                          │
│   ┌─────────────┐                ┌────────────────────┐  │
│   │   hermes    │ ──host.docker──▶│  ollama (NATIVO)   │  │
│   │  (Docker)   │   .internal/v1  │  usa la GPU Metal  │  │
│   └─────────────┘                └────────────────────┘  │
└──────────────────────────────────────────────────────────┘
```

**¿Por qué en Mac es distinto?** Docker en macOS corre dentro de una VM Linux que **no puede acceder a la GPU (Metal) de Apple**. Si metieras Ollama en Docker en una Mac, correría en CPU = lentísimo. Por eso en Mac Ollama va nativo (usa la GPU) y solo Hermes va en Docker. El script lo resuelve solo.

---

## 📂 Estructura del repo

```
.
├── docker-compose.yml        # Servicios: ollama, pull-model, hermes, hermes-setup
├── docker-compose.gpu.yml    # Override para GPU NVIDIA (se agrega solo)
├── Dockerfile.hermes         # Imagen del agente Hermes
├── .env.example              # Variables (copialo a .env)
└── scripts/
    ├── start.sh / start.ps1  # Arranque con auto-detección (macOS·Linux / Windows)
    ├── chat.sh  / chat.ps1   # Abrir el chat (levanta Ollama si hace falta)
    ├── pull-model.sh         # Descarga del modelo
    └── setup-hermes.sh       # Wizard de primer arranque
```

---

## 🧰 Comandos útiles

```bash
# Chatear con Hermes (levanta Ollama si hace falta)
./scripts/chat.sh                  # Windows: powershell -ExecutionPolicy Bypass -File .\scripts\chat.ps1

# Equivalente manual en modo bundled (Windows/Linux):
#   docker compose --profile bundled up -d ollama   # asegurar Ollama arriba
#   docker compose run --rm hermes

# Abrir una shell dentro del contenedor de Hermes
docker compose run --rm --entrypoint bash hermes

# Re-hacer el setup (login / modelo)
docker compose run --rm hermes-setup

# (modo bundled) Ver/loguear Ollama
docker compose --profile bundled up -d ollama
docker compose --profile bundled logs ollama --follow

# Estado de los contenedores
docker compose ps

# Parar todo (los datos quedan en los volúmenes)
docker compose down

# Parar y BORRAR todo, incluido el modelo descargado (cuidado)
docker compose down -v
```

> `docker compose down` ya frena y borra todos los contenedores del proyecto
> (incluido Ollama) sin necesidad de `--profile`. Después de un `down` en modo
> bundled, volvé a chatear con `./scripts/chat.sh` (o levantá Ollama de nuevo
> con `docker compose --profile bundled up -d ollama`).

---

## 📎 Darle a Hermes acceso a una carpeta tuya

1. En `.env`, descomentá y ajustá:
   ```dotenv
   WORKSPACE_PATH=./workspace          # o una ruta absoluta de tu PC
   ```
2. En `docker-compose.yml`, descomentá la línea del volumen bajo el servicio `hermes`:
   ```yaml
   - ${WORKSPACE_PATH:-./workspace}:/workspace
   ```
3. `docker compose run --rm hermes` → tus archivos están en `/workspace`.

---

## 🩺 Problemas comunes

**"Docker no está corriendo"** → Abrí Docker Desktop y esperá a que arranque.

**Mac: el contenedor no alcanza Ollama** → Asegurate de que Ollama escuche en todas las interfaces:
```bash
launchctl setenv OLLAMA_HOST 0.0.0.0:11434   # y reiniciá la app de Ollama
```
(el script `start.sh` ya levanta Ollama así si no estaba corriendo).

**El modelo tarda mucho / responde lento** → Sin GPU el modelo corre en CPU. Probá uno más chico (`qwen3:8b`) o usá una máquina con GPU NVIDIA (Win/Linux) o Apple Silicon (Mac).

**Windows: no detecta la GPU** → Necesitás Docker Desktop con backend **WSL2** y los drivers NVIDIA al día. Verificá con `nvidia-smi` en PowerShell.

**Windows: `start.ps1 cannot be loaded because running scripts is disabled`** → Es la política de ejecución de PowerShell. Corré el script así (no cambia la config de tu PC): `powershell -ExecutionPolicy Bypass -File .\scripts\start.ps1`. Si lo bajaste como ZIP y aparece "is not digitally signed", desbloquealo: `Unblock-File .\scripts\start.ps1`.

**`could not select device driver "nvidia" with capabilities: [[gpu]]`** → Tenés el driver NVIDIA pero Docker no puede pasar la GPU. En Linux instalá el [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) y reiniciá Docker; en Windows actualizá Docker Desktop con backend WSL2. Los scripts ya prueban esto y caen a CPU solos, pero si lo corrés a mano, omití `-f docker-compose.gpu.yml`.

**Windows/Linux: `port is already allocated` al levantar Ollama** → Ya tenés Ollama nativo ocupando el 11434. El contenedor no necesita ese puerto publicado (Hermes le pega por la red interna de Docker), así que dejá comentado el mapeo `ports` del servicio `ollama`. Si querés publicarlo igual, poné `OLLAMA_HOST_PORT=11435` en `.env` y descomentá el `ports`.

**El OAuth no redirige** → Copiá la URL completa que muestra Hermes, abrila en el browser del host, y si pide pegar la URL de vuelta, pegá la del browser tras autorizar.

---

## 🙏 Créditos

- **Hermes** — agente de [Nous Research](https://nousresearch.com/).
- **Ollama** — [ollama.com](https://ollama.com/).
- Modelos **Qwen3** — Alibaba / comunidad open source.

## 📄 Licencia

[MIT](./LICENSE) — usalo, modificalo y compartilo libremente.
