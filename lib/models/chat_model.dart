import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String? id;
  final String name;
  final String imageUrl;
  final String? recentMessage;
  final String recentSender;
  final Timestamp recentTimestamp;
  final List<String> memberIds;
  final Map<String, dynamic> memberInfo;
  final Map<String, dynamic> readStatus;

  const Chat({
    this.id,
    required this.name,
    required this.imageUrl,
    this.recentMessage,
    required this.recentSender,
    required this.recentTimestamp,
    required this.memberIds,
    required this.memberInfo,
    required this.readStatus,
  });

  factory Chat.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      id: doc.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      recentMessage: data['recentMessage'],
      recentSender: data['recentSender'] ?? '',
      recentTimestamp: data['recentTimestamp'] ?? Timestamp.now(),
      memberIds: List<String>.from(data['memberIds'] ?? []),
      memberInfo: Map<String, dynamic>.from(data['memberInfo'] ?? {}),
      readStatus: Map<String, dynamic>.from(data['readStatus'] ?? {}),
    );
  }
}
