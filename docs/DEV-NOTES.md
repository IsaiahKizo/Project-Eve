# DEV NOTES — how to build the shell

> Short version of the dev workflow for anyone touching the QML.
> Read this before editing your first file. ~5 minutes, then come back to it
> whenever you're unsure what a command is doing.

## The golden rule

**Editing ≠ seeing.** You can edit QML on any machine, but *live feedback* only
happens while the shell is actually running in Hyprland. So think of two
places:

- **GNOME session** = your workbench. Edit code here (comfortable + stable).
- **Hyprland session** = your stage. See the shell here and tune it live.

---

# Part 1 — The dev loop (how you actually work)

## The hot-reload loop (this is the whole trick)

Quickshell reloads QML the moment you save the file — no restart, no compile.

1. Start a Hyprland session and get the shell up (see `README.md`).
2. Open a terminal inside Hyprland: `SUPER+Return`.
3. Edit a file under `shell/`.
4. **Save** → the running shell updates instantly.

If nothing visible changes, you usually edited a value that nothing on screen
uses yet — that's normal. To see your work, add your component to `shell.qml`
first.

## Which file does what (edit in this order when starting)

| File | Role | When you touch it |
|---|---|---|
| `shell/LcarsStyle.qml` | Design tokens (colors, fonts, sizes) | **First** — define the real look here; everything reads from it |
| `shell/LcarsPanel.qml` | Your panel primitive | Second — the core shape every panel uses |
| `shell/LcarsButton.qml` | Your button | Once panels look right |
| `shell/LcarsLabel.qml` | Text helper | Whenever you place text |
| `shell/shell.qml` | Layout / what's on screen | Compose panels/bars here to see them |

Suggested first task: rework `LcarsStyle.qml` (pick the real colors/fonts),
then redesign `LcarsPanel.qml` to match — watch each save hot-reload.

## Running the shell (if it isn't already up)

```bash
pkill quickshell
quickshell -p "$HOME/Project-Eve/shell/shell.qml"
```

Run it this way **in a terminal** and QML errors print to that terminal — the
easiest way to see why something broke.

## If you break the shell (you will — it's fine)

- Hyprland keeps running even if the *shell* crashes. You only lose the UI
  widgets, never the whole session.
- `SUPER+Return` always opens a terminal (it's a Hyprland keybind, independent
  of the shell), so you can always get back in and fix files.

---

# Part 2 — QML for absolute beginners

## What QML actually is

