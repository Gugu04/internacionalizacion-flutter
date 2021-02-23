import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    
    final paintBorder = Paint()
      ..strokeWidth = 1.5
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke;

    final pathBorder = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..conicTo(size.width*0.48, size.height*0.3, 10, size.height*0.5, 5)
      ..lineTo(0, size.height);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width*0.96, size.height)
      ..conicTo(size.width*0.45, size.height*0.30, 11, size.height*0.5, 3)
      ..lineTo(size.width*0.04, size.height);

       canvas.drawPath(pathBorder, paintBorder);
       canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => false;
}