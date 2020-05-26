import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import "component"
ApplicationWindow {
    id: appWindow
    width: 1920
    height: 1080
    title: qsTr("Qml CMake Boilerplate")

    Rectangle {
        id: main
        anchors.fill: parent
        color: "#aaa"
        Column {
            anchors.centerIn: parent
            Label {
                text: qsTr("QML CMAKE Boilerplate!")
            }

            IconButton {
                source: "android-exit"
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: Qt.quit()
            }
        }
    }
}
