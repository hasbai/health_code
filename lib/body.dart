import 'package:flutter/material.dart';
import 'package:health_code/time.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'avatar.dart';
import 'constants.dart';
import 'covid_test_result.dart';
import 'name.dart';

Widget body = Container(
    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    child: Column(children: [
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/随申码.png',
          fit: BoxFit.fitWidth,
        )
    ),
      Container(
        height: 200,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Avatar(),
            const Name(),
            Image.asset('assets/亲属随申码.png', scale: 1.5),
          ]
      )),
      SizedBox(
        height: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const TimeLine(),
            QrImage(
              data: '关注永雏塔菲喵',
              version: 5,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
              size: 300,
              foregroundColor: green,
              embeddedImage: const AssetImage('assets/qrcode_core.png'),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: const Size(48, 48),
              ),
            ),
            const Text('绿色', style: TextStyle(
                fontSize: 28,
                color: green,
                fontWeight: FontWeight.bold
            ))
          ],
        )
      ),
      SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/已支持刷医保.png',
                width: 260
              ),
              const CovidTestResult(),
            ],
          )
      )



]));
