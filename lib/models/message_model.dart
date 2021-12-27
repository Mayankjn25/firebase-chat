import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String? id;
  final String senderId;
  final String? text;
  final String? imageUrl;
  final Timestamp timestamp;

  const Message({
    this.id,
    required this.senderId,
    this.text,
    this.imageUrl,
    required this.timestamp,
  });

  factory Message.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      text: data['text'],
      imageUrl: data['imageUrl'],
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
