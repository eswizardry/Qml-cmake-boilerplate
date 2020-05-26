import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtWebSockets 1.0
import Qt.labs.settings 1.0

import "../config.js" as Config

Item {
    // this is set from main.cpp
    property bool _DEBUG_MODE
    // main signal for opening module
    signal intent(string action, var extras)

    property bool _landscape: Screen.orientation === Qt.LandscapeOrientation

    function setOrientationListener(listeners) {
        if(listeners === undefined)
            listeners = Qt.LandscapeOrientation  | Qt.PortraitOrientation

        Screen.orientationUpdateMask = listeners
    }

    function unsetOrientationListener() {
        Screen.orientationUpdateMask = 0
    }

    Component.onCompleted: {
        setOrientationListener()

        if (_DEBUG_MODE)
            console.log("DEBUG MODE")

        console.log("config:", JSON.stringify(Config, null, 4))
    }

    Settings {
        id: settings
    }

    // webfont icons | they have to be loaded before rest of qml
    FontLoader { source: "/fonts/Roboto-Regular.ttf" }
    FontLoader { source: "/fonts/Roboto-Light.ttf" }
    FontLoader { source: "/fonts/ionicons.ttf" }

    // main application content
    // in debug mode fetched from http, in production, builtin version is used
    Loader {
        id: loader
        source: _DEBUG_MODE ? "%1/qml/Main.qml".arg(Config.api.url) : "qrc:/qml/Main.qml"
        anchors.fill: parent
        asynchronous: false
        onLoaded: item.visible = true

        function reload() {
            if (loader.status === Loader.Loading)
                return console.log("Ignoring reload request, reload in progress")

            console.log("application reload")

            var src = source
            source = ""
            __platform.clearCache()
            source = src

            // restart websocket debug server
            wsDebugServer.active = false
            wsDebugServer.active = true
        }
    }

    // websocket client used for development
    WebSocket {
        id: wsDebugServer
        url: Config.debug.wsurl
        active: _DEBUG_MODE
        onStatusChanged: {
            if(status === WebSocket.Error)
                console.log("WebSocker error:", errorString)
        }
        onTextMessageReceived: {
            console.log("WebSocket message:", message)
            var msg = JSON.parse(message)
            if(msg.action === "reload")
                loader.reload()
        }
    } // WebSocket

    Label {
        id: errorMessage
        color: "white"
        text: "Unable to load remote qml, check if server is available and running"
        width: 300
        wrapMode: Label.WordWrap
        anchors.centerIn: parent
        enabled: _DEBUG_MODE && loader.status === Loader.Error
        visible: enabled
    }

    Button {
        anchors.top: errorMessage.bottom
        anchors.topMargin: height
        anchors.horizontalCenter: errorMessage.horizontalCenter
        text: "Retry"
        onClicked: loader.reload()
        enabled: errorMessage.enabled
        visible: enabled
    }
} // ApplicationWindow
