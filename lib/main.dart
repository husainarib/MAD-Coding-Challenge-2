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
  late double _batTop,
      _batLeft,
      _pkTop,
      _pkLeft,
      _ghostTop,
      _ghostLeft,
      _frTop,
      _frLeft;
  String bat = "lib/img/bat.png";
  String pk = "lib/img/pumpkin.png";
  String ghost = "lib/img/ghost.png";
  String fred = "lib/img/freddy.png";
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    _initializePosition();
    Timer.periodic(Duration(seconds: 2), (timer) {
      _moveBat();
      _movePumpkin();
      _moveGhost();
      _moveFred();
    });
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
    _pkTop = 200;
    _pkLeft = 100;
    _ghostTop = 300;
    _ghostLeft = 150;
    _frTop = 400;
    _frLeft = 200;
  }

  void _moveBat() {
    setState(() {
      Random random = Random();
      _batTop = random.nextDouble() * 700;
      _batLeft = random.nextDouble() * 1500;
    });
  }

  void _movePumpkin() {
    setState(() {
      Random random = Random();
      _pkTop = random.nextDouble() * 700;
      _pkLeft = random.nextDouble() * 1500;
    });
  }

  void _moveGhost() {
    setState(() {
      Random random = Random();
      _ghostTop = random.nextDouble() * 700;
      _ghostLeft = random.nextDouble() * 1500;
    });
  }

  void _moveFred() {
    setState(() {
      Random random = Random();
      _frTop = random.nextDouble() * 700;
      _frLeft = random.nextDouble() * 1500;
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
            child: Image.asset(bat, width: 80),
          ),
          AnimatedPositioned(
            top: _pkTop,
            left: _pkLeft,
            duration: const Duration(seconds: 2),
            child: Image.asset(pk, width: 80),
          ),
          //ghost
          AnimatedPositioned(
            top: _ghostTop,
            left: _ghostLeft,
            duration: const Duration(seconds: 2),
            child: Image.asset(ghost, width: 80),
          ),
          //freddy
          AnimatedPositioned(
            top: _frTop,
            left: _frLeft,
            duration: const Duration(seconds: 2),
            child: Image.asset(fred, width: 80),
          ),
        ],
      ),
    );
  }
}
