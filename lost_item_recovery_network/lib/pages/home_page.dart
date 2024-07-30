// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lost_item_recovery_network/constants/colors.dart';

// HomePage class definition
class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method for signing out
  Future<void> _signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      appBar: AppBar(
        backgroundColor: HexColor(secondaryColor),
        title: Text('Welcome', style: TextStyle(color: const Color.fromARGB(210, 255, 255, 255))),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Post Lost Item', style: TextStyle(color: HexColor(secondaryColor))),
              onPressed: () {
                Navigator.pushNamed(context, '/postItem');
              },
            ),
            ElevatedButton(
              child: Text('View Lost Items', style: TextStyle(color: HexColor(secondaryColor))),
              onPressed: () {
                Navigator.pushNamed(context, '/itemList');
              },
            ),
          ],
        ),
      ),
    );
  }
}
