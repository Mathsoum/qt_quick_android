import QtQuick 2.0

Item {
    id: timeText
    property int tick: 10
    property int counter: 0
    property bool running: _timer.running

    onTickChanged: function() {
        stop()
        counter = tick * 100;
        //updateText()
    }

    function start() {
        console.log("START")
        _timer.restart()
    }

    function stop() {
        console.log("STOP")
        _timer.stop()
    }

    function updateText() {
        time.text = String.valueOf(counter / 100) + "' " + String.valueOf(counter % 100) + "\""
    }

    Text {
        id: time;
        anchors.centerIn: parent
        font.pointSize: 45;
        text: "00' 00\""
    }

    Timer {
        id: _timer

        interval: 10; running: true; repeat: true

        onTriggered: function() {
            if (parent.counter > 0) {
                parent.counter--;
            } else {
                parent.stop()
            }

            //parent.updateText()
        };
    }
}
