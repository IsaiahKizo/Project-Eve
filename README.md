# Project-Eve
---
A Star Trek LCARS–inspired graphical shell for **Fedora Linux**, built on
**Hyprland** + **Quickshell** (QML). Every pixel of the interface — bars,
panels, buttons, status readouts, launcher, animations — is drawn by our own
QML code, so the LCARS style is the *whole* interface, not a theme on top of
a normal desktop.

---
## Getting started (Only neccessary if working on the UI or wanting to see the running version on your own machine)

**You need: Fedora 44** in VirtualBox or on a real machine. The shell targets
the 0.2.1 Quickshell that Fedora 44 ships — don't use another Fedora version
without reading the notes below. Then, from a terminal:

```bash
# 1. Clone into your home directory (the config expects this exact path):
cd ~
git clone https://github.com/IsaiahKizo/Project-Eve.git

# 2. Bundle Installer — Hyprland + Quickshell + apps + font (<~10 mins):
cd Project-Eve
bash scripts/setup-fedora.sh

# 3. Log out, and at the login screen pick the "Hyprland" session (gear icon).
```
The shell starts automatically (`exec-once` in `hypr/hyprland.conf`, which the
script installs to `~/.config/hypr/hyprland.conf`). If your repo lives
somewhere other than `~/Project-Eve`, fix the path in that file.


You should land in the LCARS shell. What you'll see depends on progress done so far.`SUPER+Return` should open a terminal.

---

# Development loop 

Quickshell **hot-reloads QML files as you save them** (`settings.watchFiles: true`
in `shell.qml`). So:

1. Edit any file in `shell/`
2. Save — the running shell reloads instantly
3. Screenshot / repeat

No compile step, no restart, no command line needed for iteration.

---

**Graphics notes:**(requires verification as of 09/08/26)
- **VirtualBox without 3D acceleration:** works out of the box — software
  rendering is pre-configured — but expect it to be slow. See
  `docs/vm-virtualbox.md` for the 3D-acceleration upgrade.
- **Physical machine with a real GPU:** comment out the two lines
  `env = LIBGL_ALWAYS_SOFTWARE` and `env = GALLIUM_DRIVER` in
  `~/.config/hypr/hyprland.conf` for full speed.

---

## Why this stack

| Piece | Job |
|---|---|
| **Hyprland** | Wayland compositor: draws windows, manages workspaces, animations. Ships with *no* bars or menus, so nothing fights our design. |
| **Quickshell** | The shell: our QML code renders the full-screen background, top bar, status bar, nav panel, launcher and (later) notifications. It talks to Hyprland over its IPC (`Quickshell.Hyprland`) and reads system data (`Quickshell.Io`, `Quickshell.Networking`, `Quickshell.Services.*`). |
| **Fedora** | The base OS. VirtualBox-friendly, and the professor gets a ready-to-import `.ova` appliance at the end. |

---

## Repo layout
(placeholder, update as changes happen)
```
Project-Eve/
├── README.md              ← you are here
├── docs/
│   ├── STYLE.md           ← LCARS design guide (colors, fonts, shapes, motion)
│   ├── PHASES.md          ← project plan: phases, roles, risks, delivery
│   └── vm-virtualbox.md   ← VirtualBox setup, autologin, .ova export
├── hypr/
│   └── hyprland.conf      ← compositor config (launches the shell)
├── scripts/
│   └── setup-fedora.sh    ← one-shot Fedora installer (COPRs + packages + font)
└── shell/                 ← the whole LCARS UI, in QML
    ├── shell.qml          ← entry point (ShellRoot)
    ├── qmldir             ← registers LcarsStyle as a singleton
    ├── LcarsStyle.qml     ← THE design tokens: colors, fonts, metrics
    ├── LcarsPanel.qml     ← rounded LCARS panel
    ├── LcarsElbow.qml     ← the classic asymmetric "elbow" shape
    ├── LcarsButton.qml    ← touch-friendly LCARS button (hover/press)
    ├── LcarsLabel.qml     ← LCARS-styled text
    ├── TopBar.qml         ← master bar: title, workspaces, clock
    ├── StatusBar.qml      ← bottom strip: CPU / MEM / uptime
    ├── NavPanel.qml       ← left navigation column
    ├── WorkspacePager.qml ← live Hyprland workspace switcher
    ├── ClockReadout.qml   ← clock + stardate
    ├── SystemReadout.qml  ← CPU / RAM / uptime from /proc
    └── Launcher.qml       ← app launcher overlay
```

---

## Credits / related work

- [Quickshell](https://quickshell.org) — the toolkit (MIT/ LGPL, see repo)
- [lcarsde](https://github.com/lcarsde/lcarsde) — an earlier full LCARS desktop environment (reference material)
- Antonio font by Santiago Orozco — [SIL OFL](https://github.com/google/fonts/tree/main/ofl/antonio), Closest LCARS font
-  LCARS is a design language from *Star Trek* (Paramount). This is a fan-made,
  educational project: "LCARS-inspired", not affiliated with or endorsed by
  Paramount.
