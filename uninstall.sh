#!/usr/bin/env bash
set -e

TARGET_DIR="${HOME}/.local/share/nemo/actions"

echo "=========================================="
echo " Uninstalling Nemo 'Copy as Path' Action"
echo "=========================================="
echo ""

rm -f "$TARGET_DIR/copy-as-path.nemo_action"
rm -f "$TARGET_DIR/copy-as-path.py"

if command -v nemo &>/dev/null; then
    nemo -q 2>/dev/null || true
fi

echo "✅ 'Copy as Path' action removed successfully."
