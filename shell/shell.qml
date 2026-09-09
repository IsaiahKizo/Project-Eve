import QtQuick
import QtQuick.Layouts
import Quickshell

ShellRoot {
    id: root

    settings.watchFiles: true   // hot-reload edits as you save

    // Full-screen background layer (renders below windows)
    PanelWindow {
        anchors { left: true; right: true; top: true; bottom: true; }
        aboveWindows: false
        color: LcarsStyle.background

        Rectangle {
            anchors.fill: parent
            color: LcarsStyle.background
        }

        // --- BUILD HERE -------------------------------------------------
        // This centered panel only exists to prove the toolchain runs.
        // Replace it with your own layout as you design the shell.
        LcarsPanel {
            anchors.centerIn: parent
            width: 520
            height: 300
            fill: LcarsStyle.panelDark
            outline: LcarsStyle.orange

            Column {
                anchors.centerIn: parent
                spacing: 8
                LcarsLabel { text: "PROJECT-EVE"; size: LcarsStyle.fontSizeHuge; ink: LcarsStyle.orange }
                LcarsLabel { text: "LCARS-INSPIRED SHELL"; size: LcarsStyle.fontSizeSmall; ink: LcarsStyle.fgDim }
            }
        }
    }
}
