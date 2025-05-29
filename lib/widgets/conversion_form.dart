import 'package:flutter/material.dart';

class ConversionForm extends StatefulWidget {
  final void Function(String) onConvert;
  final Color? primaryColor;
  final Color? accentColor;
  final Color? cardColor;

  ConversionForm({
    required this.onConvert,
    this.primaryColor,
    this.accentColor,
    this.cardColor,
  });

  @override
  State<ConversionForm> createState() => _ConversionFormState();
}

class _ConversionFormState extends State<ConversionForm> {
  final _controller = TextEditingController();
  String _selectedConversion = 'F to C';
  String? _result;

  void _handleConvert() {
    final input = double.tryParse(_controller.text);
    if (input == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a valid number')));
      return;
    }

    double result;
    String entry;

    if (_selectedConversion == 'F to C') {
      result = (input - 32) * 5 / 9;
      entry = "F to C: $input => ${result.toStringAsFixed(2)}";
    } else {
      result = input * 9 / 5 + 32;
      entry = "C to F: $input => ${result.toStringAsFixed(2)}";
    }

    setState(() {
      _result = result.toStringAsFixed(2);
    });

    widget.onConvert(entry);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isLandscape = media.orientation == Orientation.landscape;
    final paddingHorizontal = isLandscape ? 32.0 : 16.0;

    // Wrap the form content in scrollview so it doesn't get cut off in tight spaces
    return Card(
      color: widget.cardColor ?? Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: paddingHorizontal,
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min, // allow to size based on content
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter temperature',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('F to C'),
                      value: 'F to C',
                      groupValue: _selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('C to F'),
                      value: 'C to F',
                      groupValue: _selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          _selectedConversion = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                height: isLandscape ? 60 : 45,
                child: ElevatedButton(
                  onPressed: _handleConvert,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.primaryColor ?? Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Convert',
                    style: TextStyle(
                      fontSize: isLandscape ? 20 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (_result != null) ...[
                SizedBox(height: 14),
                Text(
                  'Result: $_result °',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isLandscape ? 22 : 18,
                    fontWeight: FontWeight.w600,
                    color: widget.accentColor ?? Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
