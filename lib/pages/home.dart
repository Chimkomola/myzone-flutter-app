import 'package:flutter/material.dart';
import 'package:myzone/main.dart';
import 'package:myzone/pages/severaltabs.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(MyApp.title),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            elevation: 20,
            titleSpacing: 0,
          ),
          body: const TabBarView(
            children: [
              HomeTab(),
              NotificationTab(),
              SearchTab(),
              MessageTab(),
              UserInfo(),
            ],
          ),
        ),
      );
}
