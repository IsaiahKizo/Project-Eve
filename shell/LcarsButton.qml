// PROJECT-EVE button — STUB.
// The contract: `label`, `color`, a `clicked()` signal. Redesign the rest.
import QtQuick

Item {
    id: root

    property string label: ""
    property color color: LcarsStyle.orange
    property color textColor: LcarsStyle.background
    property int cornerRadius: LcarsStyle.radiusSmall
    signal clicked()

    implicitWidth: 180
    implicitHeight: 48

    Rectangle {
        anchors.fill: parent
        radius: root.cornerRadius
        color: mouse.pressed ? Qt.lighter(root.color, 1.3) : root.color

        Text {
            anchors.centerIn: parent
            text: root.label
            color: root.textColor
            font.bold: true
            font.pixelSize: 18
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
