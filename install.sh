#!/usr/bin/env bash
set -e

REPO_RAW_URL="https://raw.githubusercontent.com/kylechoidev/nemo-copy-as-path/main"
TARGET_DIR="${HOME}/.local/share/nemo/actions"

echo "========================================"
echo "  Installing Nemo 'Copy as Path' Action"
echo "========================================"
echo ""

# 1. Dependency checks
if ! command -v python3 &>/dev/null; then
    echo "Error: python3 is required." >&2
    exit 1
fi

if ! python3 -c "import gi; gi.require_version('Gtk', '3.0'); from gi.repository import Gtk" &>/dev/null; then
    echo "Notice: PyGObject / GTK 3 is required for clipboard integration."
    echo "If needed on Debian/Ubuntu/Mint, install with:"
    echo "  sudo apt install python3-gi gir1.2-gtk-3.0"
    echo ""
fi

# 2. Target directory setup
mkdir -p "$TARGET_DIR"

# 3. Installation
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || true)"

if [[ -f "${SCRIPT_DIR}/copy-as-path.nemo_action" && -f "${SCRIPT_DIR}/copy-as-path.py" ]]; then
    echo "Installing from local directory..."
    cp -f "${SCRIPT_DIR}/copy-as-path.nemo_action" "$TARGET_DIR/"
    cp -f "${SCRIPT_DIR}/copy-as-path.py" "$TARGET_DIR/"
else
    echo "Downloading files from GitHub..."
    if command -v curl &>/dev/null; then
        curl -fsSL "${REPO_RAW_URL}/copy-as-path.nemo_action" -o "$TARGET_DIR/copy-as-path.nemo_action"
        curl -fsSL "${REPO_RAW_URL}/copy-as-path.py" -o "$TARGET_DIR/copy-as-path.py"
    elif command -v wget &>/dev/null; then
        wget -qO "$TARGET_DIR/copy-as-path.nemo_action" "${REPO_RAW_URL}/copy-as-path.nemo_action"
        wget -qO "$TARGET_DIR/copy-as-path.py" "${REPO_RAW_URL}/copy-as-path.py"
    else
        echo "Error: Neither curl nor wget was found." >&2
        exit 1
    fi
fi

chmod +x "$TARGET_DIR/copy-as-path.py"

# 4. Refresh Nemo
echo "Refreshing Nemo file manager..."
if command -v nemo &>/dev/null; then
    nemo -q 2>/dev/null || true
fi

echo ""
echo "✅ Installation complete!"
echo "Right-click any file, folder, or empty background in Nemo to see 'Copy as Path'."
