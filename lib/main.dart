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
        colorSchemeSeed: const Color(0xFF144FDA),
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

  final _formKey = GlobalKey<FormState>();

  final List<Contact> _contacts = [
    Contact(name: 'Leon S Kennedy', phone: '+62 812-3456-7890'),
    Contact(name: 'Luffy D Monkey', phone: '+62 823-4567-8901'),
    Contact(name: 'Arthur Pendragon', phone: '+62 834-5678-9012'),
  ];

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }
    final phoneRegex = RegExp(r"^\+?[\d\s]+$");
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Phone can only contain numbers, +, and spaces';
    }
    return null;
  }

  void _addContact() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
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
      appBar: AppBar(
        title: const Text('Contact App'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ContactFormSection(
                nameController: _nameController,
                phoneController: _phoneController,
                onAddContact: _addContact,
                validateName: _validateName,
                validatePhone: _validatePhone,
              ),
              const SizedBox(height: 24),
              ContactListSection(contacts: _contacts),
            ],
          ),
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
  final String? Function(String?)? validator; // ADD

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator, // ADD
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // CHANGE from TextField
      controller: controller,
      keyboardType: keyboardType,
      validator: validator, // ADD
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
  final String? Function(String?)? validateName;
  final String? Function(String?)? validatePhone;

  const ContactFormSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.onAddContact,
    this.validateName,
    this.validatePhone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'Contact Name',
          controller: nameController,
          validator: validateName,
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: 'Phone Number',
          controller: phoneController,
          keyboardType: TextInputType.phone,
          validator: validatePhone,
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
        contacts.isEmpty
            ? const EmptyState()
            : ListView.builder(
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

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.contact_page_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            'No contacts yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Add a contact using the form above',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
