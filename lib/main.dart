import 'package:flutter/material.dart';
import 'package:toma_app/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  MaterialApp build(BuildContext context) {
    return const MaterialApp(
      title: "Toma",
      home: MainScreen()
    );
  }
}
