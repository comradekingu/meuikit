import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Window 2.12
import MeuiKit 1.0 as Meui
import QtGraphicalEffects 1.0

T.Menu
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    margins: 0
    verticalPadding: 8
    spacing: Meui.Units.smallSpacing
    transformOrigin: !cascade ? Item.Top : (mirrored ? Item.TopRight : Item.TopLeft)
    modal: true

    delegate: MenuItem { }

    enter: Transition {
        // grow_fade_in
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        // shrink_fade_out
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    Overlay.modal: Item {
        Rectangle {
            anchors.fill: parent
            color: 'transparent'
        }
    }

    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: Window.window ? contentHeight > Window.window.height : false
        clip: true
        currentIndex: control.currentIndex
        spacing: control.spacing
        ScrollIndicator.vertical: ScrollIndicator {}
    }

    background: Rectangle {
        radius: 10
        implicitWidth: 200
        implicitHeight: Meui.Units.rowHeight
        color: control.Meui.Theme.backgroundColor
        border.color: Qt.tint(Meui.Theme.textColor, Qt.rgba(Meui.Theme.backgroundColor.r,
                                                            Meui.Theme.backgroundColor.g,
                                                            Meui.Theme.backgroundColor.b, 0.7))
        layer.enabled: true

        layer.effect: DropShadow {
            transparentBorder: true
            radius: 32
            samples: 32
            horizontalOffset: 0
            verticalOffset: 0
            color: Qt.rgba(0, 0, 0, 0.11)
        }
    }

    T.Overlay.modal: Rectangle  {
        color: Qt.rgba( control.Meui.Theme.backgroundColor.r,
                        control.Meui.Theme.backgroundColor.g,
                        control.Meui.Theme.backgroundColor.b, 0.4)
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

    T.Overlay.modeless: Rectangle {
        color: Qt.rgba( control.Meui.Theme.backgroundColor.r,
                        control.Meui.Theme.backgroundColor.g,
                        control.Meui.Theme.backgroundColor.b, 0.4)
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }

}
