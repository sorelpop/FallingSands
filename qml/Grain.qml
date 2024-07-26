import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: grain
    entityType: "grain"

    property color color: "lightgreen"
    property int size: 3

    transformOrigin: Item.TopLeft

    width: size
    height: size

    Rectangle {
        color: grain.color
        anchors.fill: collider
        radius: 180
    }

    CircleCollider {
        id: collider

        radius: size / 2
        x: -size / 2
        y: -size / 2

        friction: 1
        restitution: 0
        density: 0.5
    }
}
