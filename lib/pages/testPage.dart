import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Animate(
          effects: const [ScaleEffect()],
          child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child: const Center(child: Text("Hello World!")))
              .animate(
                  delay: 1000.ms, onPlay: (controller) => controller.repeat())
              .scale(duration: 2.seconds),
        ),
      ),
    );
  }

  String _formatTime(int seconds, int minutes) {
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
