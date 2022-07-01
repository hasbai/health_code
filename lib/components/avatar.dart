import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  static const double size = 64;
  ImageProvider _image = const AssetImage('assets/default_avatar.png');

  loadImage() async {
    final db = await SharedPreferences.getInstance();
    final base64String = db.getString('image') ?? '';
    try {
      final bytes = base64.decode(base64String);
      setState(() {
        _image = Image.memory(bytes).image;
      });
    } catch (e) {
      if (kDebugMode) {
        print('failed to load image, use the default avatar');
      }
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final bytes = await image.readAsBytes();
    setState(() {
      _image = Image.memory(bytes).image;
    });
    // save to db
    final db = await SharedPreferences.getInstance();
    db.setString('image', base64Encode(bytes));
  }

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image(
        image: _image,
        width: size,
        height: size,
      ),
      onTap: () {
        pickImage();
      },
    );
  }
}
