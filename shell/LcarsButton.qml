// ============================================================
// PROJECT-EVE — LcarsButton
// ============================================================
// A clickable button. It exposes a small, stable "contract":
//     * a text label
//     * a color
//     * a `clicked()` signal that fires when the user presses it
// Other code uses it like:   LcarsButton { label: "FIRE"; onClicked: launch() }
//
// STUB: rework the LOOK to match your design, but keep the contract above so
// every place that already uses LcarsButton keeps working.
// ============================================================
import QtQuick

// "Item" is an INVISIBLE box: it has no picture, but it can hold children and
// define a size. We use it as the outer container to get a clean bounding box,
// then draw the actual button inside it.
Item {
    id: root              // "root" is the conventional name for a file's own instance

    // ---- Public inputs ----
    property string label: ""                         // text shown on the button
    property color color: LcarsStyle.orange           // button fill color
    property color textColor: LcarsStyle.background   // color of the label text
    property int cornerRadius: LcarsStyle.radiusSmall // corner rounding (px)
    signal clicked()      // a "signal" = an event others react to via onClicked:

    // "implicit" size = how big this wants to be when nothing forces a size.
    implicitWidth: 180    // 180 px wide by default
    implicitHeight: 48    // 48 px tall by default

    // ---- The visible button background ----
    Rectangle {
        anchors.fill: parent   // stretch this rectangle to cover the whole Item
        radius: root.cornerRadius
        // Ternary: while the mouse is held down (pressed) brighten the color,
        // otherwise use the normal color. Qt.lighter makes a color lighter.
        color: mouse.pressed ? Qt.lighter(root.color, 1.3) : root.color

        // ---- The label text, centered ----
        Text {
            anchors.centerIn: parent   // center this text within its parent Rectangle
            text: root.label
            color: root.textColor
            font.bold: true
            font.pixelSize: 18
        }
    }

    // ---- Making it clickable ----
    // MouseArea is an invisible region that detects clicks. It has no picture;
    // it just sits over the whole button and reports mouse events to us.
    MouseArea {
        id: mouse                       // named so the Rectangle above can read "mouse.pressed"
        anchors.fill: parent
        onClicked: root.clicked()       // user clicked -> fire the button's clicked() signal
    }
}
