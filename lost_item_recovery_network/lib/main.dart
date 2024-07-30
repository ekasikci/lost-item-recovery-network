// Importing necessary packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lost_item_recovery_network/pages/auth/login_page.dart';
import 'package:lost_item_recovery_network/pages/auth/sign_up.dart';
import 'package:lost_item_recovery_network/pages/home_page.dart';
import 'package:lost_item_recovery_network/utils/customColors.dart';
import 'package:lost_item_recovery_network/screens/chat_screen.dart';
import 'package:lost_item_recovery_network/screens/post_item_screen.dart';
import 'package:lost_item_recovery_network/screens/item_list_screen.dart';
import 'firebase_options.dart';

// Main function to initialize the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// MyApp class definition
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        "/loginPage": (context) => LoginPage(),
        "/signUp": (context) => SignUp(),
        "/homePage": (context) => HomePage(),
        "/chat": (context) => ChatScreen(itemId: ''), // Default itemId for initial navigation setup
        "/postItem": (context) => PostItemScreen(),
        "/itemList": (context) => ItemListScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.darkColor,
        appBarTheme: AppBarTheme(color: CustomColors.pinkColor),
      ),
      home: AuthCheck(),
    );
  }
}

// AuthCheck class to determine which screen to show based on authentication state
class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
