import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Converter',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
