

import 'package:country_dial_code_picker/country_dial_code_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            CountryDialCodePicker.pickCountry(
              context: context,
              accentColor: Colors.redAccent,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 18,
            ).then((value) => debugPrint(value!.name));
          },
          child: const Text(
            "Pick Country",
          ),
        ),
      ),
    );
  }
}
