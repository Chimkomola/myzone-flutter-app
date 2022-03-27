import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:myzone/auth/login.dart';
import 'package:myzone/auth/signup.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/FirstPage';
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Welcome to MyZone',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(children: [
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.brown.shade600),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, LogIn.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Feather.user,
                        size: 18,
                      )
                    ],
                  )),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.brown.shade600),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUp.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Sign up',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Feather.user_plus,
                        size: 18,
                      )
                    ],
                  )),
            ),
          ]),
        ]),
      ]),
    );
  }
}
