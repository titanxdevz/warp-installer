<div align="center">

# ⚡ Cloudflare WARP SOCKS5 Proxy Installer

**Automated 1-Click Installer for Lavalink & Discord Music Bots**

[![GitHub Stars](https://img.shields.io/github/stars/titanxdevz/warp-installer?style=flat-square)](https://github.com/titanxdevz/warp-installer)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](LICENSE)
[![Platform: Ubuntu/Debian](https://img.shields.io/badge/Platform-Ubuntu%20%7C%20Debian-orange?style=flat-square)](https://ubuntu.com/)

</div>

---

## 📖 Overview

Are your Discord music bots facing **YouTube 429 Rate Limits**, **`AllClientsFailedException`**, or **`Read timed out`** errors on your VPS?

This repository provides an automated, production-ready Bash installer that equips your server with **Cloudflare WARP in SOCKS5 Proxy Mode** on local port `127.0.0.1:40000`. It routes all Lavalink YouTube traffic through Cloudflare's clean edge network, bypassing bot detection and regional IP restrictions completely.

---

## 🚀 Quick Install (1-Line Command)

Run this command directly in your Ubuntu / Debian VPS terminal:

```bash
curl -sSL https://raw.githubusercontent.com/titanxdevz/warp-installer/main/scripts/install.sh | sudo bash
```

---

## 🛠 Manual Installation

If you prefer to review or run the script manually:

```bash
# 1. Clone the repository
git clone https://github.com/titanxdevz/warp-installer.git

# 2. Enter directory
cd warp-installer/scripts

# 3. Give execute permission
chmod +x install.sh

# 4. Run installer
sudo ./install.sh
```

---

## ⚙️ Lavalink Configuration (`application.yml`)

Once the installer finishes, add the proxy setting to your Lavalink `application.yml` under the `youtube` plugin:

```yaml
plugins:
  youtube:
    enabled: true
    allowSearch: true
    allowDirectVideoIds: true
    allowDirectPlaylistIds: true
    clients:
      - MUSIC
      - ANDROID_VR
      - WEB
      - TVHTML5EMBEDDED
    proxy:
      url: "socks5://127.0.0.1:40000"
```

Restart Lavalink, and all playback and searches will now stream seamlessly through Cloudflare!

---

## 🔍 Verification Commands

Test if the proxy is healthy and functioning on your server:

```bash
# Check Cloudflare WARP service status
warp-cli status

# Test connection and view assigned Cloudflare IP
curl -x socks5://127.0.0.1:40000 https://ipinfo.io

# Verify Cloudflare trace (look for warp=on)
curl -x socks5://127.0.0.1:40000 https://cloudflare.com/cdn-cgi/trace
```

---

## ✨ Features

- 🛡️ **Root & Architecture Safety Checks**: Verifies AMD64 / x86_64 system requirements.
- 🔑 **Automated Keyring & Repo Setup**: Installs official Cloudflare GPG keys and APT sources.
- ⚡ **Zero-Touch Config**: Registers client, switches to SOCKS5 proxy mode, and binds to port `40000`.
- 🧪 **Self-Test on Completion**: Automatically tests connectivity before exiting.
- 🔒 **Secure Localhost Only**: Doesn't expose ports publicly to the internet.

---

## 👤 Author & Credits

- **Repository**: [titanxdevz/warp-installer](https://github.com/titanxdevz/warp-installer)
- **Author**: TitanX ([@titanxdevz](https://github.com/titanxdevz))
- **Email**: `inkmcontop@gmail.com`

---

## 📄 License

This project is licensed under the MIT License.
