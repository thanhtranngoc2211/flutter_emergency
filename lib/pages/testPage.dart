import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chế độ nguy hiểm',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          // actions: [
          //   Container(
          //     margin: EdgeInsets.only(right: 5),
          //     child: GestureDetector(
          //       onTap: _cancelTimer,
          //       child: Icon(
          //         Icons.info_outline,
          //         color: Colors.red,
          //       ),
          //     ),
          //   )
          // ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Send')],
          ),
        ),
      ),
    );
  }
}
