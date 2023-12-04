import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AloneMode extends StatefulWidget {
  @override
  _AloneModeState createState() => _AloneModeState();
}

class _AloneModeState extends State<AloneMode> {
  int _seconds = 0;
  bool _timerActive = false;
  late Timer _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool alarmTriggered = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_seconds > 0) {
        _seconds--;
      } else {
        _timerActive = false;
        timer.cancel();
        _playSound(); // Play sound when countdown reaches 0
        _showAlertDialog();
      }
    });
  }

  void _startTimer() {
    _cancelTimer(); // Cancel existing timer before starting a new one
    setState(() {
      _seconds = 10; // 10 seconds for testing, replace with your desired time
      _timerActive = true;
      print('start timer');
    });
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  void _cancelTimer() {
    setState(() {
      _timerActive = false;
      _timer.cancel();
      _seconds = 0;
      print('timer canceled');
    });
  }

  void _playSound() {
    _audioPlayer.audioCache = AudioCache(prefix: '');
    _audioPlayer.play(AssetSource('assets/sounds/wake.mp3'));
  }

  Future<void> _showAlertDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Trigger Alarm!!!'),
            content: Text('RUNNNNNN!!!!!!!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _audioPlayer.stop();
                  Navigator.of(context).pop(); // Close the AlertDialog
                  alarmTriggered = false;
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chế độ nguy hiểm',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: _cancelTimer,
                child: Icon(
                  Icons.info_outline,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<int>(
                stream: Stream.periodic(Duration(seconds: 1), (i) => i),
                builder: (context, snapshot) {
                  final remainingSeconds = _seconds - (snapshot.data ?? 0);
                  return Text(
                    '${remainingSeconds > 0 ? remainingSeconds : 0} seconds',
                    style: TextStyle(fontSize: 24),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: !_timerActive ? _startTimer : _cancelTimer,
                child: Text(
                    _timerActive ? 'Cancel Timer' : 'Start 10-Second Timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
