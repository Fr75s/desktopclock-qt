import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

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
    property url background: "backgrounds/default.png"
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

    MenuList { }
}
