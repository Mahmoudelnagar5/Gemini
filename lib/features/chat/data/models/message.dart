class Message {
  final String text;
  final bool isUser;
  final String? imageUrl; // Optional field for image URL

  Message({
    required this.text,
    required this.isUser,
    this.imageUrl,
  });
}
