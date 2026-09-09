// ============================================================
// PROJECT-EVE — shell.qml (the ENTRY POINT)
// ============================================================
// This is the file Quickshell loads to start the whole shell:
//     quickshell -p "$HOME/Project-Eve/shell/shell.qml"
//
// "ShellRoot" tells Quickshell "this is a desktop shell." Everything you see —
// the background, bars, panels — is a child item inside it. Read the structure
// top-to-bottom: the pieces here are built from the smaller components
// (LcarsPanel, LcarsLabel) defined in this same folder.
// ============================================================

import QtQuick            // base UI items: Rectangle, Text, Column, Item...
import QtQuick.Layouts    // layout helpers (rows/columns that auto-arrange)
import Quickshell         // the toolkit: ShellRoot, PanelWindow, etc.

ShellRoot {
    id: root

    // Watch our QML files and RELOAD them whenever you save — this is the
    // "edit a file, watch it update live" behavior.
    settings.watchFiles: true

    // ----------------------------------------------------------------
    // The full-screen background
    // ----------------------------------------------------------------
    // A "PanelWindow" is a Quickshell window that can stick to screen edges.
    // Anchoring it to ALL four edges makes it cover the whole screen.
    // "aboveWindows: false" renders it BENEATH normal windows — like a
    // wallpaper — so regular apps (browser, terminal) open on top of it.
    PanelWindow {
        anchors { left: true; right: true; top: true; bottom: true; }
        aboveWindows: false
        color: LcarsStyle.background   // dark base so nothing shows behind it

        // A plain rectangle filling this panel — guarantees the entire screen
        // is painted our background color (belt and suspenders).
        Rectangle {
            anchors.fill: parent
            color: LcarsStyle.background
        }

        // --- BUILD HERE --------------------------------------------------
        // The centered panel below is only a placeholder proving the shell
        // runs. This is where YOU build the real layout (bars, workspaces...).
        LcarsPanel {                       // our own component (see LcarsPanel.qml)
            anchors.centerIn: parent       // place it in the middle of the background
            width: 520
            height: 300
            fill: LcarsStyle.panelDark     // pass a value into LcarsPanel's "fill" input
            outline: LcarsStyle.orange     // ...and its "outline" input

            // "Column" stacks its children vertically (one above the other).
            Column {
                anchors.centerIn: parent   // center the whole column
                spacing: 8                 // 8px gap between the two labels below

                // Two labels made from our LcarsLabel component. Notice each
                // sets a different text, size, and ink (color).
                LcarsLabel { text: "PROJECT-EVE";          size: LcarsStyle.fontSizeHuge;  ink: LcarsStyle.orange }
                LcarsLabel { text: "LCARS-INSPIRED SHELL"; size: LcarsStyle.fontSizeSmall; ink: LcarsStyle.fgDim }
            }
        }
    }
}
