import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AloneMode extends StatefulWidget {
  @override
  _AloneModeState createState() => _AloneModeState();
}

class _AloneModeState extends State<AloneMode> {
  int _seconds = 0;
  int _minutes = 0;
  bool _timerActive = false;
  late Timer _timer = Timer(const Duration(seconds: 0), () {});

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool alarmTriggered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if ((_seconds % 60 == 0) && _minutes > 0) {
        _minutes--;
      }
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
      _seconds = 120;
      _minutes = (_seconds / 60).floor();
      _timerActive = true;
      print('start timer');
    });
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
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
            title: const Text('Trigger Alarm!!!'),
            content: const Text('RUNNNNNN!!!!!!!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _audioPlayer.stop();
                  _cancelTimer();
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

  String _formatTime(int seconds, int minutes) {
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chế độ nguy hiểm',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: _cancelTimer,
                child: const Icon(
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
                stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
                builder: (context, snapshot) {
                  return Text(
                    _formatTime(_seconds, _minutes),
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              const SizedBox(height: 20),
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
