import 'package:chat_app/colors.dart';
import 'package:chat_app/common/loader.dart';
import 'package:chat_app/features/auth/controller/auth_controller.dart';
import 'package:chat_app/features/landing/screens/landing_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/router.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Video Share App",
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userProvider).when(
          data: (user) {
            if (user == null) {
              return const LandingScreen();
            }
            return const HomeScreen();
          },
          error: (err, stack) {
            return ErrorWidget(err);
          },
          loading: () => const Loader()),
    );
  }
}
