import 'package:flutter/material.dart';

class AnimateSquarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSquarePage(),
      ),
    );
  }
}

class AnimatedSquarePage extends StatefulWidget {
  @override
  _AnimatedSquarePageState createState() => _AnimatedSquarePageState();
}

class _AnimatedSquarePageState extends State<AnimatedSquarePage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> movementRight;
  late Animation<double> movementTop;
  late Animation<double> movementLeft;
  late Animation<double> movementBottom;

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    // Bounce Right Movement
    movementRight = Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.0, 0.25, curve: Curves.bounceOut)));
    movementTop = Tween(begin: 0.0, end: -100.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.25, 0.5, curve: Curves.bounceOut)));
    movementLeft = Tween(begin: 0.0, end: -100.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.5, 0.75, curve: Curves.bounceOut)));
    movementBottom = Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.75, 1.0, curve: Curves.bounceOut)));

    animationController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.repeat();
    return AnimatedBuilder(
      animation: animationController,
      child: _Square(),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(movementRight.value + movementLeft.value, movementTop.value + movementBottom.value),
          child: child,
        );
      },
    );
  }
}

class _Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.blue),
    );
  }
}
