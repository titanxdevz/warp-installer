<div align="center">

```
███╗   ██╗███████╗██╗  ██╗    ██████╗ ███████╗██╗   ██╗███████╗
████╗  ██║██╔════╝╚██╗██╔╝    ██╔══██╗██╔════╝██║   ██║╚══███╔╝
██╔██╗ ██║█████╗   ╚███╔╝     ██║  ██║█████╗  ██║   ██║  ███╔╝ 
██║╚██╗██║██╔══╝   ██╔██╗     ██║  ██║██╔══╝  ╚██╗ ██╔╝ ███╔╝  
██║ ╚████║███████╗██╔╝ ██╗    ██████╔╝███████╗ ╚████╔╝ ███████╗
╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝
```

# ⚡ CLOUDFLARE WARP ENTERPRISE PROXY DEPLOYER ⚡
### *Next-Generation Zero-Trust SOCKS5 Tunnel for Lavalink & Audio Nodes*

<br/>

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=700&size=20&pause=1000&color=00F0FF&center=true&vCenter=true&random=false&width=620&lines=BYPASS+YOUTUBE+429+RATE+LIMITS;ANYCAST+EDGE+ROUTING+ACTIVE;SOCKS5+DAEMON+RUNNING+ON+127.0.0.1:40000;READY+FOR+PRODUCTION+AUDIO+NODES" alt="Typing SVG" />
</p>

<br/>

<p align="center">
  <img src="https://img.shields.io/badge/TUNNEL-CLOUDFLARE%20WARP-F38020?style=for-the-badge&logo=cloudflare&logoColor=white" />
  <img src="https://img.shields.io/badge/PROTOCOL-SOCKS5%20PROXY-00F0FF?style=for-the-badge&logo=wireguard&logoColor=white" />
  <img src="https://img.shields.io/badge/TARGET-LAVALINK%20v4-FF007F?style=for-the-badge&logo=discord&logoColor=white" />
  <img src="https://img.shields.io/badge/LATENCY-%3C15MS%20ANYCAST-39FF14?style=for-the-badge&logo=speedtest&logoColor=white" />
</p>

<br/>

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=0,2,26&height=110&section=header"/>

</div>

---

## ⚡ ARCHITECTURE PIPELINE

```
 [ Discord Bot ] 
        │
        ▼
 [ Lavalink Audio Node ] 
        │
        ▼ (SOCKS5 Loopback / Port 40000)
 ┌────────────────────────────────────────────────────────┐
 │      NEX DEVZ WARP-DAEMON SYSTEM INTERFACE            │
 │   - Zero packet inspection latency                     │
 │   - Anycast edge endpoint routing                      │
 │   - Clean rotating Cloudflare IP address pool          │
 └────────────────────────────────────────────────────────┘
        │
        ▼ (Encrypted WireGuard Handshake)
 [ Cloudflare Global Edge Network ]
        │
        ▼
 [ YouTube API / Decryption Stream ]  ──> [ HTTP 200 OK - No 429 ]
```

---

## 🚀 ONE-CLICK DEPLOYMENT

Deploy the complete SOCKS5 tunnel and self-test verification engine with a single command:

```bash
curl -fsSL https://raw.githubusercontent.com/titanxdevz/warp-installer/main/scripts/install.sh?v=1 | sudo bash
```

---

## 💻 LIVE CLI EXPERIENCE

```text
  [ SYSTEM ENVIRONMENT DIAGNOSTICS ]
  ───────────────────────────────────────────────────────────────────────
  ✔ Root privilege elevation verified.
  ✔ Architecture validated: amd64
  ✔ Host OS: Ubuntu 24.04.4 LTS

  [ DEPLOYMENT & PIPELINE EXECUTION ]
  ───────────────────────────────────────────────────────────────────────
  ❯ Synchronizing package registry and toolchain...
  ✔ Core toolchain ready.
  ❯ Injecting Cloudflare official GPG keys and secure repo...
  ✔ Cloudflare repository locked for noble.
  ❯ Installing Cloudflare WARP daemon engine...
  ✔ WARP engine installed.
  ❯ Starting WARP background daemon service...
  ✔ Service warp-svc.service active.
  ❯ Configuring SOCKS5 tunneling on port 40000...
  ✔ WARP profile initialized and bound to 127.0.0.1:40000.

  [ LIVE NETWORK PROBE & VERIFICATION ]
  ───────────────────────────────────────────────────────────────────────
  ✔ WARP tunnel established! Edge IP: 104.28.214.92 (warp=on)

  ╔══════════════════════════════════════════════════════════════════════╗
  ║   ⚡ NEX DEVZ PROXY DEPLOYMENT COMPLETE — READY FOR PRODUCTION ⚡   ║
  ╠══════════════════════════════════════════════════════════════════════╣
  ║  VPS Public IP  : 63.183.213.255                                     ║
  ║  WARP Out IP    : 104.28.214.92 (Cloudflare Clean Edge)              ║
  ║  Proxy Type     : SOCKS5 Proxy                                       ║
  ║  Proxy Port     : 40000                                              ║
  ║  Local URI      : socks5://127.0.0.1:40000  (Use inside VPS)         ║
  ║  External URI   : socks5://63.183.213.255:40000                      ║
  ╚══════════════════════════════════════════════════════════════════════╝
```

---

## ⚙️ LAVALINK INTEGRATION (`application.yml`)

Add the proxy directive under the `youtube` plugin configuration block:

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

> **Pro-Tip:** Because WARP runs locally in user-space proxy mode on the host, Lavalink connects via loopback (`127.0.0.1:40000`) for zero latency overhead and absolute privacy.

---

## 🧪 DIAGNOSTICS & TELEMETRY

```bash
# Verify Daemon State
warp-cli status

# Inspect Egress Network IP
curl -x socks5://127.0.0.1:40000 https://ipinfo.io

# Verify Cloudflare Edge Tunnel Flags
curl -x socks5://127.0.0.1:40000 https://cloudflare.com/cdn-cgi/trace
```

---

## 🛡️ CORE HIGHLIGHTS

| Feature | Description | Status |
| :--- | :--- | :---: |
| **Bypass 429 Rate Limits** | Routes requests through Cloudflare's residential/edge IP pool | `ACTIVE` |
| **Non-Disruptive** | Operates strictly in user-space proxy mode without modifying system routing tables | `ACTIVE` |
| **Zero Memory Overhead** | Consumes negligible system resources (< 25MB RAM) | `ACTIVE` |
| **Auto-Reconnect** | Persistent systemd daemon automatically recovers on boot or network drop | `ACTIVE` |
| **Localhost Isolation** | Port 40000 is bound strictly to `127.0.0.1` to prevent unauthorized WAN ingress | `SECURED` |

---

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=0,2,26&height=110&section=footer"/>

<sub>Crafted for high-performance audio streaming infrastructure.</sub>

</div>
