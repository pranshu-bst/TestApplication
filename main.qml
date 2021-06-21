import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.12
import QtQuick.Controls 1.4
import DirValidator 1.0
import DialogButtonModel 1.0
import DialogButtonModelList 1.0
import UiToolTipControl 1.0
ApplicationWindow {
    id: iAppwin
    width: 500
    height: 300
    x: Screen.width / 2 - width / 2
    y : Screen.height / 2 - height / 2
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowMinMaxButtonsHint
    color: UiTheme.colors.primary80
    visible: true
    property bool pEnable: true
    ListModel {
        id: iSidebarItems
        property var actions : {
            "Btn1": function(index) { console.log("clicked! "+ index); },
            "Btn2": function(index) { console.log("clicked! "+ index); }
        }
    }
    function reset(){
        iSidebarItems.clear()
        iSidebarItems.append({elementName: "Btn1", isEnable: pEnable,  onClick: call})
        iSidebarItems.append({elementName: "Btn2", isEnable: pEnable, onClick: call })
    }
    Component.onCompleted: {
        reset()
    }
    function call(){
        console.log("call");
    }
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border { color: UiTheme.colors.primary60; width: 1 }
        UiColumnLayout {
            anchors.fill: parent
            anchors.margins: 1
            UiRowLayout {
                id: iTopbarRow
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                spacing: 0
                color: UiTheme.colors.primary60
                Text {
                    id: iBstTxt
                    text: "Test App"
                    Layout.fillHeight: true
                    color: UiTheme.colors.primary10
                    font: UiTheme.fonts.bodyMedium
                    Layout.leftMargin: 12
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                }
                MouseArea {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    onPositionChanged: iAppwin.startSystemMove()
                }
                UiButton {
                    id:iButton
                    text: "Click"
                    pSize: UiTheme.buttons.sizes.medium
                    pColor: UiTheme.buttons.colors.accent
                    onClicked: {
                        pEnable = !pEnable
                        reset()
                    }
                }
                UiImageButton {
                    id:iCloseBtn
                    asset: "TitlebarClose"
                    pImageWidth: 32
                    pImageHeight: 32
                    Layout.alignment: Qt.AlignRight
                    UiToolTip.text: qsTranslate("QObject", "Close")
                    onClicked: iAppwin.close()
                }
            }

            Rectangle {
                id: iTestArea
                Layout.fillHeight: true
                border { color: UiTheme.colors.primary60 ; width: 1 }
                Column {
                    Repeater {
                        model: iSidebarItems
                        UiButton {
                            text: elementName
                            pSize: UiTheme.buttons.sizes.medium
                            pColor: UiTheme.buttons.colors.accent
                            enabled: isEnable
                            onClicked: iSidebarItems.actions[elementName](index);
                        }
                    }
                }
            }
        }
    }
}
