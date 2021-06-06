import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  double? percentage = 10.0;
  double currentPercentage = 0.0;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    animationController.addListener(() {
      // print('controller value ${animationController.value}');
      setState(() {
        percentage = lerpDouble(percentage, currentPercentage, animationController.value);
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.pink,
        onPressed: () {
          setState(() {
            percentage = currentPercentage;
            currentPercentage += 10;
            print('Percentage $percentage');
            print('Percentage ${percentage!}');
            print('Percentage ${percentage! > 100}');
            if (currentPercentage > 100) {
              currentPercentage = 0;
              percentage = 0;
            }

            animationController.forward(from: 0.0);
          });
        },
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 300,
          height: 300,
          // color: Colors.red,
          child: CustomPaint(
            painter: _RadialProgress(percentage),
          ),
        ),
      ),
    );
  }
}

class _RadialProgress extends CustomPainter {
  final percentage;

  _RadialProgress(this.percentage);

  // Full circle
  @override
  void paint(Canvas canvas, Size size) {
    final pencil = Paint()
      ..strokeWidth = 4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, pencil);

    // Bow
    final bowPencil = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;

    final double arcAngle = 2 * pi * (percentage / 100);
    final double startAngle = 0.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, arcAngle, false, bowPencil);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
