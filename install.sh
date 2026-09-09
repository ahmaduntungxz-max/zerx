#!/data/data/com.termux/files/usr/bin/bash
# ============================================
#  MCHR-BL CLI Installer
#  Install with one command:
#  bash <(curl -s https://raw.githubusercontent.com/USERNAME/REPO/main/install.sh)
# ============================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}"
echo "══════════════════════════════════════════════════════════"
echo "    ZERX-UBL  •  One-Click Installer"
echo "══════════════════════════════════════════════════════════"
echo -e "${NC}"

# ── 1. Cek Termux ──
if [ -z "$TERMUX_VERSION" ] && [ ! -d "/data/data/com.termux" ]; then
    echo -e "${YELLOW}[!] Warning: sepertinya bukan Termux. Lanjut saja...${NC}"
fi

# ── 2. Update & install dependensi ──
echo -e "${CYAN}[•] Update package list...${NC}"
pkg update -y > /dev/null 2>&1 || true

echo -e "${CYAN}[•] Install python, git, curl...${NC}"
pkg install -y python git curl > /dev/null 2>&1

# ── 3. Folder install ──
INSTALL_DIR="$HOME/mchrbl-cli"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# ── 4. Download script utama ──
# GANTI URL di bawah dengan repo GitHub kamu sendiri
REPO_RAW="https://raw.githubusercontent.com/ahmaduntungxz-max/zerx/main"

echo -e "${CYAN}[•] Download herorbl.py...${NC}"
curl -sL "$REPO_RAW/herorbl.py" -o herorbl.py

# Download locales jika ada
mkdir -p locales
curl -sL "$REPO_RAW/locales/id.json" -o locales/id.json 2>/dev/null || true
curl -sL "$REPO_RAW/locales/en.json" -o locales/en.json 2>/dev/null || true

# ── 5. Buat perintah global "ubl-go" ──
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

cat > "$BIN_DIR/ubl-" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
cd "$HOME/mchrbl-cli"
python herorbl.py "$@"
EOF

chmod +x "$BIN_DIR/ubl-"
chmod +x herorbl.py

# ── 6. Tambah ke PATH ──
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Juga untuk zsh jika ada
if [ -f "$HOME/.zshrc" ]; then
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    fi
fi

export PATH="$HOME/.local/bin:$PATH"

echo ""
echo -e "${GREEN}══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  ✓  Install berhasil!${NC}"
echo -e "${GREEN}══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  Jalankan dengan perintah:"
echo -e "  ${YELLOW}ubl-go${NC}"
echo ""
echo -e "  Atau langsung:"
echo -e "  ${YELLOW}python ~/mchrbl-cli/herorbl.py${NC}"
echo ""
echo -e "  ${CYAN}Reload Termux dulu (keluar & masuk lagi)${NC}"
echo -e "  supaya perintah ${YELLOW}ubl-go${NC} langsung bisa dipakai."
echo ""
