import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryStrokeWidth;
  final double secondaryStrokeWidth;

  RadialProgress({
    required this.percentage,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.primaryStrokeWidth = 10.0,
    this.secondaryStrokeWidth = 5.0,
  });

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double oldPercentage;

  @override
  void initState() {
    oldPercentage = this.widget.percentage;
    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward(from: 0.0);
    final difference = this.widget.percentage - oldPercentage;
    oldPercentage = this.widget.percentage;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _RadialProgress(
              (this.widget.percentage - difference) + (animationController.value * difference),
              this.widget.primaryColor,
              this.widget.secondaryColor,
              this.widget.primaryStrokeWidth,
              this.widget.secondaryStrokeWidth,
            ),
          ),
        );
      },
    );
  }
}

class _RadialProgress extends CustomPainter {
  final percentage;
  final primaryColor;
  final secondaryColor;
  final primaryStrokeWidth;
  final secondaryStrokeWidth;

  _RadialProgress(
      this.percentage, this.primaryColor, this.secondaryColor, this.primaryStrokeWidth, this.secondaryStrokeWidth);

  // Full circle
  @override
  void paint(Canvas canvas, Size size) {
    final pencil = Paint()
      ..strokeWidth = secondaryStrokeWidth
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, pencil);

    final gradient = new LinearGradient(colors: [
      Color(0xFFC012FF),
      Color(0xFF6D05E8),
      primaryColor,
    ]);
    final Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: 180);

    // Bow
    final bowPencil = Paint()
      ..strokeWidth = primaryStrokeWidth
      // ..color = primaryColor
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double arcAngle = 2 * pi * (percentage / 100);
    final double startAngle = pi; // 3.14

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, arcAngle, false, bowPencil);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
