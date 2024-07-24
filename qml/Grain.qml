import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: grain
    entityType: "box"

    width: 20
    height: 20

    Rectangle {
        color: "lightgreen"
        anchors.fill: collider
    }

    BoxCollider {
        id: collider
        anchors.fill: parent
    }

}