A QML file describes a **tree of on-screen items**. You say *what* you want and
*where*, not *how* to draw it (that's the difference from normal programming —
you're describing a picture, not a recipe).

Example — our whole `LcarsPanel.qml`:

```qml
import QtQuick                                   // gives us Rectangle, Text, etc.

Rectangle {                                      // a rounded rectangle
    id: panel                                    // a name so we can refer to it

    // the "public inputs" anyone using LcarsPanel can set:
    property color fill: LcarsStyle.panelDark    // default fill color
    property color outline: LcarsStyle.orange    // default border color
    property int cornerRadius: LcarsStyle.radius // default corner size
    property bool drawBorder: true

    color: fill                                  // this Rectangle's color = our fill property
    radius: cornerRadius
    border.width: drawBorder ? 2 : 0
    border.color: outline
}
```

Key ideas:

- **`import QtQuick`** — brings in the building blocks (`Rectangle`, `Text`,
  `Column`, `Row`, `Item`, `MouseArea`…). Every file needs it.
- **Properties** — every item has them (`width`, `height`, `color`, `text`…).
  Set them with `name: value`.
- **`property … fill:`** — *declares your own* input property so other code
  can say `LcarsPanel { fill: "red" }`.
- **Bindings, the heart of QML:** `color: fill` doesn't copy the value once —
  it means "keep `color` equal to `fill`, forever." If `fill` changes, `color`
  changes automatically. This is how the UI stays alive.
- **`anchors`** — how you place things:
  - `anchors.fill: parent` — stretch to cover the parent.
  - `anchors.centerIn: parent` — center.
  - `anchors.left/right/top/bottom` + margins for edges.
- **Comments:** `//` for a line.

## Anatomy of a tiny screen (`shell.qml`)

`shell.qml` is the "stage." It puts real items on the screen:

```qml
LcarsPanel {                     // our panel type (see LcarsPanel.qml)
    anchors.centerIn: parent     // put it in the middle
    width: 520
    height: 300

    Column {                     // stack children vertically
        anchors.centerIn: parent // center the stack
        spacing: 8               // 8px gap between children

        LcarsLabel { text: "PROJECT-EVE"; size: LcarsStyle.fontSizeHuge }
        LcarsLabel { text: "LCARS-INSPIRED SHELL"; size: LcarsStyle.fontSizeSmall }
    }
}
```

Reading that out loud: "A panel, centered, 520×300. Inside it, a column of two
labels, centered." Items can be **nested** freely (panel → column → labels).

## How a `.qml` file becomes a reusable component

The moment you create `LcarsPanel.qml`, other files in the same folder can use
`LcarsPanel { }` as if it were a built-in type. Rules:

- The file name becomes the type name: `LcarsPanel.qml` → `LcarsPanel`.
- **Capitalize the first letter** of component files (`LcarsPanel.qml`, not
  `lcarsPanel.qml`).
- The `qmldir` file must list it (Qt 6 doesn't auto-discover when a `qmldir`
  exists). If you add a new component and it says `X is not a type`, you forgot
  to add `X` to `shell/qmldir`.

## Design tokens (`LcarsStyle.qml`)

`LcarsStyle` is a singleton holding the palette/fonts/metrics. Every component
reads from it instead of hard-coding colors — so to restyle the whole shell you
edit **one file**. Read `LcarsStyle.fg`, `LcarsStyle.radius`, etc.

## Making things do something (signals + MouseArea)

A button that reacts to clicks:

```qml
MouseArea {
    anchors.fill: parent          // cover the whole parent
    onClicked: { /* runs when clicked — change a property, launch an app */ }
}
```

That's why `LcarsButton.qml` declares `signal clicked()`. Anyone using the
button writes `LcarsButton { onClicked: … }`.

## Where to look things up

- Qt's own **[QML tutorial](https://doc.qt.io/qt-6/qtquick-tutorial.html)** —
  ~10 short pages, beginner friendly.
- The QtQuick type list (Rectangle, Text, anchors…).
- Don't memorize — **copy the pattern from `LcarsPanel.qml` / `shell.qml` and
  tweak numbers** until it looks right. Then look up one thing at a time.

---

# Part 3 — Git, explained so there's no guessing

## The mental model (this makes everything obvious)

Git keeps your files in **four places**. Know which one you're looking at:

```
[working directory]  --git add-->  [staging area]  --git commit-->  [your local repo]  --git push-->  [GitHub]
    files you're          files you've            a permanent save        your backup, where
    editing right now     marked "put in          point in history        teammates pull from
                          the next commit"
```

- **Working directory** — what your editor sees. Changes here are *not* saved.
- **Staging area** — files you've `git add`-ed (marked for the next commit).
- **Your local repo** — every `git commit` is a save point you can return to.
- **GitHub (remote)** — `git push` copies your local commits there so the team
  can `git pull` them. Nothing teammates see exists until you push.

**Why this matters for confidence:** a `commit` is a local, safe save point.
You can always go back to any commit. `push` just backs that up online.
**Nothing is ever destroyed by normal commands** — the worst case is easily
recoverable (see the table at the end).

## The normal daily flow (memorize this rhythm)

```bash
# 1. Start with a clean, up-to-date copy of the shared code:
git status                    # shows what state you're in (see below)
git pull                      # grab any changes teammates pushed since you last pulled

# 2. Make your edits… then see what you changed:
git status                    # which files changed/added
git diff                      # the actual line-by-line changes (unstaged)

# 3. Stage + save a checkpoint:
git add shell/LcarsPanel.qml  # "put this file in the next commit" (use the exact path)
git commit -m "Redesign panel corners"   # create a local save point with a note

# 4. Share it:
git push                      # copy your local commits to GitHub
```

Each command, in plain words:

| Command | What it actually does |
|---|---|
| `git status` | Tells you exactly where you are: files changed (red), files staged (green), whether you're ahead of/behind GitHub. **Run this whenever you're unsure.** |
| `git pull` | Downloads teammates' new commits and merges them into your files. Do this **before** you start editing and **before** you push. |
| `git add <path>` | Moves a file from "working" into "staging" — i.e. "include this in my next commit." Use the exact path: `git add shell/LcarsPanel.qml`. |
| `git add -A` | Stages **all** changed/deleted files. Handy, but read `git status` first so you know what it's grabbing. |
| `git diff` | Shows unstaged changes, line by line. Your proof of "what am I about to commit." |
| `git diff --staged` | Shows the changes you've already staged. |
| `git commit -m "message"` | Makes a **local** save point of everything staged. The `-m` message should say *what* you did ("Fix nav padding"), not be empty. |
| `git log --oneline` | Lists your recent commits (one line each). Your history / save points. |
| `git push` | Uploads your local commits to GitHub so the team can see them. |
| `git fetch` | Downloads teammates' commits **without** merging them (safer than pull if you want to inspect first). `git pull` = `fetch` + merge. |

## Reading `git status` output

```
On branch main
Your branch is up to date with 'origin/main'.     ← you match GitHub (good)

Changes not staged for commit:                    ← edited, NOT yet staged
        modified:   shell/LcarsPanel.qml

Untracked files:                                  ← brand new, never committed
        shell/MyNewThing.qml
```

The "traffic light": **untracked/modified (working) → staged → committed →
pushed.** A file is only truly "in the project" after it's committed *and*
pushed.

## When something's off (the safety table)

Run these without fear — they're the standard "undo" commands.

| Situation | What to run | What it does |
|---|---|---|
| "I edited a file and want to undo my edits back to the last commit" | `git restore shell/LcarsPanel.qml` | Reverts **one file's working copy** to the last commit. (Older tutorials write `git checkout -- <file>` — same thing.) |
| "I staged the wrong file" | `git restore --staged shell/Whatever.qml` | Un-stages it (keeps your edits; just removes it from the next commit). |
| "My commit message was bad / I want to add one more small thing to it" | `git commit --amend` | Rewrites the **last** commit. Only safe if you haven't pushed yet. |
| "Push was rejected (teammate pushed first)" | `git pull` then `git push` | Git won't let you overwrite a teammate's work. Pull theirs, then push again. |
| "A merge stopped midway with conflicts" | `git merge --abort` | Backs out of the whole merge, returning to the state before you started. Nothing lost. |
| "I deleted a file I needed" | `git restore <path>` | Restores it from the last commit. |
| "I want to see my last few commits" | `git log --oneline` | Shows your save points with short ids. |

**To resolve a real conflict** (two people edited the same lines): git leaves
markers in the file like `<<<<<<< HEAD` … `=======` … `>>>>>>>`. Edit the file to
keep the lines you want, delete the markers, then `git add <file>` and
`git commit`. If you feel out of your depth, call a teammate — conflicts are
normal and fixable.

## Golden rules for a shared repo (so nothing unexpected happens)

1. **`git status` + `git pull` before you start** and **`git pull` before every
   `git push`.** This prevents 90% of surprises.
2. **Commit small and often** with a clear `-m` message. A commit is a save
   point — more save points = safer. Don't wait until the feature is "done."
3. **Push as soon as a commit is in a reasonable state**, so teammates aren't
   blocked and nothing sits only on your machine.
4. **Never use `git push --force`** (or `-f`) on a shared branch unless you
   fully understand why — it overwrites history and can erase a teammate's
   work. If you're ever tempted, ask first.
5. **Edit mostly your own files** (each person owns their `.qml` files) — that
   keeps merge conflicts rare.
6. **When in doubt, run `git status` and paste its output** into the group chat
   rather than guessing a command.
7. **Clone once per machine**, then keep it updated with `git pull` — don't make
   copies of the folder and edit both (that causes "diverged histories").

**First time on a new machine** (laptop, new VM):

```bash
cd ~
git clone https://github.com/IsaiahKizo/Project-Eve.git   # grabs the whole repo once
cd Project-Eve
# then the normal flow above (git status / pull / edit / add / commit / push)
```

---

For anything else: ask in the group chat. Nothing here is sacred yet — this
document is meant to be fixed as you learn what trips you up.
