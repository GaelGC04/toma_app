import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toma_app/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, 
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  MaterialApp build(BuildContext context) {
    return const MaterialApp(
      title: "TOMA",
      home: MainScreen()
    );
  }
}
