import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  static const defaultName = '向晚';
  String _name = defaultName;
  String name = defaultName;

  void displayName(String name){
    _name = name;
    var buffer = StringBuffer();
    for(int i=0; i<name.length - 1; i++){
      buffer.write('*');
    }
    buffer.write(name.substring(name.length - 1, name.length));
    setState(() {
      this.name = buffer.toString();
    });
  }

  load() async {
    final db = await SharedPreferences.getInstance();
    final name = db.getString('name');
    if (name != null) {
      _name = name;
    }
    displayName(_name);
  }

  save() async {
    final db = await SharedPreferences.getInstance();
    db.setString('name', _name);
    displayName(_name);
  }

  @override
  void initState(){
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.black,
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('请输入姓名'),
                content: TextField(
                  onChanged: displayName
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
        ),
        const SizedBox(width: 12),
        Image.asset(
          'assets/eye_closed.png',
          width: 32,
          height: 32,
        ),
      ],
    );
  }
}
