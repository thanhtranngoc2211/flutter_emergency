import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emergency/firebase_options.dart';
import 'package:flutter_emergency/pages/welcomePage.dart';
import 'package:localstorage/localstorage.dart';
import './pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage storage = LocalStorage('your_app_storage_key');
  await storage.ready;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool isFirstLaunch = storage.getItem('first_launch') ?? true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch, storage: storage));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;
  final LocalStorage storage;

  const MyApp({Key? key, required this.isFirstLaunch, required this.storage})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isFirstLaunch
          ? WelcomePage(
              storage: storage,
            )
          : MyHomePage(storage: storage),
      debugShowCheckedModeBanner: false,
    );
  }
}
