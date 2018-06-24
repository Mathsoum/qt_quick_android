import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9


ColumnLayout {
    id: column

    Tumbler {
        id: tumbler
        width: 100
        height: 180
        font.pointSize: 20
        spacing: 0
        wheelEnabled: false
        wrap: true
        Layout.alignment: Qt.AlignHCenter
//        anchors.topMargin: 20
//        anchors.horizontalCenter: parent.horizontalCenter
        visibleItemCount: 3
        currentIndex: 1
        model: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
    }

    SpacerItem {}

    StartButton {
        id: startButton
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.leftMargin: 70
        Layout.rightMargin: Layout.leftMargin
//        anchors.topMargin: 30
//        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: if (checked) {
                       startTimer()
                   } else {
                       stopTimer()
                   }
    }

    SpacerItem {}

    property bool running: _timer.running

    function startTimer() {
        time.resetCounter()
        timeTotal.resetCounter()
        _timer.restart()
    }

    function stopTimer() {
        startButton.checked = false
        _timer.stop()
    }

    function pad(num, size){ return ('00' + num).substr(-size); }

    function counterToText(_counter) {
        return pad(Math.floor(_counter / 6000), 2) + ":" + pad(Math.floor(_counter / 100), 2) + "." + pad(Math.floor(_counter % 100), 2) + ""
    }

    ColumnLayout {
        Layout.alignment: Qt.AlignHCenter

        Text {
            property int counter: 0

            id: time;
            Layout.alignment: Qt.AlignHCenter
//            anchors.topMargin: 30
//            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 45;
            color: "#CC0000"
            text: "00:00.00"

            function resetCounter() {
                counter = tumbler.model[tumbler.currentIndex] * 100
            }

            function updateText() {
                text = counterToText(counter)
            }
        }

        Text {
            property int counter: 0

            id: timeTotal;
            Layout.alignment: Qt.AlignHCenter
//            anchors.topMargin: 30
//            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 45;
            color: "#0000AA"
            text: "00:00.00"

            function resetCounter() {
                counter = 0
            }

            function updateText() {
                text = counterToText(counter)
            }
        }
    }

    Audio {
        id: beep
        volume: 0.1
        source: "qrc:///beep-09.wav"
    }

    Timer {
        id: _timer

        interval: 10; repeat: true

        onTriggered: function() {
            if (time.counter > 0) {
                time.counter--;
            } else {
                beep.play()
                time.resetCounter()
            }
            time.updateText()

            timeTotal.counter++
            timeTotal.updateText()
        };
    }
}
