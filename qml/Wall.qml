import Felgo 4.0
import QtQuick 2.0

EntityBase {
    entityType: "wall"

    Rectangle {
        id: rectangle
        anchors.fill: collider
        color: "brown"
    }

    BoxCollider {
        id: collider

        bodyType: Body.Static

        friction: 1
        restitution: 0
    }
}
