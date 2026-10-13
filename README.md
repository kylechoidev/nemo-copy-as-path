# 📋 Nemo: Copy as Path

A native, lightweight context menu action for the **Nemo** file manager (Linux Mint / Cinnamon) that adds **"Copy as Path"** to the right-click menu.

Copies clean, double-quoted, Windows-style paths directly to your clipboard.

---

## ✨ Features

- **Single Item**: Right-click any file or folder → click **"Copy as Path"** to copy `"/home/user/Documents/file.txt"`.
- **Multiple Items**: Select multiple files or folders → copies each full path on a new line, cleanly quoted.
- **Empty Space Right-Click**: Right-click anywhere in the blank/empty background of an open folder → copies the current directory's path.
- **Lightweight & Battery Friendly**: Zero resident daemons. Uses GTK 3 clipboard persistence and cleanly terminates the moment another application copies to the clipboard.
- **No Root Required**: Installs entirely into user-space (`~/.local/share/nemo/actions/`).

---

## 🚀 Quick Install

### Option 1: One-Line Terminal Command (Recommended)

Open a terminal (<kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>) and paste:

```bash
curl -fsSL https://raw.githubusercontent.com/kylechoidev/nemo-copy-as-path/main/install.sh | bash
```

### Option 2: Clone & Run

```bash
git clone https://github.com/kylechoidev/nemo-copy-as-path.git
cd nemo-copy-as-path
./install.sh
```

### Option 3: Manual Installation (Without Terminal)

1. Download [`copy-as-path.nemo_action`](copy-as-path.nemo_action) and [`copy-as-path.py`](copy-as-path.py).
2. Open Nemo, press <kbd>Ctrl</kbd> + <kbd>H</kbd> to show hidden files.
3. Navigate to:
   ```
   ~/.local/share/nemo/actions/
   ```
   *(If the `actions` folder does not exist, create it).*
4. Copy both files into that folder.
5. Right-click `copy-as-path.py` → **Properties** → **Permissions** → check **"Allow executing file as program"**.
6. Restart Nemo by opening a terminal and running `nemo -q`, or simply log out and back in.

---

## 💡 How to Use

1. Open **Nemo**.
2. **Right-click** on any file, folder, or empty background space.
3. Select **"Copy as Path"** from the context menu.
4. Paste (<kbd>Ctrl</kbd> + <kbd>V</kbd>) into any text editor, terminal, browser, or message.

---

## 📦 Requirements

- **File Manager**: Nemo
- **Python**: Python 3 with PyGObject (pre-installed on Linux Mint, Ubuntu Cinnamon, and most desktop Linux distributions).
  - If PyGObject is missing, install via:
    ```bash
    sudo apt install python3-gi gir1.2-gtk-3.0
    ```

---

## 🗑️ Uninstallation

Run:

```bash
./uninstall.sh
```

Or delete the files directly:

```bash
rm -f ~/.local/share/nemo/actions/copy-as-path.nemo_action ~/.local/share/nemo/actions/copy-as-path.py
nemo -q
```

---

## 📄 License

[MIT License](LICENSE) © 2026 Kyle Choi
