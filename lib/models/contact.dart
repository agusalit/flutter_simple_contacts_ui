class Contact {
  final int? id;
  final String name;
  final String phone;
  final String createdAt;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone, 'created_at': createdAt};
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      createdAt: map['created_at'],
    );
  }
}
