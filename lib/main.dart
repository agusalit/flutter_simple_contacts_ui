import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ─── ROOT ───────────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 27, 80, 205),
        ),
        useMaterial3: true,
      ),
      home: const ContactPage(),
    );
  }
}

// ─── DATA MODEL ─────────────────────────────────────────

class Contact {
  final String name;
  final String phone;
  Contact({required this.name, required this.phone});
}

// ─── PAGE ───────────────────────────────────────────────

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

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact App')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ContactFormSection(
              nameController: _nameController,
              phoneController: _phoneController,
              onAddContact: _addContact,
            ),
            const SizedBox(height: 24),
            ContactListSection(contacts: _contacts),
          ],
        ),
      ),
    );
  }
}

// ─── SMALL COMPONENTS (layer 1) ─────────────────────────

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(onPressed: onPressed, child: Text(text)),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(title: Text(contact.name), subtitle: Text(contact.phone)),
    );
  }
}

// ─── MEDIUM COMPONENTS (layer 2) ────────────────────────

class ContactFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final VoidCallback onAddContact;

  const ContactFormSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.onAddContact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(label: 'Contact Name', controller: nameController),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Phone Number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        PrimaryButton(text: 'Add Contact', onPressed: onAddContact),
      ],
    );
  }
}

class ContactListSection extends StatelessWidget {
  final List<Contact> contacts;

  const ContactListSection({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact List', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: contacts.length,
          itemBuilder: (context, index) =>
              ContactItem(contact: contacts[index]),
        ),
      ],
    );
  }
}
