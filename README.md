# Cloudflare WARP SOCKS5 Proxy Installer

Enterprise-grade automated deployment script for configuring Cloudflare WARP in SOCKS5 proxy mode on Linux servers. Optimized for Lavalink audio nodes and Discord bots to mitigate rate limits and connection timeouts.

---

## Overview

Modern audio nodes hosted on cloud providers frequently encounter IP-based throttling, HTTP 429 status codes, and `AllClientsFailedException` errors when resolving or streaming YouTube media. 

This repository provides an automated installation script that sets up Cloudflare WARP in local proxy mode. Traffic routed through this local SOCKS5 interface egresses via Cloudflare's anycast edge network, bypassing data center IP restrictions and ensuring reliable playback throughput.

---

## Quick Start

Execute the following command in your server terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/titanxdevz/warp-installer/main/scripts/install.sh | sudo bash
```

---

## Manual Installation

To inspect and run the script manually:

```bash
# Clone the repository
git clone https://github.com/titanxdevz/warp-installer.git

# Navigate to the scripts directory
cd warp-installer/scripts

# Grant execution permissions
chmod +x install.sh

# Run the installer with elevated privileges
sudo ./install.sh
```

---

## Lavalink Configuration

Once the deployment finishes, configure your Lavalink `application.yml` file to route YouTube requests through the local proxy:

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

Restart the Lavalink process or container to apply the configuration.

---

## Verification and Diagnostics

Verify the status and integrity of the local proxy using the following commands:

Check service status:
```bash
warp-cli status
```

Test proxy egress connectivity and verify public IP:
```bash
curl -x socks5://127.0.0.1:40000 https://ipinfo.io
```

Inspect Cloudflare network trace:
```bash
curl -x socks5://127.0.0.1:40000 https://cloudflare.com/cdn-cgi/trace
```

A response containing `warp=on` indicates that traffic is successfully egressing through the Cloudflare network.

---

## Key Features

- **System Compatibility Verification**: Enforces required architecture (x86_64 / amd64) and privilege levels.
- **Repository Management**: Automates GPG key import and APT source list configuration.
- **Non-Intrusive Networking**: Operates in user-space proxy mode without modifying primary host routing tables or default gateways.
- **Automated Validation**: Performs end-to-end handshake validation against Cloudflare endpoints upon deployment.
- **Localhost Binding**: Binds strictly to `127.0.0.1:40000` to prevent unauthorized external access.

---

## System Requirements

- Operating System: Ubuntu 20.04 LTS / 22.04 LTS / 24.04 LTS, Debian 11 / 12
- Architecture: amd64 / x86_64
- Permissions: Root or sudo access

---

## License

This project is licensed under the MIT License.
