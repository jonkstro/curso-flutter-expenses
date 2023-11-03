import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ExpenssesApp());
}

class ExpenssesApp extends StatelessWidget {
  const ExpenssesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas pessoais'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 89, 4, 104),
      ),
      body: Center(
        child: Text('Versão inicial'),
      ),
    );
  }
}
