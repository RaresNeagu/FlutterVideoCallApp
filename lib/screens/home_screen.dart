import 'package:chat_app/colors.dart';
import 'package:chat_app/common/custom_button.dart';
import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/auth/screen/otp_screen.dart';
import 'package:chat_app/features/call/screens/call_pickup_screen.dart';
import 'package:chat_app/features/landing/screens/landing_screen.dart';
import 'package:chat_app/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void signOut() {
    ref.watch(authControllerProvider).signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const LandingScreen();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: const Text('Meet & Chat'),
          centerTitle: true,
        ),
        body: <Widget>[
          const SelectContactsScreen(),
          CustomButton(
              text: 'Log Out',
              onPressed: () {
                signOut();
              }),
        ][_page],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: tabColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: onPageChanged,
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.logout_sharp,
              ),
              label: 'SignOut',
            ),
          ],
        ),
      ),
    );
  }
}
