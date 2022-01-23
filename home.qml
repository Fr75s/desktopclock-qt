import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    width: 640
    height: 480
    visible: true
    title: "QClock" // qsTr("QuicKalk")

    FontLoader { id: gilroyExtraBold; source: "./assets/font/Gilroy-ExtraBold.otf" }
	FontLoader { id: gilroyLight; source: "./assets/font/Gilroy-Light.otf" }
	FontLoader { id: ralewayExtraBold; source: "./assets/font/Raleway-ExtraBold.ttf"}
	FontLoader { id: ralewayLight; source: "./assets/font/Raleway-Light.ttf" }

	property string time: "00:00"
    property string day: ""
    property QtObject backend

    property bool showMenu: false
    property bool blur: true
    signal clickedClock()

    Background { }

    Connections {
        target: backend

        function onUpdatedClock(msg) {
            time = msg;
        }
        function onUpdatedDate(msg) {
            day = msg;
        }
    }

    //
    // Clock Text
    //

    Text {
        width: parent.width * .9
        height: parent.height * .1

        anchors.left: parent.left
        anchors.leftMargin: parent.width * .05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * .125

        text: time

        color: "white"
        font.family: gilroyExtraBold.name
        font.pixelSize: height
        font.bold: true

        horizontalAlignment: Text.AlignLeft // HCenter
    }

    Text {
        width: parent.width * .9
        height: parent.height * .05

        anchors.left: parent.left
        anchors.leftMargin: parent.width * .05
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * .05

        text: day

        color: "white"
        font.family: gilroyExtraBold.name
        font.pixelSize: height

        horizontalAlignment: Text.AlignLeft // HCenter
    }

    //
    // Menu
    //

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

        onClicked: (showMenu = !showMenu)
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

        anchors.right: parent.right
        anchors.top: menuButton.bottom

        anchors.margins: parent.height * 0.025

        onClicked: root.clickedClock()
    }

    RoundButton {
        id: blurChangeButton

        width: height
        height: parent.height * .1

        checkable: true
        checked: blur

        icon.name: "blur"
        icon.source: "./assets/image/blur.png"
        icon.width: height * .7
        icon.height: height * .7

        radius: height / 2

        visible: showMenu

        anchors.right: parent.right
        anchors.top: hourChangeButton.bottom

        anchors.margins: parent.height * 0.025

        onClicked: (blur = !blur)
    }
}
