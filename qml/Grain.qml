import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: grain
    entityType: "grain"

    property color color: "lightgreen"

    width: 3
    height: 3

    Rectangle {
        color: grain.color
        anchors.fill: collider
        radius: 180
    }

    CircleCollider {
        id: collider

        radius: width/2

        friction: 1
        restitution: 0
        density: 0.5
    }
}
