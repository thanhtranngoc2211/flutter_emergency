import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_emergency/models/contact_model.dart';
import 'package:flutter_emergency/pages/contact.dart';
import 'package:flutter_emergency/pages/mainscreen.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> jsonDataList = [];

  void _getInitialInfo() async {
    contacts = ContactModel.getContact();
  }

  late PersistentTabController _controller;

  List<ContactModel> contacts = [];

  List<Widget> _buildScreens() {
    return [
      MainScreen(userInfo: contacts[0], db: db),
      ContactPage(contacts: contacts),
      ContactPage(contacts: contacts),
      ContactPage(contacts: contacts),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.phone),
        title: ("Contact"),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.book_circle),
        title: ("Guideline"),
        activeColorPrimary: CupertinoColors.systemRed,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  // void _getData() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> event =
  //         await db.collection("phone_numbers").get();
  //     for (QueryDocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
  //       jsonDataList.add({'id': doc.id, 'data': doc.data()});
  //     }
  //     print(jsonDataList.toString());
  //   } catch (e) {
  //     print("Error getting documents: $e");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _getInitialInfo();
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style3,
        confineInSafeArea: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
