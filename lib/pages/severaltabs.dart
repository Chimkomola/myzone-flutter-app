import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myzone/constants/colors.dart';

///Retrieving data from our database
class HomeTab extends StatefulWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  _HomeTabState createState() {
    return _HomeTabState();
  }
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          if (snapshot.hasError) {
            return const Text('Something went wrong.');
          }

          final data = snapshot.requireData;
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.size,
              itemBuilder: (context, index) {
                return CardUI(data.docs[index]['imageUrl'],
                    data.docs[index]['name'], data.docs[index]['interests']);
              });
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CardUI(String imageUrl, String name, String interests) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Image.network(
              imageUrl,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              interests,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.mail_outline)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.info_outline)),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

///Getting notifications
class NotificationTab extends StatefulWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///Searching users
class SearchTab extends StatefulWidget {
  static const routeName = '/SearchUser';
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

///Messaging
class MessageTab extends StatefulWidget {
  const MessageTab({Key? key}) : super(key: key);

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///Getting user info on our profile page
class UserInfo extends StatefulWidget {
  static const routeName = '/UserInfo';
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _uid;
  String? _name;
  String? _email;
  String? _joinedAt;
  String? _city;
  String? _interests;
  late String _userImageUrl;

  @override
  void initState() {
    _uid = " ";
    _name = " ";
    _email = " ";
    _joinedAt = " ";
    _city = " ";
    _interests = " ";
    _userImageUrl = " ";
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    User? user = _auth.currentUser;
    _uid = user!.uid;

    // ignore: avoid_print
    print('user.displayName ${user.displayName}');
    // ignore: avoid_print
    print('user.photoURL ${user.photoURL}');
    final DocumentSnapshot userDoc = (user.isAnonymous
        ? null
        : await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .get()) as DocumentSnapshot<Object?>;
    // ignore: unnecessary_null_comparison
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        _name = userDoc.get('name');
        _email = userDoc.get('email');
        _joinedAt = userDoc.get('joinedAt');
        _city = userDoc.get('city');
        _interests = userDoc.get('interests');
        _userImageUrl = userDoc.get('imageUrl');
      });
    }
    // print("name $_name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                // leading: Icon(Icons.ac_unit_outlined),
                automaticallyImplyLeading: false,
                elevation: 0,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;

                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: const [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      // collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: top <= 110.0 ? 1.0 : 0,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            Container(
                              height: kToolbarHeight / 1.8,
                              width: kToolbarHeight / 1.8,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(_userImageUrl),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              // 'top.toString()',
                              _name!,
                              style: const TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle(title: 'User Information'),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Email', _email!, 0, context),
                    userListTile('City', _city!, 1, context),
                    userListTile('Interests', _interests!, 2, context),
                    userListTile(
                        'Joined date', _joinedAt.toString(), 3, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle(title: 'User settings'),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () async {
                            // Navigator.canPop(context)? Navigator.pop(context):null;
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    title: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(right: 6.0),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Sign out'),
                                        ),
                                      ],
                                    ),
                                    content:
                                        const Text('Do you wanna Sign out?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () async {
                                            await _auth.signOut().then(
                                                (value) =>
                                                    Navigator.pop(context));
                                          },
                                          child: const Text(
                                            'Ok',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  );
                                });
                          },
                          title: const Text('Logout'),
                          leading: const Icon(Icons.exit_to_app_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          _buildFab()
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    const double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    const double scaleStart = 160.0;
    //pixels from top where scaling should end
    const double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down

        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down

        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.brown,
          heroTag: "btn1",
          onPressed: () {},
          child: const Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.location_city,
    Icons.favorite,
    Icons.watch_later,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      leading: Icon(_userTileIcons[index]),
    );
  }

  Widget userTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
