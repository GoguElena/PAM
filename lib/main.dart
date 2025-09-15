import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const AngleConverterApp());
}

// Enum pentru tipul de conversie
enum ConversionType { gradeToRadian, radianToGrade }

class AngleConverterApp extends StatelessWidget {
  const AngleConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversie unghiuri',
      debugShowCheckedModeBanner: false, // scoate banner-ul DEBUG
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const AngleConverterScreen(),
    );
  }
}

class AngleConverterScreen extends StatefulWidget {
  const AngleConverterScreen({super.key});

  @override
  _AngleConverterScreenState createState() => _AngleConverterScreenState();
}

class _AngleConverterScreenState extends State<AngleConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  ConversionType _selectedConversion = ConversionType.gradeToRadian;
  String _result = "";

  void _convert() {
    final input = double.tryParse(_controller.text);
    if (input == null) {
      setState(() {
        _result = "Introduceți un număr valid! ";
      });
      return;
    }

    double converted;
    if (_selectedConversion == ConversionType.gradeToRadian) {
      converted = input * pi / 180;
    } else {
      converted = input * 180 / pi;
    }

    setState(() {
      _result = converted.toStringAsFixed(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Conversie unghiuri'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Input unghi
              TextField(
                controller: _controller,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Introduceți valoarea unghiului',
                  prefixIcon: const Icon(Icons.straighten),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Alegere tip conversie (RadioGroup modern cu ListTile)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: ConversionType.values.map((type) {
                      String label = type == ConversionType.gradeToRadian
                          ? "Grade → Radiani"
                          : "Radiani → Grade";
                      bool selected = _selectedConversion == type;
                      return ListTile(
                        leading: Radio<ConversionType>(
                          value: type,
                          groupValue: _selectedConversion,
                          onChanged: (value) {
                            setState(() {
                              _selectedConversion = value!;
                            });
                          },
                        ),
                        title: Text(label,
                            style: TextStyle(
                                fontWeight: selected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selected ? Colors.teal : Colors.black)),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Buton de conversie
              ElevatedButton.icon(
                onPressed: _convert,
                icon: const Icon(Icons.calculate),
                label: const Text("Convertește"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Rezultat afișat într-un card
              if (_result.isNotEmpty)
                Card(
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Rezultat: $_result",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
