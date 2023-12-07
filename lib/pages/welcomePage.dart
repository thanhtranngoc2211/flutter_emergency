import 'package:flutter/material.dart';
import 'package:flutter_emergency/pages/homepage.dart';
import 'package:localstorage/localstorage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, required this.storage});

  final LocalStorage storage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffeff2f9),
        appBar: appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: ElevatedButton(
              child: Text('Bắt đầu'),
              onPressed: () {
                storage.setItem('first_launch', false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              storage: storage,
                            )));
              },
            ),
          ),
        ));
  }
}

AppBar appBar() {
  return AppBar(
    title: Text('Welcome Page'),
    centerTitle: true,
  );
}
