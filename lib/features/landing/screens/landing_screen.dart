import 'package:chat_app/colors.dart';
import 'package:chat_app/common/custom_button.dart';
import 'package:chat_app/features/auth/screen/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Welcome to VideoShare App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height / 9.0,
            ),
            Image.asset(
              "assets/facebook-messenger-logo.png",
              height: 340,
              width: 340,
              color: tabColor,
            ),
            SizedBox(
              height: size.height / 9,
            ),
            CustomButton(
                text: 'ENTER',
                onPressed: () => {navigateToLoginScreen(context)})
          ],
        ),
      ),
    );
  }
}
