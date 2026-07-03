import 'package:flutter/material.dart';
import 'screens/contact_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F66E8),
          primary: const Color(0xFF2F66E8),
          onPrimary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const ContactListScreen(),
    );
  }
}
