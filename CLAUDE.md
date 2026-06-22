# CLAUDE.md

La guía operativa para agentes de este repo es **[AGENTS.md](./AGENTS.md)** — leela y seguila antes de hacer nada. Lo que sigue es el resumen de 10 segundos.

## Resumen

- **Objetivo:** dejar a **Hermes + Ollama corriendo 100% local** y el **chat abierto** en la terminal del usuario. Eso es lo único que entrega este repo.
- **Vos (el agente) hacés la preparación:** chequear que Docker corra (`docker info`), clonar el repo si falta, leer/editar `.env` (ej. cambiar `OLLAMA_MODEL`), montar el workspace y, sobre todo, **leer los errores que te pegue el humano y diagnosticar**.
- **Tres cosas las hace EL HUMANO en su terminal visible, no vos:**
  1. Instalar **Docker Desktop** y (en Mac) la app de **Ollama** — son instaladores gráficos.
  2. El **inicio de sesión (OAuth)** en el navegador con la cuenta de Nous Research.
  3. El **asistente interactivo** (apretar ENTER + elegir el modelo con las flechas).
- El **login** (`docker compose run --rm --service-ports hermes "hermes setup --portal"`), el **selector de modelo** (`hermes model`) y el **chat** (`docker compose run --rm hermes`) **son interactivos** → los corre el humano en su terminal, no vos en un shell capturado. Vos hacés la preparación no interactiva (levantar Ollama, bajar el modelo, `docker compose build hermes`, tocar `.env`) y destrabás.

## Honestidad (regla dura)

Este repo **NO** configura Telegram, WhatsApp, crons, memoria ni skills. Eso es **nativo del agente Hermes de Nous Research** y se arma aparte → derivá a [nousresearch.com](https://nousresearch.com). No inventes comandos que no estén en este repo.

> Detalle completo para vos (el agente): **[AGENTS.md](./AGENTS.md)**. Tutorial para humanos: **[README.md](./README.md)**.
