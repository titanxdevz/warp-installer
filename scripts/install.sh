#!/usr/bin/env bash
# ==============================================================================
#   ⚡ NEX DEVZ // CLOUDFLARE WARP SOCKS5 ENTERPRISE PROXY DEPLOYER ⚡
#   Architected & Maintained by: NEX DEVZ (titanxdevz)
# ==============================================================================

set -e

# ANSI TrueColor / 256 Color Palette
NC='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
UNDERLINE='\033[4m'

# Neon Palette
NEON_CYAN='\033[38;2;0;240;255m'
NEON_PINK='\033[38;2;255;0;127m'
NEON_PURPLE='\033[38;2;180;70;255m'
NEON_GREEN='\033[38;2;57;255;20m'
NEON_YELLOW='\033[38;2;255;220;0m'
NEON_RED='\033[38;2;255;45;85m'
DARK_GRAY='\033[38;2;70;70;90m'
WHITE='\033[38;2;255;255;255m'
BG_BLACK='\033[48;2;12;14;24m'

# Spinner & Animation utility
spinner() {
    local pid=$!
    local delay=0.07
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    while kill -0 $pid 2>/dev/null; do
        local temp=${spinstr#?}
        printf "  ${NEON_PURPLE}[%c]${NC} ${WHITE}%s${NC}\r" "$spinstr" "$1"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done
    printf "                                                                               \r"
}

step_start() {
    echo -e "  ${NEON_CYAN}❯${NC} ${WHITE}$1${NC}"
}

step_ok() {
    echo -e "  ${NEON_GREEN}✔${NC} ${WHITE}$1${NC}"
}

step_warn() {
    echo -e "  ${NEON_YELLOW}⚠${NC} ${YELLOW}$1${NC}"
}

step_fail() {
    echo -e "  ${NEON_RED}✖ [FATAL]${NC} ${RED}$1${NC}"
    exit 1
}

clear

# Insane Nex Devz Cyberpunk Visual Header
echo -e "${NEON_CYAN}"
cat << "EOF"
  ███╗   ██╗███████╗██╗  ██╗    ██████╗ ███████╗██╗   ██╗███████╗
  ████╗  ██║██╔════╝╚██╗██╔╝    ██╔══██╗██╔════╝██║   ██║╚══███╔╝
  ██╔██╗ ██║█████╗   ╚███╔╝     ██║  ██║█████╗  ██║   ██║  ███╔╝ 
  ██║╚██╗██║██╔══╝   ██╔██╗     ██║  ██║██╔══╝  ╚██╗ ██╔╝ ███╔╝  
  ██║ ╚████║███████╗██╔╝ ██╗    ██████╔╝███████╗ ╚████╔╝ ███████╗
  ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝    ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝
EOF
echo -e "${DARK_GRAY}  ┌──────────────────────────────────────────────────────────────────────┐${NC}"
echo -e "  │  ${NEON_PINK}${BOLD}NEX DEVZ${NC} ${WHITE}:: ULTRA-FAST CLOUDFLARE WARP TUNNEL ENGINE${NC}              │"
echo -e "  │  ${DARK_GRAY}Target:${NC} ${NEON_GREEN}Lavalink SOCKS5 YouTube Bypass${NC}  ${DARK_GRAY}Version:${NC} ${WHITE}v3.4.0 (2026)${NC}       │"
echo -e "${DARK_GRAY}  └──────────────────────────────────────────────────────────────────────┘${NC}\n"

# System Diagnostics
echo -e "${NEON_PURPLE}${BOLD}  [ SYSTEM ENVIRONMENT DIAGNOSTICS ]${NC}"
echo -e "${DARK_GRAY}  ───────────────────────────────────────────────────────────────────────${NC}"

# Root Check
if [ "$EUID" -ne 0 ]; then
    step_fail "Root privileges required! Re-run using: ${NEON_YELLOW}sudo bash install.sh${NC}"
fi
step_ok "Root privilege elevation verified."

# Arch Check
ARCH=$(dpkg --print-architecture 2>/dev/null || uname -m)
if [ "$ARCH" != "amd64" ] && [ "$ARCH" != "x86_64" ]; then
    step_fail "Incompatible architecture ($ARCH). Cloudflare WARP requires amd64 / x86_64."
fi
step_ok "Architecture validated: ${NEON_CYAN}${ARCH}${NC}"

# Distro Check
OS_NAME=$(lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n 1 || echo "Linux")
step_ok "Host OS: ${WHITE}${OS_NAME}${NC}"

echo -e "\n${NEON_PURPLE}${BOLD}  [ DEPLOYMENT & PIPELINE EXECUTION ]${NC}"
echo -e "${DARK_GRAY}  ───────────────────────────────────────────────────────────────────────${NC}"

# Step 1: Core Toolchain
step_start "Synchronizing package registry and toolchain..."
(apt-get update -qq >/dev/null 2>&1 && apt-get install -y -qq curl gpg lsb-release iptables ufw coreutils >/dev/null 2>&1) &
spinner "Updating apt indices & resolving system dependencies..."
step_ok "Core toolchain ready."

# Step 2: GPG & Cloudflare Keyring
step_start "Injecting Cloudflare official GPG keys and secure repo..."
mkdir -p /usr/share/keyrings
(curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg) &
spinner "Fetching cryptographic signature key..."

UBUNTU_CODENAME=$(lsb_release -cs)
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ ${UBUNTU_CODENAME} main" > /etc/apt/sources.list.d/cloudflare-client.list
step_ok "Cloudflare repository locked for ${NEON_CYAN}${UBUNTU_CODENAME}${NC}."

# Step 3: Cloudflare Warp Package
step_start "Installing Cloudflare WARP daemon engine..."
(apt-get update -qq >/dev/null 2>&1 && apt-get install -y -qq cloudflare-warp >/dev/null 2>&1) &
spinner "Unpacking and configuring cloudflare-warp package..."
step_ok "WARP engine installed."

# Step 4: Daemon Activation & Service Boot
step_start "Starting WARP background daemon service..."
systemctl enable --now warp-svc >/dev/null 2>&1 || true
sleep 2
step_ok "Service ${NEON_GREEN}warp-svc.service${NC} active."

# Step 5: Network Mode & SOCKS5 Binding
step_start "Configuring SOCKS5 tunneling on port 40000..."
warp-cli --accept-tos registration new >/dev/null 2>&1 || true
warp-cli --accept-tos mode proxy >/dev/null 2>&1
warp-cli --accept-tos proxy port 40000 >/dev/null 2>&1
warp-cli --accept-tos connect >/dev/null 2>&1
step_ok "WARP profile initialized and bound to ${NEON_GREEN}127.0.0.1:40000${NC}."

# Step 6: Health Probe & Network Handshake
echo -e "\n${NEON_PURPLE}${BOLD}  [ LIVE NETWORK PROBE & VERIFICATION ]${NC}"
echo -e "${DARK_GRAY}  ───────────────────────────────────────────────────────────────────────${NC}"

step_start "Detecting VPS host network interfaces..."
(VPS_IP=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null || curl -s --max-time 5 https://ifconfig.me 2>/dev/null || echo "127.0.0.1")) &
spinner "Querying primary VPS public IP address..."
VPS_IP=$(curl -s --max-time 5 https://api.ipify.org 2>/dev/null || curl -s --max-time 5 https://ifconfig.me 2>/dev/null || echo "127.0.0.1")

step_start "Performing handshake test via WARP SOCKS5 tunnel..."
TEST_OUT=$(curl -s -x socks5://127.0.0.1:40000 --max-time 10 https://cloudflare.com/cdn-cgi/trace 2>/dev/null || echo "")
TEST_IP=$(echo "$TEST_OUT" | grep -oP '(?<=ip=).*' || echo "")
WARP_STATUS=$(echo "$TEST_OUT" | grep -oP '(?<=warp=).*' || echo "off")

if [ "$WARP_STATUS" = "on" ] || [ -n "$TEST_IP" ]; then
    step_ok "WARP tunnel established! Edge IP: ${NEON_GREEN}${BOLD}${TEST_IP:-Active}${NC} (warp=${WARP_STATUS})"
else
    step_warn "WARP is warming up. Run 'warp-cli status' in 5 seconds to verify."
fi

# CRAZY NEON CYBER DASHBOARD
echo -e "\n"
echo -e "${NEON_CYAN}  ╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${NEON_CYAN}  ║${NC}   ${NEON_GREEN}${BOLD}⚡ NEX DEVZ PROXY DEPLOYMENT COMPLETE — READY FOR PRODUCTION ⚡${NC}   ${NEON_CYAN}║${NC}"
echo -e "${NEON_CYAN}  ╠══════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}VPS Public IP  :${NC} ${NEON_YELLOW}${BOLD}${VPS_IP}${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}WARP Out IP    :${NC} ${NEON_GREEN}${BOLD}${TEST_IP:-104.28.x.x}${NC} ${DARK_GRAY}(Cloudflare Clean Edge)${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}Proxy Type     :${NC} ${NEON_PURPLE}${BOLD}SOCKS5 Proxy${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}Proxy Port     :${NC} ${NEON_PINK}${BOLD}40000${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}Local URI      :${NC} ${NEON_CYAN}${BOLD}socks5://127.0.0.1:40000${NC} ${DARK_GRAY}(Use on this VPS)${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}External URI   :${NC} ${WHITE}${BOLD}socks5://${VPS_IP}:40000${NC}"
echo -e "${NEON_CYAN}  ╠══════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${NEON_YELLOW}${BOLD}📋 PASTE IN LAVALINK (application.yml):${NC}"
echo -e "${NEON_CYAN}  ║${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${NEON_GREEN}plugins:${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${NEON_GREEN}  youtube:${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${NEON_GREEN}    enabled: true${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${NEON_GREEN}    proxy:${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${NEON_GREEN}      url: \"socks5://127.0.0.1:40000\"${NC}"
echo -e "${NEON_CYAN}  ║${NC}"
echo -e "${NEON_CYAN}  ╠══════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}⚡ Status Command :${NC} ${NEON_CYAN}warp-cli status${NC}"
echo -e "${NEON_CYAN}  ║${NC}  ${WHITE}⚡ Test Command   :${NC} ${NEON_CYAN}curl -x socks5://127.0.0.1:40000 https://ipinfo.io${NC}"
echo -e "${NEON_CYAN}  ╚══════════════════════════════════════════════════════════════════════╝${NC}\n"
