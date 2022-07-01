import 'package:flutter/material.dart';

Widget header = SizedBox(
    height: 48,
    child: Stack(alignment: Alignment.bottomCenter, children: [
      Positioned(
        left: 0,
        bottom: 0,
        child: Image.asset('assets/back.png', scale: 1.5)),
      const Positioned(
        bottom: 0,
        child: Text(
          '随申码',
          style: TextStyle(fontSize: 24,color: Colors.white)
        )
      ),
      Positioned(
        right: 0,
        bottom: 0,
        child: Image.asset('assets/top-right.png', scale: 1.75)),
    ]));

Widget bottom = Container(
  margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
  child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        'assets/bottom.jpg',
        fit: BoxFit.fitWidth,
      )
  ),
);