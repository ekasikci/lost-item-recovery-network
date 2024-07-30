// Importing necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';

// ChatMessage class definition
class ChatMessage {
  String senderId;
  String text;
  String imageUrl;
  Timestamp timestamp;

  // Constructor for ChatMessage
  ChatMessage({required this.senderId, required this.text, this.imageUrl = '', required this.timestamp});

  // Convert ChatMessage to Map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }

  // Create ChatMessage from Map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'],
      text: map['text'],
      imageUrl: map['imageUrl'],
      timestamp: map['timestamp'],
    );
  }
}
