// PROJECT-EVE panel — STUB.
// Rework the drawing to match the design. Keep the public API so
// shell.qml and anything else that uses LcarsPanel keeps compiling.
import QtQuick

Rectangle {
    id: panel

    property color fill: LcarsStyle.panelDark
    property color outline: LcarsStyle.orange
    property int cornerRadius: LcarsStyle.radius
    property bool drawBorder: true

    color: fill
    radius: cornerRadius
    border.width: drawBorder ? 2 : 0
    border.color: outline
}
