import 'package:flutter/material.dart';

class ConversionForm extends StatefulWidget {
  final void Function(String) onConvert;

  ConversionForm({required this.onConvert});

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
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter temperature'),
          ),
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
          ElevatedButton(onPressed: _handleConvert, child: Text('Convert')),
          if (_result != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('Result: $_result °', style: TextStyle(fontSize: 18)),
            ),
        ],
      ),
    );
  }
}
