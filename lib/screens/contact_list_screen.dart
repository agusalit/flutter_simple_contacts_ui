import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/contact.dart';
import '../widgets/contact_item.dart';
import '../widgets/empty_state.dart';
import 'add_contact_screen.dart';
import 'edit_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final DatabaseHelper _db = DatabaseHelper.instance;
  final TextEditingController _searchController = TextEditingController();

  List<Contact> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    setState(() => _isLoading = true);
    final contacts = await _db.getAllContacts();
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  Future<void> _searchContacts(String query) async {
    if (query.isEmpty) {
      _loadContacts();
      return;
    }
    final contacts = await _db.searchContacts(query);
    setState(() => _contacts = contacts);
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
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: _searchContacts,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _loadContacts();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Contact list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _contacts.isEmpty
                ? const EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _contacts.length,
                    itemBuilder: (context, index) {
                      final contact = _contacts[index];
                      return ContactItem(
                        contact: contact,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditContactScreen(contact: contact),
                            ),
                          );
                          _loadContacts();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddContactScreen()),
          );
          _loadContacts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
