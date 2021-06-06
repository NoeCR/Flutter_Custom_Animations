import 'package:flutter/material.dart';

import 'src/pages/pie_charts_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: PieChartsPage());
  }
}
