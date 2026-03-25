# nzgTelegramBot 🚀

[![Docker Build Status](https://github.com/NazgulCoder/nzgTelegramBot/actions/workflows/telegram-bot-build.yml/badge.svg)](https://github.com/NazgulCoder/nzgTelegramBot/actions)

A self-hosted instance of the [Telegram Bot API](https://github.com/tdlib/telegram-bot-api) designed to help you completely bypass the standard 50MB file upload limit for Telegram Bots. 

By running your own local API server, your bots can upload files up to **2000 MB** and download files up to **4000 MB**.

## ✨ Features
* **Bypass Upload Limits:** Send and receive massive files using your own Telegram bots.
* **Always Up-to-Date:** Powered by a GitHub Action that checks for new Telegram API commits and Alpine Linux security patches every Sunday. It automatically builds a new image only when necessary.
* **Lightweight & Fast:** Built from source on `alpine:latest` using a multi-stage Docker build to keep the final image size incredibly small.
* **Secure by Design:** API credentials are never baked into the Docker image. They are passed securely at runtime via environment variables.

---

## ⚙️ Prerequisites
To run this container, you need an active Telegram `API_ID` and `API_HASH`.
1. Log in to your Telegram account at [my.telegram.org](https://my.telegram.org).
2. Go to **API development tools**.
3. Create a new application (or use an existing one) to get your `App api_id` and `App api_hash`.

---

## 🚀 Quick Start

### Option A: Using Docker CLI
You can spin up the container instantly using standard Docker commands. Replace `YOUR_API_ID` and `YOUR_API_HASH` with your actual credentials.

```bash
docker run -d \
  --name nzg-telegram-bot \
  -p 8081:8081 \
  -e API_ID=YOUR_API_ID \
  -e API_HASH=YOUR_API_HASH \
  -v /path/to/local/data:/var/lib/telegram-bot-api \
  ghcr.io/nazgulcoder/telegram-bot-api:latest
