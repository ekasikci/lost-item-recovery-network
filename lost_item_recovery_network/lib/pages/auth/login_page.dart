// Importing necessary packages and services
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lost_item_recovery_network/constants/colors.dart';
import 'package:lost_item_recovery_network/services/auth_service.dart';
import 'package:lost_item_recovery_network/pages/home_page.dart';
import 'package:lost_item_recovery_network/utils/customColors.dart';
import 'package:lost_item_recovery_network/utils/customTextStyle.dart';
import 'package:lost_item_recovery_network/widgets/custom_text_button.dart';
import 'package:hexcolor/hexcolor.dart';

// LoginPage class definition
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  final formkey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(primaryColor),
      body: appBody(),
    );
  }

  Widget appBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              titleText(),
              customSizedBox(),
              emailTextField(),
              customSizedBox(),
              passwordTextField(),
              customSizedBox(),
              forgotPasswordButton(),
              customSizedBox(),
              signInButton(),
              customSizedBox(),
              CustomTextButton(
                onPressed: () => Navigator.pushNamed(context, "/signUp"),
                buttonText: "Sign Up",
                textColor: HexColor(secondaryColor),
              ),
              CustomTextButton(
                  onPressed: () async {
                    final result = await authService.signInAnonymous();
                    if (result != null) {
                      Navigator.pushReplacementNamed(context, "/homePage");
                    } else {
                      print("An error occurred");
                    }
                  },
                  buttonText: "Anonymously Login",
                  textColor: HexColor(secondaryColor),)
            ],
          ),
        ),
      ),
    );
  }

  // Widget for title text
  Text titleText() {
    return Text(
      "Lost Item\nRecovery Network",
      style: CustomTextStyle.titleTextStyle.copyWith(color: HexColor(secondaryColor)),
      textAlign: TextAlign.center,
    );
  }

  // Widget for email text field
  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your email";
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Enter a valid email address";
        }
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecoration("Email"),
    );
  }

  // Widget for password text field
  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your password";
        } else if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      style: TextStyle(color: HexColor(secondaryColor)),
      decoration: customInputDecoration("Password"),
    );
  }

  // Widget for forgot password button
  Center forgotPasswordButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: customText(
          "Forgot Password?",
          HexColor(secondaryColor),
        ),
      ),
    );
  }

  // Widget for sign in button
  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: signIn,
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: HexColor(secondaryColor)),
          child: Center(
            child: customText("Login", CustomColors.loginButtonTextColor),
          ),
        ),
      ),
    );
  }

  // Sign in method
  void signIn() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final result = await authService.signIn(email, password);
      if (result == "success") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(result!),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Return Back"))
                ],
              );
            });
      }
    }
  }

  // Custom sized box widget
  Widget customSizedBox() => SizedBox(
        height: 20,
      );

  // Custom text widget
  Widget customText(String text, Color color) => Text(
        text,
        style: TextStyle(color: color),
      );

  // Custom input decoration for text fields
  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
