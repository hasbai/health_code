import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double iconSize = 24;
const defaultName = '向晚';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  String _name = defaultName;
  String name = defaultName;
  bool hidden = false;
  late String iconPath;

  changeState(){
    setState(() {
      if(hidden){
        hidden = false;
        iconPath = 'assets/eye_open.png';
      }else{
        hidden = true;
        iconPath = 'assets/eye_close.png';
      }
    });
    displayName(_name);
  }

  displayName(String name){
    _name = name;
    setState(() {
      if (hidden){
        this.name = '*' * (name.length - 1) + name[name.length - 1];
      }else{
        this.name = name;
      }
    });
  }

  load() async {
    final db = await SharedPreferences.getInstance();
    _name = db.getString('name') ?? defaultName;
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
    changeState();
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
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
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
        InkWell(
          child: Image.asset(
            iconPath,
            width: iconSize,
            height: iconSize,
          ),
          onTap: () {
            changeState();
          },
        ),
      ],
    );
  }
}
