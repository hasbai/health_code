import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_code/time.dart';
import 'package:qr_flutter/qr_flutter.dart';

const green = Color(0xff11b363);

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
            Image.asset(
              'assets/default_avatar.png',
              width: 84,
              height: 84,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('*晚',style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                )),
                const SizedBox(width: 12),
                Image.asset(
                  'assets/eye_closed.png',
                  width: 32,
                  height: 32,
                ),
              ],
            ),
            Image.asset(
                'assets/亲属随申码.png',
                scale: 1.5
            ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text('4',style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold
                  )),
                  Text(' 天内核酸检测结果'),
                  Text('【阴性】', style: TextStyle(
                        color: green,
                        fontWeight: FontWeight.bold
                  )),
          ],
)
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,

            ],
          )
      )



]));
