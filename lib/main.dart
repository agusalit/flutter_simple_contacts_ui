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

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF98A2B3), fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD0D5DD), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2F66E8), width: 1.5),
      ),
    );
  }

  Widget _buildContactItem(Contact contact) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contact.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            contact.phone,
            style: const TextStyle(fontSize: 15, color: Color(0xFF475467)),
          ),
        ],
      ),
    );
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
      backgroundColor: const Color(0xFFE5E5E5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 380,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2F66E8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Contact App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _nameController,
                          decoration: _buildInputDecoration(
                            'Enter contact name...',
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _buildInputDecoration(
                            'Enter phone number...',
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _addContact,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F66E8),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Add Contact',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 8),
                        const Text(
                          'Contact List',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _contacts.length,
                          itemBuilder: (context, index) =>
                              _buildContactItem(_contacts[index]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
