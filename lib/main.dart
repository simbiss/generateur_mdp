import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/src/password_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Password Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _password = "";
  String _textFieldValue = "";
  bool _containsUppercase = true;
  bool _containsNumbers = true;
  bool _containsLowercase = true;
  bool _containsSymbols = true;

  void _thePasswordGenerator() {
    final _passwordGenerator = PasswordGenerator(
      length: _textFieldValue.isNotEmpty ? int.parse(_textFieldValue) : 21,
      hasCapitalLetters: _containsUppercase,
      hasNumbers: _containsNumbers,
      hasSmallLetters: _containsLowercase,
      hasSymbols: _containsSymbols,
    );
    setState(() {
      _password = _passwordGenerator.generatePassword();
    });
  }

  void _setTextFieldValue(String text) {
    setState(() {
      _textFieldValue = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration:
                  const InputDecoration(labelText: "Longueur du mot de passe"),
              keyboardType: TextInputType.number,
              onChanged: _setTextFieldValue,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            CheckboxListTile(
              title: Text('Contains Capital letters'),
              value: _containsUppercase,
              onChanged: (value) {
                setState(() {
                  _containsUppercase = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Contains Numbers'),
              value: _containsNumbers,
              onChanged: (value) {
                setState(() {
                  _containsNumbers = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Contains Lowercase letters'),
              value: _containsLowercase,
              onChanged: (value) {
                setState(() {
                  _containsLowercase = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Contains Symbols'),
              value: _containsSymbols,
              onChanged: (value) {
                setState(() {
                  _containsSymbols = value ?? false;
                });
              },
            ),
            Text(
              _password,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _thePasswordGenerator,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
