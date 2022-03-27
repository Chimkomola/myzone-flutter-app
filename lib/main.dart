import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myzone/auth/forgotscreen.dart';
import 'package:myzone/auth/login.dart';
import 'package:myzone/auth/signup.dart';
import 'package:myzone/pages/firstpage.dart';
import 'package:myzone/pages/home.dart';
import 'package:myzone/pages/severaltabs.dart';
import 'package:myzone/pages/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  static const String title = 'MyZone';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occurred'),
                ),
              ),
            );
          }
          return MaterialApp(
            title: 'MyZone',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.brown,
              primarySwatch: Colors.brown,
            ),
            home: const SplashScreen(),
            routes: {
              SplashScreen.routeName: (ctx) => const SplashScreen(),
              FirstPage.routeName: (ctx) => const FirstPage(),
              LogIn.routeName: (ctx) => const LogIn(),
              ForgetPassword.routeName: (ctx) => const ForgetPassword(),
              SignUp.routeName: (ctx) => const SignUp(),
              HomePage.routeName: (ctx) => HomePage(),
              UserInfo.routeName: (ctx) => const UserInfo(),
              SearchTab.routeName: (ctx) => const SearchTab(),
            },
          );
        });
  }
}
