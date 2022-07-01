import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class CovidTestResult extends StatefulWidget {
  const CovidTestResult({Key? key}) : super(key: key);

  @override
  State<CovidTestResult> createState() => _CovidTestResultState();
}

class _CovidTestResultState extends State<CovidTestResult> {
  int _day = 2;

  load() async {
    final db = await SharedPreferences.getInstance();
    final day = db.getInt('day');
    if (day != null) {
      _day = day;
    }
  }

  save() async {
    final db = await SharedPreferences.getInstance();
    db.setInt('day', _day);
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        InkWell(
          child: Text(
            '$_day',
            style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('设置天数'),
                  content: NumberPicker(
                    value: _day,
                    minValue: 1,
                    maxValue: 14,
                    axis: Axis.horizontal,
                    onChanged: (value) {
                      setState(() {
                        _day = value;
                      });
                    },
                  ),
                  actions: [
                    TextButton(
                      child: const Text('取消'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('确定'),
                      onPressed: () {
                        save();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
          },
        ),
        const Text(' 天内核酸检测结果'),
        const Text('【阴性】', style: TextStyle(
            color: green,
            fontWeight: FontWeight.bold
        )),
      ],
    );
  }
}
