import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: solid
    entityType: "solid"

    property color color: "gray"
    property int size: 3

    transformOrigin: Item.TopLeft

    width: size
    height: size

    Rectangle {
        color: solid.color
        radius: 180
        anchors.fill: collider
    }

    BoxCollider {
        id: collider

        x: -size / 2
        y: -size / 2

        bodyType: Body.Static
        friction: .4
        restitution: 0
    }
}
