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

    enum DrawType {
        FLUID,
        SOLID
    }

    Scene {
        id: scene

        property color penColor: "darkblue"
        property int penSize: 3
        property int penType: Main.DrawType.FLUID

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 420
        height: 580

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
                onPositionChanged: mouse => handleMousePositionChanged(mouse)

                function handleMousePositionChanged(mouse) {
                    updateDrawIndicator(mouse)
                    if (pressed && containsMouse) {
                        spawnGrain(mouse)
                    }
                }

                function updateDrawIndicator(mouse) {
                    drawIndicator.x = mouse.x - drawIndicator.width / 2
                    drawIndicator.y = mouse.y - drawIndicator.height / 2
                }

                function spawnGrain(mouse) {
                    var newGrainProperties = {
                        x: mouse.x,
                        y: mouse.y,
                        color: scene.penColor,
                        size: scene.penSize * 2
                    }
                    var resolvedUrl = scene.penType === Main.DrawType.FLUID ? Qt.resolvedUrl("Fluid.qml") : Qt.resolvedUrl("Solid.qml")
                    entityManager.createEntityFromUrlWithProperties(
                                resolvedUrl,
                                newGrainProperties);
                }

                onEntered: drawIndicator.visible = true
                onExited: drawIndicator.visible = false
            }

            Toolbar{
                drawTypeModel: ["Fluid", "Solid"]
                onClearButtonPressed: entityManager.removeEntitiesByFilter(["grain"])
                onGrainColorButtonPressed: colorPicker.visible = true
                onPenSizeChanged: newPenSize => scene.penSize = newPenSize
                onDrawTypeChanged: index => {
                                       switch(index) {
                                           case 0:
                                           scene.penType = Main.DrawType.FLUID
                                           break

                                           case 1:
                                           scene.penType = Main.DrawType.SOLID
                                           break
                                       }
                                   }
            }

        }// Rectangle with size of logical scene

        // Indicator at the tip of the mouse cursor
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

        // Color picker
        ColorDialog {
            id: colorPicker

            visible:false
            onAccepted: scene.penColor = colorPicker.selectedColor
        }
    }
}
