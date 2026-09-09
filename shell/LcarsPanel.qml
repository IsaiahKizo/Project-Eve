// ============================================================
// PROJECT-EVE — LcarsPanel
// ============================================================
// A reusable "panel": the rounded rectangle that becomes the base of cards,
// windows, and chrome throughout the shell.
//
// Because the FILE is named LcarsPanel.qml, any other file can use it as a
// component, e.g.:   LcarsPanel { fill: "red" }
//
// This file is intentionally a simple STUB. Later you'll rework the drawing
// to match Project-Eve's design — but KEEP the four "property" inputs below,
// because other code sets them (for example shell.qml sets fill & outline).
// ============================================================
import QtQuick          // brings in Rectangle and the other UI building blocks

// "Rectangle" is the most basic visible QML item: a filled shape with optional
// rounded corners and an optional outline (border). We START from Rectangle
// and add our own inputs (properties) on top.
Rectangle {
    id: panel             // a name for THIS instance, so this file can refer to itself

    // ---- Public inputs (what someone using LcarsPanel can set) ----
    // syntax:  property <type> <name>: <default value>
    // The defaults pull from the design tokens (LcarsStyle), so a panel matches
    // the theme automatically unless the caller overrides a value.
    property color fill: LcarsStyle.panelDark    // the panel's fill color
    property color outline: LcarsStyle.orange    // the panel's border color
    property int cornerRadius: LcarsStyle.radius // how rounded the corners are
    property bool drawBorder: true               // true = draw the outline border

    // ---- Applying the inputs to this Rectangle ----
    // NOTE: "color: fill" is a BINDING, not a one-time copy. It means "keep
    // color equal to the fill property FOREVER." If fill ever changes, color
    // updates automatically. This is the single most important idea in QML.
    color: fill
    radius: cornerRadius
    border.width: drawBorder ? 2 : 0   // if drawBorder is true -> 2px border, else 0 (none)
    border.color: outline
    //   the "?" is a short if/else:   condition ? value-if-true : value-if-false
}
