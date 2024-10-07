import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HalloweenApp()));
class HalloweenApp extends StatefulWidget {
  @override
  _HalloweenGameState createState() => _HalloweenGameState();
}
class _HalloweenGameState extends State<HalloweenApp> {
  late double _batTop, _batLeft;
  String img = "lib/img/bat.png";

  @override
  void initState() {
    super.initState();
    _initializePosition();
    Timer.periodic(Duration(seconds: 2), (timer) {
      _moveBat();
    });
  }

  void _initializePosition() {
    _batTop = 100;
    _batLeft = 50;
  }

  void _moveBat() {
    setState(() {
      Random random = Random();
      _batTop = random.nextDouble() * 400;
      _batLeft = random.nextDouble() * 300;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/halloween_background.png',
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


