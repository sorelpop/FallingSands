import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: grain
    entityType: "grain"

    property color color: "lightgreen"
    property int grainSize: 3

    width: grainSize
    height: grainSize

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
