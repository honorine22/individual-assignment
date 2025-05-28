import 'package:flutter/material.dart';
import '../widgets/conversion_form.dart';
import '../widgets/history_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> history = [];

  void addToHistory(String entry) {
    setState(() {
      history.insert(0, entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Temperature Converter")),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? Column(
                children: [
                  ConversionForm(onConvert: addToHistory),
                  Expanded(child: HistoryList(history: history)),
                ],
              )
              : Row(
                children: [
                  Expanded(child: ConversionForm(onConvert: addToHistory)),
                  Expanded(child: HistoryList(history: history)),
                ],
              );
        },
      ),
    );
  }
}
