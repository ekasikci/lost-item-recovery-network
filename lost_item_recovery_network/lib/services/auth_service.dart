// Importing necessary packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// AuthService class definition for handling authentication
class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;

  // Method for anonymous sign-in
  Future signInAnonymous() async {
    try {
      final result = await firebaseAuth.signInAnonymously();
      print(result.user!.uid);
      return result.user;
    } catch (e) {
      print("Anon error $e");
      return null;
    }
  }

  // Method for sending password reset email
  Future<String?> forgotPassword(String email) async {
    String? res;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      print("Mail kutunuzu kontrol ediniz");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        res = "Mail Zaten Kayitli.";
      }
    }
    return res;
  }

  // Method for signing in with email and password
  Future<String?> signIn(String email, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          res = "Kullanici Bulunamadi";
          break;
        case "wrong-password":
          res = "Hatali Sifre";
          break;
        case "user-disabled":
          res = "Kullanici Pasif";
          break;
        default:
          res = "Bir Hata Ile Karsilasildi, Birazdan Tekrar Deneyiniz.";
          break;
      }
    }
    return res;
  }

  // Method for signing up with email, username, full name, and password
  Future<String?> signUp(
      String email, String username, String fullname, String password) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final userId = result.user!.uid; // Get userId

      try {
        await firebaseFirestore.collection("Users").add({
          "userId": userId, // Add userId to the document
          "email": email,
          "fullname": fullname,
          "username": username,
          "posts": [],
        });
      } catch (e) {
        print("$e");
      }
      res = "success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          res = "Email is already in use";
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          res = "Invalid Email";
          break;
        default:
          res = "An error occurred, please try again later";
          break;
      }
    }
    return res;
  }
}
