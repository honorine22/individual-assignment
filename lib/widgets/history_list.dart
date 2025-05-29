// history_list.dart
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final List<String> history;
  final Color primaryColor;
  final Color cardColor;

  const HistoryList({
    required this.history,
    required this.primaryColor,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child:
            history.isEmpty
                ? Center(
                  child: Text(
                    "No conversion history yet.",
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount: history.length,
                  itemBuilder:
                      (ctx, index) => ListTile(
                        leading: Icon(Icons.history, color: primaryColor),
                        title: Text(
                          history[index],
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                ),
      ),
    );
  }
}
