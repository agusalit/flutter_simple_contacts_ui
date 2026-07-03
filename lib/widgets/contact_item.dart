import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactItem({super.key, required this.contact, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(contact.name),
        subtitle: Text(contact.phone),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
