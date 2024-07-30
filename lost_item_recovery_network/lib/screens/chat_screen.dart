// Importing necessary packages and services
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lost_item_recovery_network/constants/colors.dart';
import 'package:lost_item_recovery_network/services/image_upload_service.dart';
import 'package:lost_item_recovery_network/services/chat_message.dart';
import 'package:intl/intl.dart';

// ChatScreen class definition
class ChatScreen extends StatefulWidget {
  final String itemId;
  ChatScreen({required this.itemId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ImageUploadService _imageUploadService = ImageUploadService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, String> _usernames = {};

  @override
  void initState() {
    super.initState();
    _loadUsernames();
  }

  // Load usernames from Firestore
  Future<void> _loadUsernames() async {
    final usersSnapshot = await _firestore.collection('Users').get();
    final usernames = {
      for (var doc in usersSnapshot.docs) doc['userId']: doc['username']
    };
    setState(() {
      _usernames = usernames.cast<String, String>();
    });
  }

  // Method for sending a message
  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      String username = _usernames[currentUserId] ?? 'Unknown User';

      _firestore
          .collection('lost_items')
          .doc(widget.itemId)
          .collection('messages')
          .add({
        'senderId': currentUserId,
        'text': _controller.text,
        'imageUrl': '',
        'timestamp': Timestamp.now(),
        'username': username,
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      appBar: AppBar(
        backgroundColor: HexColor(secondaryColor),
        title: Text('Chat', style: TextStyle(color: HexColor(textColor))),
        actions: [
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () => _imageUploadService.pickAndUploadImage(_firestore
                .collection('lost_items')
                .doc(widget.itemId)
                .collection('messages')),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('lost_items')
                  .doc(widget.itemId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final messages = snapshot.data!.docs
                    .map((doc) =>
                        ChatMessage.fromMap(doc.data() as Map<String, dynamic>))
                    .toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final username =
                        _usernames[message.senderId] ?? message.senderId;
                    return _buildMessageTile(message, username);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to build a message tile
  Widget _buildMessageTile(ChatMessage message, String username) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          message.imageUrl.isNotEmpty
              ? Image.network(message.imageUrl)
              : Text(message.text),
          SizedBox(height: 5),
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(message.timestamp.toDate()),
            style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
