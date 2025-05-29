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

  void clearHistory() {
    if (history.isEmpty) return;

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              'Clear History',
              style: TextStyle(color: Colors.redAccent),
            ),
            content: Text('Are you sure you want to clear the entire history?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    history.clear();
                  });
                  Navigator.of(ctx).pop();
                },
                child: Text('Clear', style: TextStyle(color: Colors.redAccent)),
              ),
            ],
          ),
    );
  }

  final Color primaryColor = Colors.deepPurple;
  final Color backgroundColor = Colors.deepPurple.shade50;
  final Color cardColor = Colors.white;
  final Color accentColor = Colors.deepPurpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "Temperature Converter",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;

          return Padding(
            padding: const EdgeInsets.all(16),
            child:
                isPortrait
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: ConversionForm(
                              onConvert: addToHistory,
                              primaryColor: primaryColor,
                              accentColor: accentColor,
                              cardColor: cardColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          flex: 3,
                          child: HistoryList(
                            history: history,
                            primaryColor: primaryColor,
                            cardColor: cardColor,
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: history.isEmpty ? null : clearHistory,
                          icon: Icon(Icons.delete_forever, color: Colors.black),
                          label: Text(
                            'Clear History',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                history.isEmpty
                                    ? Colors.grey.shade400
                                    : Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                    : Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: ConversionForm(
                              onConvert: addToHistory,
                              primaryColor: primaryColor,
                              accentColor: accentColor,
                              cardColor: cardColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Flexible(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: HistoryList(
                                  history: history,
                                  primaryColor: primaryColor,
                                  cardColor: cardColor,
                                ),
                              ),
                              SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed:
                                      history.isEmpty ? null : clearHistory,
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Clear History',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        history.isEmpty
                                            ? Colors.grey.shade400
                                            : Colors.redAccent,
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          );
        },
      ),
    );
  }
}
