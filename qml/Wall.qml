import Felgo 4.0
import QtQuick 2.0

EntityBase {
    entityType: "wall"

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: "brown"
    }

    BoxCollider {
        id: collider
        anchors.fill: parent
        bodyType: Body.Static
    }
}
