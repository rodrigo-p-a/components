import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import com.iktwo.components 1.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias buttons: buttonsContainer.data
    property alias background: backgroundContainer.data
    property alias title: labelDialogTitle.text
    property alias content: dialogContainer.data
    property color titleBarColor: Theme.titleBarColor
    property string text: ""

    function close() {
        opacity = 0
    }

    function open() {
        opacity = 1
    }

    anchors.fill: parent

    opacity: 0

    Behavior on opacity { OpacityAnimator { easing.type: Easing.InQuad; duration: 550 } }

    Item {
        id: backgroundContainer
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            visible: backgroundContainer.children.length === 1
            color: "#88000000"
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: parent.opacity
    }

    Item {
        id: dialogContainer
        anchors.centerIn: parent

        height: parent.height * 0.85
        width: parent.width * 0.85
        clip: true

        Rectangle {
            anchors.fill: parent
            color: "#fefefe"
            visible: dialogContainer.children.length === 1

            Rectangle {
                id: dialogTitleBar

                height: Math.ceil(ScreenValues.dp * (ScreenValues.isTablet ? 56 : (isScreenPortrait ? 48 : 40)))
                width: parent.width
            }

            DropShadow {
                anchors.fill: dialogTitleBar
                cached: true
                verticalOffset: 2 * ScreenValues.dp
                radius: 2 * ScreenValues.dp
                transparentBorder: true
                samples: 8 * ScreenValues.dp
                color: "#88000000"
                source: dialogTitleBar
            }

            Rectangle {
                id: dialogTitleBarFiller

                height: Math.ceil(ScreenValues.dp * (ScreenValues.isTablet ? 56 : (isScreenPortrait ? 48 : 40)))
                width: parent.width
                color: root.titleBarColor

                Label {
                    id: labelDialogTitle

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left; leftMargin: 8 * ScreenValues.dp
                        right: parent.right; rightMargin: 8 * ScreenValues.dp
                    }

                    color: "#f8fafc"
                    elide: "ElideRight"

                    font {
                        pixelSize: 14 * ScreenValues.dp
                        family: Theme.fontFamily
                    }
                }
            }

            ScrollView {
                id: scrollView

                anchors {
                    top: dialogTitleBarFiller.bottom
                    left: parent.left
                    right: parent.right
                    bottom: buttonsContainer.top
                    margins: 10 * ScreenValues.dp
                }

                flickableItem.interactive: true; focus: true
                enabled: root.opacity !== 0

                Flickable {
                    id: flickable

                    anchors {
                        fill: parent
                        margins: 2 * ScreenValues.dp
                    }

                    contentHeight: labelMessage.height
                    clip: true

                    interactive: root.opacity !== 0

                    Label {
                        id: labelMessage

                        anchors.horizontalCenter: parent.horizontalCenter
                        width: scrollView.width

                        font {
                            pixelSize: 14 * ScreenValues.dp
                            family: Theme.fontFamily
                        }

                        text: root.text
                        wrapMode: "Wrap"
                        color: Theme.mainTextColor
                        horizontalAlignment: "AlignHCenter"
                        renderType: Text.NativeRendering
                    }
                }
            }

            ColumnLayout {
                id: buttonsContainer

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom; bottomMargin: 10 * ScreenValues.dp
                }

                spacing: 5 * ScreenValues.dp
            }
        }
    }
}
