import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSquare(),
      ),
    );
  }
}

class AnimatedSquare extends StatefulWidget {
  @override
  _AnimatedSquareState createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;
  late Animation<double> opacityIn;
  late Animation<double> opacityOut;
  late Animation<double> movement;
  late Animation<double> size;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 4000,
        ));

    animation = Tween(begin: 0.0, end: 2 * Math.pi)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    opacityIn = Tween(begin: 0.1, end: 1.0)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0, 0.25, curve: Curves.easeOut)));

    opacityOut = Tween(begin: 1.0, end: 0.1)
        .animate(CurvedAnimation(parent: animationController, curve: Interval(0.75, 1.0, curve: Curves.easeOut)));

    movement =
        Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    size = Tween(begin: 0.0, end: 2.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    animationController.addListener(() {
      // Infitnite animation loop
      // if (animationController.status == AnimationStatus.completed) {
      //   animationController.reverse();
      // } else if (animationController.status == AnimationStatus.dismissed) {
      //   animationController.forward();
      // }

      if (animationController.status == AnimationStatus.completed) animationController.reset();
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // animationController.repeat(); Run the animation repeatedly
    animationController.forward();

    return AnimatedBuilder(
      animation: animationController,
      child: _Square(),
      builder: (BuildContext context, Widget? child) {
        double opacity = opacityIn.value == 1.0 ? opacityOut.value : opacityIn.value;

        return Transform.scale(
          scale: size.value,
          child: Transform.translate(
            offset: Offset(movement.value, 0),
            child: Transform.rotate(
              angle: animation.value,
              child: Opacity(
                opacity: opacity,
                child: child,
              ),
            ),
          ),
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
