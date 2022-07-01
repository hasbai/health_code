import 'package:flutter/material.dart';

import 'body.dart';
import 'header.dart';

void main() {
  runApp(
    const MaterialApp(home: MyApp()), // use MaterialApp
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:SingleChildScrollView(child: Container(
        decoration: const BoxDecoration(color: Color(0xffdfc797)),
        padding: const EdgeInsets.fromLTRB(20, 36, 20, 20),
        child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  header,
                  body,
                  bottom,
                ]))
    )))
     ;
  }
}
