import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:toma_app/chavo_shirt_painter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int hitsCounter = 0;

  String audioRef = "audio/toma.mp3";
  late ShakeDetector detector;
  final List<String> images = [
    "01.jpg",
    "02.jpg",
    "03.jpg",
    "04.jpg",
    "05.jpg",
    "06.jpg",
    "07.jpg",
    "08.jpg",
    "09.jpg",
    "10.jpg",
    "11.jpg",
    "12.jpg",
    "13.jpg",
  ];

  int imgIndex = -1;

  @override
  void initState() {
    super.initState();
    
    AudioPlayer.global.setAudioContext(AudioContextConfig(
      focus: AudioContextConfigFocus.mixWithOthers,
    ).build());

    detector = ShakeDetector.autoStart(
      onPhoneShake: (_) {
        setState(() {
          hitsCounter = hitsCounter + 1;
        });
        _onShake();
        _playSound();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 250,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2,
    );
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  void _onShake() {
    int newIndex;
    do {
      newIndex = Random().nextInt(images.length);
    } while (newIndex == imgIndex && images.length > 1);

    setState(() {
      imgIndex = newIndex;
    });
  }

  void _playSound() async {
    final tempPlayer = AudioPlayer();
    await tempPlayer.play(AssetSource(audioRef));

    tempPlayer.onPlayerComplete.listen((_) {
      tempPlayer.dispose();
    });
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TOMA!!!", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontFamily: 'ChavoFont', fontSize: 30)),
        backgroundColor: Color.fromARGB(255, 31, 104, 55),
        centerTitle: true
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: CustomPaint(
              painter: ChavoShirtPainter(),
            ),
          ),
          
          Container(
            color: Colors.white.withAlpha(25),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFEF6C00),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ],
                      border: Border.all(color: Colors.brown, width: 3)
                    ),
                    child: ClipOval(
                      child: Container(
                        color: Color.fromARGB(255, 28, 122, 75),
                        height: 250, 
                        width: 250,
                        child: Image.asset(
                          "assets/img/${imgIndex != -1 ? images[imgIndex] : "00.jpg"}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 126, 209, 74),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withAlpha(155), width: 2)
                    ),
                    child: Text("Golpes a Ron Damon: $hitsCounter", style: TextStyle(color: Color.fromARGB(255, 11, 49, 30), fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'ChavoFont')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}