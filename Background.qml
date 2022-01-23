import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
    anchors.fill: parent

    Image {
        id: backImg

        source: "./assets/image/Q.jpg"
        fillMode: Image.PreserveAspectCrop

        anchors.fill: parent
    }

    ShaderEffectSource{
        id: shaderSource
        sourceItem: backImg

        anchors.fill: backImg

        sourceRect: Qt.rect(x,y, width, height)
    }

    GaussianBlur {
        anchors.fill: shaderSource
        source: shaderSource
        radius: 16
        samples: 16

        opacity: blur ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }
    }
}
