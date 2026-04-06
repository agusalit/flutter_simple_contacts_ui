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

class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});
}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final List<Contact> _contacts = [
    Contact(name: 'Leon S Kennedy', phone: '+62 812-3456-7890'),
    Contact(name: 'Luffy D Monkey', phone: '+62 823-4567-8901'),
    Contact(name: 'Arthur Pendragon', phone: '+62 834-5678-9012'),
  ];

  void _addContact() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) return;

    setState(() {
      _contacts.add(Contact(name: name, phone: phone));
      _nameController.clear();
      _phoneController.clear();
    });
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                hintText: 'Enter contact name...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addContact,
                icon: const Icon(Icons.add),
                label: const Text('Add Contact'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Contact List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[800],
                        child: Text(
                          _getInitials(contact.name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        contact.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(contact.phone),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
