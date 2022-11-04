import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import SortFilterProxyModel 0.2
import "component"
import "../thirdparty"

Rectangle {
    id: main
    anchors.fill: parent
    color: "#aaa"

    JSONListModel {
        id: jsonListModel
        json: '[ \
                {"label": "Answer", "value": "42"}, \
                {"label": "Pastis", "value": "51"}, \
                {"label": "Alsace", "value": "67"}, \
                {"label": "Alsace", "value": "68"} \
        ]'
        query: "$[*]"
    }
    SortFilterProxyModel {
        id: sortedModel
        sorters: StringSorter {
            roleName: "value"
            sortOrder: Qt.DescendingOrder
        }
        // Note: when using JsonListModel, the sorters or filter might not be applied correctly when directly assigning sourceModel
        // use the Component.onCompleted handler instead to initialize SortFilterProxyModel
        Component.onCompleted: sourceModel = jsonListModel.model
    }

    Column {
        anchors.centerIn: parent
        Label {
            text: qsTr("Qml-cmake-boilerplate.")
        }

        IconButton {
            source: "android-exit"
            height: 60
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: Qt.quit()
        }
    }
}
