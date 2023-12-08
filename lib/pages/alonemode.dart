import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:telephony/telephony.dart';

class AloneMode extends StatefulWidget {
  @override
  _AloneModeState createState() => _AloneModeState();

  const AloneMode({Key? key, required this.storage});

  final LocalStorage storage;
}

class _AloneModeState extends State<AloneMode> {
  int _seconds = 0;
  int _minutes = 0;
  List<String> latLong = [];
  bool _timerActive = false;
  late Timer _timer = Timer(const Duration(seconds: 0), () {});
  final Telephony telephony = Telephony.instance;

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool alarmTriggered = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<List<String>?> _getLocation() async {
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );
      Placemark place = placemarks[0];
      latLong = [
        currentPosition.latitude.toString(),
        currentPosition.longitude.toString()
      ];

      String locationName =
          "${place.name}, ${place.locality}, ${place.country}";

      print(locationName);

      List<String> locationString = [locationName, latLong[0], latLong[1]];

      return locationString;
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  void _checkPermission() async {
    await widget.storage.ready;
    var phonePermisson = await Permission.phone.status;
    var smsPermisson = await Permission.sms.status;
    var locationPermission = await Permission.location.status;
    if (phonePermisson == PermissionStatus.denied ||
        smsPermisson == PermissionStatus.denied) {
      await telephony.requestPhoneAndSmsPermissions;
    }
    if (locationPermission == PermissionStatus.denied) {
      await Permission.location.request();
    }
  }

  void _updateTimer(Timer timer) async {
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
        _sendMessage();
        _showAlertDialog();
      }
    });
  }

  void _sendMessage() async {
    List<String>? locationString = await _getLocation();
    if (locationString != null) {
      telephony.sendSms(
          to: "0822455477",
          message:
              "${locationString[0]} tại kinh độ ${locationString[1]} và vĩ độ ${locationString[2]}");
    } else
      print('No location');
  }

  void _startTimer() {
    _cancelTimer(); // Cancel existing timer before starting a new one
    setState(() {
      _seconds = 60 * 5;
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
      _minutes = 0;
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
              const SizedBox(height: 20),
              GestureDetector(
                onTap: !_timerActive ? _startTimer : _cancelTimer,
                child: InkWell(
                    child: Container(
                        height: 250,
                        width: 250,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: Center(
                            child: Text(
                          _timerActive
                              ? _formatTime(_seconds, _minutes)
                              : 'Kích hoạt',
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w500),
                        )))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
