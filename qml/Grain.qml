import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: grain

    entityType: "grain"

    width: size
    height: size

    property int size: 3
    property color color: "gray"
    property alias friction : collider.friction
    property alias bodyType : collider.bodyType
    property alias restitution : collider.restitution

    Rectangle {
        color: grain.color
        radius: 180
        anchors.fill: collider
    }

    CircleCollider {
        id: collider

        radius: size / 2
        x: -size / 2
        y: -size / 2
    }
}
