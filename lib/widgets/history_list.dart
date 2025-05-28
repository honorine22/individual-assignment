import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final List<String> history;

  const HistoryList({required this.history});

  @override
  Widget build(BuildContext context) {
    return history.isEmpty
        ? Center(child: Text("No conversion history yet."))
        : ListView.builder(
          itemCount: history.length,
          itemBuilder:
              (ctx, index) => ListTile(
                leading: Icon(Icons.history),
                title: Text(history[index]),
              ),
        );
  }
}
