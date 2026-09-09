// ============================================================
// PROJECT-EVE — design tokens (the "style bible")
// ============================================================
// Edit these to define the look; every component reads colors/fonts/sizes
// from here, so changing one value restyles the WHOLE shell.
//
// "pragma Singleton" = this QtObject has ONE shared instance that every QML
// file can read as `LcarsStyle.<name>` — no import or copy needed per file,
// just reference the name.
// ============================================================
pragma Singleton
import QtQuick          // gives us the "QtObject" base type (a plain data container)

QtObject {
    // A QtObject is an invisible object that just HOLDS DATA (it has no picture).

    // Each line below declares one design token:
    //   readonly property <type> <name>: <default value>
    // - "readonly" = code can read it, but not change it at runtime
    // - colors are written as "#RRGGBB" hex (two digits each of red/green/blue)

    // ---- palette (LCARS-inspired defaults; rework freely) ----
    // The name following 'color' (e.g. orange, teal) can be referenced in other
    // .qml files as LcarsStyle.<name> — and they find their color here.
    readonly property color background:     "#000000"  // base screen color (near-black)
    readonly property color panelDark:      "#10141C"  // calm fill for large panels
    readonly property color orange:         "#FFB800"  // primary accent (buttons, active)
    readonly property color teal:           "#33A1C9"  // secondary actions
    readonly property color cyan:           "#5FD4EE"  // information accents
    readonly property color red:            "#CC3B3B"  // power / warnings / alerts
    readonly property color yellow:         "#FFD84D"  // highlights
    readonly property color purple:         "#C07BDB"  // system / utility areas
    readonly property color green:          "#7ED37E"  // "ok / connected" states
    readonly property color fg:             "#FFC865"  // main text color (warm orange)
    readonly property color fgDim:          "#8A6E2F"  // secondary / subtle text
    readonly property color white:          "#FFFFFF"

    // ---- typography ----
    readonly property string fontFamily: "Antonio"     // display font (installed by setup script)
    readonly property int fontSizeSmall:   14          // captions, secondary labels
    readonly property int fontSizeMedium:  20          // default body / button text
    readonly property int fontSizeLarge:   34          // headers
    readonly property int fontSizeHuge:    56          // big readouts / titles
    // (font sizes are in pixels)

    // ---- metrics ----
    // Tweak these as you find necessary.
    readonly property int radius:           24          // corner rounding for big panels (px)
    readonly property int radiusSmall:      10          // corner rounding for buttons (px)
    readonly property int animDuration:     200         // animation length, in milliseconds (ms)
}
