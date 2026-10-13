#!/usr/bin/python3
"""Nemo action helper: "Copy as Path".

Invoked by copy-as-path.nemo_action as:
    copy-as-path.py <parent-dir> [selected-path ...]

Puts the full path(s) of the selection on the clipboard, Windows-style:
each path double-quoted, one per line. When nothing is selected (blank
area right-click) it copies the current folder's path instead.

The process stays in the background holding the clipboard (the same
trick xclip uses) so the text survives after the script would normally
be gone; it exits the moment any other application copies something.
"""

import sys
import time

QUOTED = True         # Windows-style "double quotes" around each path
SEPARATOR = "\n"      # how multiple selected paths are joined
GRACE_SECONDS = 0.75  # ignore owner-change events right after our own copy


def main():
    args = sys.argv[1:]
    # Called as: copy-as-path.py <parent-dir> [file ...]
    paths = args[1:] if len(args) > 1 else args[:1]
    if not paths:
        return 1
    text = SEPARATOR.join('"%s"' % p if QUOTED else p for p in paths)

    import gi
    gi.require_version("Gdk", "3.0")
    gi.require_version("Gtk", "3.0")
    from gi.repository import Gdk, GLib, Gtk

    clipboard = Gtk.Clipboard.get(Gdk.SELECTION_CLIPBOARD)
    clipboard.set_text(text, -1)

    started = time.monotonic()

    def on_owner_change(*_):
        # The first event is the one caused by our own set_text() above.
        if time.monotonic() - started > GRACE_SECONDS:
            Gtk.main_quit()

    clipboard.connect("owner-change", on_owner_change)
    GLib.timeout_add_seconds(6 * 3600, Gtk.main_quit)  # safety net
    Gtk.main()
    return 0


if __name__ == "__main__":
    sys.exit(main())
