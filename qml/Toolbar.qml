import Felgo 4.0
import QtQuick 2.0
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: toolbar

    anchors.top: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right

    spacing: 1

    signal clearButtonPressed
    signal grainColorButtonPressed
    signal penSizeChanged(int newPenSize)
    signal drawTypeChanged(int newIndex)

    // Clear canvas
    SimpleButton {
        text: qsTr("Clear")
        font.pixelSize: 12
        color: "green"
        textColor: "white"

        onClicked: toolbar.clearButtonPressed()
    }

    // Change grain color
    SimpleButton {
        id: grainColorButton

        text: qsTr("Sand color")
        font.pixelSize: 12
        color: scene.penColor
        textColor: "white"

        onClicked: toolbar.grainColorButtonPressed()
    }

    // Change grain size
    SpinBox {
        id: grainSizePicker

        value: 3
        from: 1
        to: 5

        Layout.preferredHeight: grainColorButton.height

        ToolTip.text: qsTr("Grain size")
        ToolTip.visible: false

        onValueModified: toolbar.penSizeChanged(grainSizePicker.value)
        onHoveredChanged: ToolTip.visible = grainSizePicker.hovered
    }

    // Change draw mode
    ComboBox {
        id: drawTypePicker

        height: grainColorButton.height

        Layout.fillWidth: true
        Layout.preferredHeight: grainColorButton.height

        onActivated: index => toolbar.drawTypeChanged(index)
    }

    property alias drawTypeModel : drawTypePicker.model
}
