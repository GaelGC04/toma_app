import 'package:flutter/material.dart';

class ChavoShirtPainter extends CustomPainter {
  final Color colorChavoCafe = Color(0xFF8D6E63); 
  final Color colorChavoBlanco = Color(0xFFFBE9E7); 

  @override
  void paint(Canvas canvas, Size size) {
    const double stripeHeight = 30.0; 

    final paintCafe = Paint()..color = colorChavoCafe;
    final paintBlanco = Paint()..color = colorChavoBlanco;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintBlanco);

    for (double y = 0; y < size.height; y += stripeHeight * 2) {
      canvas.drawRect(
        Rect.fromLTWH(0, y, size.width, stripeHeight), 
        paintCafe
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; 
  }
}