// Task: UI Implementation

// Input Section:
// - TextField -> Contact Name
// - TextField -> Phone Number
// - Button -> Add Contact

// List Section:
// - Text: "Contact List"
// - ListView/Column
// - Showing 3 data dummies

// Use: Scaffold, AppBar, Text, TextField, ElevatedButton, ListView/Column, Padding/Container/SizedBox

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ContactPage(),
    );
  }
}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: const SizedBox(), // empty for now
    );
  }
}
