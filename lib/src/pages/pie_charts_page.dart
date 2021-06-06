import 'package:flutter/material.dart';
import 'package:flutter_animations/src/widgets/radial_progress.dart';

class PieChartsPage extends StatefulWidget {
  @override
  _PieChartsPageState createState() => _PieChartsPageState();
}

class _PieChartsPageState extends State<PieChartsPage> {
  double percentage = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              percentage += 10;

              if (percentage > 100) percentage = 0;
            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgress(
                    percentage: percentage,
                    primaryColor: Colors.blue,
                    secondaryColor: Colors.grey,
                    primaryStrokeWidth: 10.0,
                    secondaryStrokeWidth: 5.0),
                CustomRadialProgress(
                    percentage: percentage,
                    primaryColor: Colors.red,
                    secondaryColor: Colors.grey,
                    primaryStrokeWidth: 10.0,
                    secondaryStrokeWidth: 5.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgress(
                    percentage: percentage,
                    primaryColor: Colors.pink,
                    secondaryColor: Colors.grey,
                    primaryStrokeWidth: 10.0,
                    secondaryStrokeWidth: 5.0),
                CustomRadialProgress(
                    percentage: percentage,
                    primaryColor: Colors.purple,
                    secondaryColor: Colors.grey,
                    primaryStrokeWidth: 10.0,
                    secondaryStrokeWidth: 5.0),
              ],
            )
          ],
        ));
  }
}

class CustomRadialProgress extends StatelessWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryStrokeWidth;
  final double secondaryStrokeWidth;

  const CustomRadialProgress({
    required this.percentage,
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryStrokeWidth,
    required this.secondaryStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      child: RadialProgress(
          percentage: percentage,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          primaryStrokeWidth: primaryStrokeWidth,
          secondaryStrokeWidth: secondaryStrokeWidth),
    );
  }
}
