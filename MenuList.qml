import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

Item {
    id: menuList
    anchors.fill: parent

    property bool menuOpacity: (menuMouseArea.containsMouse) ? 1.0 : 0.0

    MouseArea {
        id: menuMouseArea

        height: root.height * .65
        width: root.width * .3

        anchors.top: parent.top
        anchors.right: parent.right

        z: 20
        propagateComposedEvents: true
        onClicked: {
            // console.log("clicked blue")
            mouse.accepted = false
        }
        hoverEnabled: true
    }

    RoundButton {
        id: menuButton

        width: height
        height: parent.height * .1

        checkable: true
        checked: showMenu

        text: "..."
        radius: height / 2

        anchors.right: parent.right
        anchors.top: parent.top

        anchors.margins: parent.height * 0.025

        opacity: menuOpacity
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }

        // onClicked: (showMenu = !showMenu)

        MouseArea {
            id: menuButtonArea

            anchors.fill: parent
            onClicked: (showMenu = !showMenu)
        }
    }

    RoundButton {
        id: hourChangeButton

        width: height
        height: parent.height * .1

        checkable: true

        icon.name: "clock"
        icon.source: "./assets/image/clock.png"
        icon.width: height * .8
        icon.height: height * .8

        radius: height / 2

        visible: showMenu
        opacity: menuOpacity
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }

        anchors.right: parent.right
        anchors.top: menuButton.bottom

        anchors.margins: parent.height * 0.025

        // onClicked: root.clickedClock()

        MouseArea {
            id: hcButtonArea

            anchors.fill: parent
            onClicked: {
                root.clickedClock()
                parent.checked = !parent.checked
            }
        }
    }

    RoundButton {
        id: blurChangeButton

        width: height
        height: parent.height * .1

        checkable: true
        checked: !blur

        icon.name: "blur"
        icon.source: "./assets/image/blur.png"
        icon.width: height * .7
        icon.height: height * .7

        radius: height / 2

        visible: showMenu
        opacity: menuOpacity
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }

        anchors.right: parent.right
        anchors.top: hourChangeButton.bottom

        anchors.margins: parent.height * 0.025

        // onClicked: (blur = !blur)

        MouseArea {
            id: bcButtonArea

            anchors.fill: parent
            onClicked: (blur = !blur)
        }
    }

    RoundButton {
        id: fileSetButton

        width: height
        height: parent.height * .1

        checkable: false

        icon.name: "folder"
        icon.source: "./assets/image/folder.png"
        icon.width: height * .7
        icon.height: height * .7

        radius: height / 2

        visible: showMenu
        opacity: menuOpacity
        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }

        anchors.right: parent.right
        anchors.top: blurChangeButton.bottom

        anchors.margins: parent.height * 0.025

        // onClicked: bgSelect.open()

        MouseArea {
            id: fsButtonArea

            anchors.fill: parent
            onClicked: bgSelect.open()
        }
    }

    FileDialog {
        id: bgSelect
        title: "Choose a Background Image"
        folder: "./backgrounds"
        nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]

        onAccepted: {
            console.log("You chose: " + bgSelect.fileUrl)
            background = bgSelect.fileUrl
            bgSelect.close()
        }
        onRejected: {
            console.log("Canceled")
            bgSelect.close()
        }

        // Component.onCompleted: visible = false
    }
}
