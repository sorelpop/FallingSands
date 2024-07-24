import Felgo 4.0
import QtQuick 2.0

EntityBase {
    id: grain
    entityType: "box"

    Rectangle {
        width: 20
        height: 20
        color: "lightgreen"
    }

    BoxCollider {
        anchors.fill: grain
    }

}
