import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Machinekit.Controls 1.0
import Machinekit.HalRemote.Controls 1.0
import Machinekit.HalRemote 1.0

Tab {
    id: main
    title: "Control"
    active: true

    Item {
        anchors.fill: parent

        ColumnLayout {
            anchors.margins: Screen.logicalPixelDensity*3
            anchors.fill: parent
            spacing: 0

            RowLayout {
                Layout.fillWidth: true

            GroupBox {
                Layout.fillWidth: true
                Layout.preferredHeight: main.height * 0.4
                title: qsTr("Blink Settings")

                RowLayout {
                    anchors.fill: parent
                    spacing: 5

                    RowLayout {
                    ColumnLayout {
                        Layout.fillWidth: true
                        Label {
                            Layout.fillWidth: true
                            text: qsTr("Blink Rate (in mS)")
                        }
                        HalSlider {
                            id: blinkRateSlider
                            Layout.fillWidth: true
                            name: "BlinkRate"
                            minimumValue: 100
                            maximumValue: 1500
                            value: 1000
                            tickmarksEnabled: false
                            minimumValueVisible: false
                            maximumValueVisible: false
                            valueVisible: true
                            HalPin {
                                name: "BlinkFreq"
                                type: HalPin.Float
                                direction: HalPin.Out
                                value: 1000 / blinkRateSlider.value
                            }
                        }
                        Label {
                            Layout.fillWidth: true
                            text: qsTr("Blink Duty Cycle")
                        }
                        HalSlider {
                            id: cmdPosSlider
                            Layout.fillWidth: true
                            name: "BlinkDuty"
                            minimumValue: 10
                            maximumValue: 100
                            value: 50
                            tickmarksEnabled: false
                            minimumValueVisible: false
                            maximumValueVisible: false
                            valueVisible: true
                        }
                    }
                    }
                }
            }




            GroupBox {
                Layout.fillWidth: false
                Layout.preferredHeight: main.height * 0.4
                title: qsTr("Power")

                RowLayout {
                    id: row1
                    anchors.fill: parent
                    spacing: 5

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 5

                        HalLed {
                            name: "led1"
                            Layout.preferredHeight: main.height * 0.08
                            Layout.preferredWidth: main.height * 0.08
                            blink: false
                        }
                        HalButton {
                            name: "togglebutton1"

                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: qsTr("On / Off")
                            checkable: true
                        }
                        HalButton {
                            name: "togglebutton2"

                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: qsTr("Solid")
                            checkable: true
                        }
                    }
                }
            }

            }

            GroupBox {
                Layout.fillWidth: true
                title: qsTr("Color")

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 5

                    RowLayout {
                        Layout.fillWidth: true
                        Item {
                            Layout.fillWidth: true
                        }
                        ColumnLayout {
                            Layout.fillHeight: true
                            HalSlider {
                                id: cmdMaxVelSlider
                                Layout.alignment: Layout.Center
                                Layout.fillWidth: true
                                name: "Red"
                                minimumValue: 0
                                maximumValue: 100
                                value: 100
                                tickmarksEnabled: false
                            }
                            Label {
                                Layout.fillWidth: true
                                text: qsTr("Red")
                                horizontalAlignment: Text.AlignHCenter
                            }
                            HalSlider {
                                id: cmdMaxAccSlider
                                Layout.alignment: Layout.Center
                                Layout.fillWidth: true
                                name: "Green"
                                minimumValue: 0
                                maximumValue: 100
                                value: 84.3
                                tickmarksEnabled: false
                            }
                            Label {
                                Layout.fillWidth: true
                                text: qsTr("Green")
                                horizontalAlignment: Text.AlignHCenter
                            }
                            HalSlider {
                                id: lowpassgainSlider
                                Layout.alignment: Layout.Center
                                Layout.fillWidth: true
                                name: "Blue"
                                minimumValue: 0
                                maximumValue: 100
                                value: 36.9
                                decimals: 2
                                tickmarksEnabled: false
                            }
                            Label {
                                Layout.fillWidth: true
                                text: qsTr("Blue")
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                    }
                }
            }
            }
    }
}

