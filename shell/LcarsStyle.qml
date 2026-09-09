// PROJECT-EVE design tokens.
// Edit these to define the look; every component reads colors/fonts/sizes
// from here, so changing one value restyles the WHOLE shell.
pragma Singleton
import QtQuick

QtObject {
    // ---- palette (LCARS-inspired defaults; rework freely) ----
    //the 'variable' following 'color' such as 'orange', 'teal' can be referenced in other .qml files and 
    //they will find their corresponding colors here.
    readonly property color background:     "#000000"
    readonly property color panelDark:      "#10141C"
    readonly property color orange:         "#FFB800"
    readonly property color teal:           "#33A1C9"
    readonly property color cyan:           "#5FD4EE"
    readonly property color red:            "#CC3B3B"
    readonly property color yellow:         "#FFD84D"
    readonly property color purple:         "#C07BDB"
    readonly property color green:          "#7ED37E"
    readonly property color fg:             "#FFC865"
    readonly property color fgDim:          "#8A6E2F"
    readonly property color white:          "#FFFFFF"

    // ---- typography ----
    readonly property string fontFamily: "Antonio"
    readonly property int fontSizeSmall:   14
    readonly property int fontSizeMedium:  20
    readonly property int fontSizeLarge:   34
    readonly property int fontSizeHuge:    56

    // ---- metrics ----
    //can tweak as found neccessary
    readonly property int radius:           24
    readonly property int radiusSmall:      10
    readonly property int animDuration:     200
}
