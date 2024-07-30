// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lost_item_recovery_network/constants/colors.dart';
import 'chat_screen.dart';

// ItemListScreen class definition
class ItemListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      appBar: AppBar(
        title: Text('Lost Items', style: TextStyle(color: HexColor(textColor))),
        backgroundColor: HexColor(secondaryColor),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('lost_items').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var items = snapshot.data!.docs;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return Card(
                color: HexColor(secondaryColor),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(item['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    item['description'],
                    style: TextStyle(
                      color: HexColor(textColor),
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    item['timestamp'].toDate().toString(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen(itemId: item.id)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
