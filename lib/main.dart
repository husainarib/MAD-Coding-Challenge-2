import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(MaterialApp(home: HalloweenApp()));

class HalloweenApp extends StatefulWidget {
  @override
  _HalloweenGameState createState() => _HalloweenGameState();
}

class _HalloweenGameState extends State<HalloweenApp> {
  late double _batTop, _batLeft;
  String img = "lib/img/bat.png";
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _initializePosition();
    Timer.periodic(Duration(seconds: 2), (timer) {
      _moveBat();
    });
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    try {
      await _audioPlayer.setAsset('lib/audio/scary_audio.mp3');
      _audioPlayer.setLoopMode(LoopMode.one);
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void _initializePosition() {
    _batTop = 100;
    _batLeft = 50;
  }

  void _moveBat() {
    setState(() {
      Random random = Random();
      _batTop = random.nextDouble() * 600;
      _batLeft = random.nextDouble() * 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/img/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            top: _batTop,
            left: _batLeft,
            duration: const Duration(seconds: 2),
            child: Image.asset(img, width: 80),
          ),
        ],
      ),
    );
  }
}
