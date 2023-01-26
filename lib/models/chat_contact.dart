class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
    );
  }
}
