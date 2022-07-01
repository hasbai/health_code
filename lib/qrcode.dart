import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key}) : super(key: key);

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  static const defaultText = '关注永雏塔菲喵';
  static const double embeddedImageSize = 48;
  String text = defaultText;

  load() async {
    final db = await SharedPreferences.getInstance();
    final qrcodeText = db.getString('qrcode');
    if (qrcodeText != null) {
      setState(() {
        text = qrcodeText;
      });
    }
  }

  save() async {
    final db = await SharedPreferences.getInstance();
    db.setString('qrcode', text);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: QrImage(
        data: text,
        version: 5,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
        size: 220,
        foregroundColor: green,
        embeddedImage: const AssetImage('assets/qrcode_core.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: const Size(embeddedImageSize, embeddedImageSize),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('请输入内容'),
            content: TextFormField(
                initialValue: text,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                }
            ),
            actions: [
              TextButton(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('确定'),
                onPressed: () {
                  save();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
