// Importing necessary packages and services
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lost_item_recovery_network/constants/colors.dart';
import 'package:lost_item_recovery_network/pages/home_page.dart';
import 'package:lost_item_recovery_network/services/auth_service.dart';
import 'package:lost_item_recovery_network/utils/customColors.dart';
import 'package:lost_item_recovery_network/utils/customTextStyle.dart';

// SignUp class definition
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email, fullname, username, password;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(),
              customSizedBox(),
              emailTextField(),
              customSizedBox(),
              fullNameTextField(),
              customSizedBox(),
              usernameTextField(),
              customSizedBox(),
              passwordTextField(),
              customSizedBox(),
              signUpButton(),
              customSizedBox(),
              backToLoginPage(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for title text
  Text titleText() {
    return Text(
      "Sign Up",
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
      style: TextStyle(color: HexColor(secondaryColor)),
      decoration: customInputDecoration("Email"),
    );
  }

  // Widget for full name text field
  TextFormField fullNameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your full name";
        }
        return null;
      },
      onSaved: (value) {
        fullname = value!;
      },
      style: TextStyle(color: HexColor(secondaryColor)),
      decoration: customInputDecoration("Full Name"),
    );
  }

  // Widget for username text field
  TextFormField usernameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a username";
        }
        return null;
      },
      onSaved: (value) {
        username = value!;
      },
      style: TextStyle(color: HexColor(secondaryColor)),
      decoration: customInputDecoration("Username"),
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

  // Widget for sign up button
  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: signUp,
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: HexColor(secondaryColor)),
          child: Center(
            child: customText(
              "Sign Up",
              CustomColors.loginButtonTextColor,
            ),
          ),
        ),
      ),
    );
  }

  // Sign up method
  void signUp() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      final result = await authService.signUp(email, username, fullname, password);
      if (result == "success") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result ?? "Sign-up failed")));
      }
    }
  }

  // Widget for navigating back to login page
  Center backToLoginPage() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/loginPage"),
        child: customText(
          "Return to Login Page",
          HexColor(secondaryColor),
        ),
      ),
    );
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
