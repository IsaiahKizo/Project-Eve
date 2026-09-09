// PROJECT-EVE label — STUB. Just styled text; style it to the design.
import QtQuick

Text {
    property color ink: LcarsStyle.fg
    property int size: LcarsStyle.fontSizeMedium
    property int spacing: 3

    color: ink
    font.family: LcarsStyle.fontFamily
    font.pixelSize: size
    font.bold: true
    font.letterSpacing: spacing
    verticalAlignment: Text.AlignVCenter
}
