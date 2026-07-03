import 'package:flutter/material.dart';
import '../models/contact.dart';

class EditContactScreen extends StatelessWidget {
  final Contact contact;
  const EditContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Contact')),
      body: const Center(child: Text('Coming soon')),
    );
  }
}
