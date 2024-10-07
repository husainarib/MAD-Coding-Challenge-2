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
  final List<String> pictureList = ["lib/img/bat.png", "lib/img/pumpkin.png",
    "lib/img/ghost.png", "lib/img/freddy.png"];
  late AudioPlayer _audioPlayer;
  int winnerIndex = -1;
  Random random = Random();
  String textBoxString = "Playing!!";
  bool isGameActive = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
    _initializePosition();
    _getWinnerIndex();
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (!isGameActive) {
        timer.cancel();
      } else {
        _moveBat();
        _movePumpkin();
        _moveGhost();
        _moveFred();
      }
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
      _batTop = random.nextDouble() * 700;
      _batLeft = random.nextDouble() * 1500;
    });
  }

  void _movePumpkin() {
    setState(() {
      _pkTop = random.nextDouble() * 700;
      _pkLeft = random.nextDouble() * 1500;
    });
  }

  void _moveGhost() {
    setState(() {
      _ghostTop = random.nextDouble() * 700;
      _ghostLeft = random.nextDouble() * 1500;
    });
  }

  void _moveFred() {
    setState(() {
      _frTop = random.nextDouble() * 700;
      _frLeft = random.nextDouble() * 1500;
    });
  }

  void _getWinnerIndex() {
    setState(() {
      winnerIndex = random.nextInt(4);
    });
    print(winnerIndex);
  }

  void _checkIfWinnerIndex(int checkIndex) {
    setState(() {
      if (winnerIndex == checkIndex) {
        textBoxString = "Winner!!";
        _stopPicturesMovement();
      }
    });
  }

  void _stopPicturesMovement() {
    setState(() {
      isGameActive = false;
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
            child: GestureDetector(
              onTap: () => _checkIfWinnerIndex(0),
              child: Image.asset(pictureList[0], width: 80),
            )
          ),
          AnimatedPositioned(
            top: _pkTop,
            left: _pkLeft,
            duration: const Duration(seconds: 2),
            child: GestureDetector(
              onTap: () => _checkIfWinnerIndex(1),
              child: Image.asset(pictureList[1], width: 80),
            )
          ),
          //ghost
          AnimatedPositioned(
            top: _ghostTop,
            left: _ghostLeft,
            duration: const Duration(seconds: 2),
            child: GestureDetector(
              onTap: () => _checkIfWinnerIndex(2),
              child: Image.asset(pictureList[2], width: 80),
            )
          ),
          //freddy
          AnimatedPositioned(
            top: _frTop,
            left: _frLeft,
            duration: const Duration(seconds: 2),
            child: GestureDetector(
              onTap: () => _checkIfWinnerIndex(3),
              child: Image.asset(pictureList[3], width: 80),
            )
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.black54,
              child: Text(
                textBoxString,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
