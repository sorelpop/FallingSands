import Felgo 4.0
import QtQuick 2.0
import QtQuick.Dialogs
import QtQuick.Controls

GameWindow {
    id: gameWindow

    EntityManager {
        id: entityManager
        entityContainer: scene
    }

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    activeScene: scene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 640
    screenHeight: 960

    Scene {
        id: scene
        property color penColor: "darkblue"
        property int penSize: 3

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 320
        height: 480

        PhysicsWorld {
            gravity.y: 9.81
        }

        // background rectangle matching the logical scene size (= safe zone available on all devices)
        // see here for more details on content scaling and safe zone: https://felgo.com/doc/felgo-different-screen-sizes/
        Rectangle {
            id: rectangle
            anchors.fill: parent
            color: "white"

            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onPositionChanged: mouse => {
                                       drawIndicator.x = mouse.x - drawIndicator.width / 2
                                       drawIndicator.y = mouse.y - drawIndicator.height / 2

                                       if (pressed && containsMouse)
                                       {
                                           var newGrainProperties = {
                                               x: mouse.x,
                                               y: mouse.y,
                                               color: scene.penColor,
                                               grainSize: scene.penSize
                                           }

                                           entityManager.createEntityFromUrlWithProperties(
                                               Qt.resolvedUrl("Grain.qml"),
                                               newGrainProperties);
                                       }

                                   }

                onEntered: drawIndicator.visible = true
                onExited: drawIndicator.visible = false

            }
        }// Rectangle with size of logical scene

        Rectangle {
            id: drawIndicator
            width: scene.penSize
            height: scene.penSize
            radius: 180
            visible: false
            color: scene.penColor
            opacity: .5
        }

        // Floor
        Wall {
            height: 5
            anchors {
                bottom: scene.bottom
                left: scene.left
                right: scene.right
            }
        }

        // Left wall
        Wall {
            width: 5
            height: scene.height
            anchors.left: scene.left
        }

        // Right wall
        Wall {
            width: 5
            height: scene.height
            anchors.right: scene.right
        }

        Row {
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            SimpleButton {
                text: qsTr("Clear")

                font.pixelSize: 12
                color: "green"
                textColor: "white"

                onClicked: entityManager.removeEntitiesByFilter(["grain"])
            }

            SimpleButton {
                id: sandColorButton
                text: qsTr("Sand color")

                font.pixelSize: 12
                color: scene.penColor
                textColor: "white"

                onClicked: colorPicker.visible = true
            }

            SpinBox {
                id: grainSizePicker

                property bool toolTipVisible: false

                value: 3
                from: 1
                to: 5

                height: sandColorButton.height

                ToolTip.text: qsTr("Grain size")
                ToolTip.visible: toolTipVisible

                onValueModified: scene.penSize = grainSizePicker.value
                onHoveredChanged: grainSizePicker.toolTipVisible = grainSizePicker.hovered
            }
        }

        ColorDialog {
            id: colorPicker
            visible:false
            onAccepted: scene.penColor = colorPicker.selectedColor
        }
    }
}
