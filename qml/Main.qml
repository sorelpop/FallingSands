import Felgo 4.0
import QtQuick 2.0

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
            color: "grey"

            Text {
                id: textElement
                // qsTr() uses the internationalization feature for multi-language support
                text: qsTr("Hello Felgo World")
                color: "#ffffff"
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent

                // when the rectangle that fits the whole scene is pressed, change the background color and the text
                onPressed: mouse => {
                               var newGrainProperties = {
                                   x: mouse.x,
                                   y: mouse.y,
                               }

                               entityManager.createEntityFromUrlWithProperties(
                                           Qt.resolvedUrl("Grain.qml"),
                                           newGrainProperties);
                               console.debug("pressed position:", mouse.x, mouse.y)
                           }

                onPositionChanged: mouse => {
                                       console.debug("mouseMoved or touchDragged position:", mouse.x, mouse.y)
                                   }

                // revert the text & color after the touch/mouse button was released
                // also States could be used for that - search for "QML States" in the doc
                onReleased: mouse => {
                                textElement.text = qsTr("Hello Felgo World")
                                rectangle.color = "grey"
                                console.debug("released position:", mouse.x, mouse.y)
                            }
            }
        }// Rectangle with size of logical scene

        Wall {
            height: 20
            anchors {
                bottom: scene.bottom
                left: scene.left
                right: scene.right
            }
        }
    }
}
