import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'constants.dart';

class CovidTestResult extends StatefulWidget {
  const CovidTestResult({Key? key}) : super(key: key);

  @override
  State<CovidTestResult> createState() => _CovidTestResultState();
}

class _CovidTestResultState extends State<CovidTestResult> {
  int _day = 1;

  List<String> time(){
    if (_day <= 2){
      return ['${_day * 24}', '小时'];
    } else {
      return ['$_day', '天'];
    }
  }

  Color color(){
    switch (_day){
      case 1:
        return green;
      case 2:
        return purple;
      default:
        return Colors.black;
    }
  }

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
            time()[0],
            style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: color(),
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('设置天数'),
                  content:SleekCircularSlider(
                      appearance: const CircularSliderAppearance(
                        size: 200,
                      ),
                      min: 1,
                      max: 14,
                      initialValue: _day.toDouble(),
                      innerWidget: (double value) {
                        return Center(child: Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w300
                            ),
                        ));
                      },
                      onChange: (value) {
                        setState(() {
                          _day = value.toInt();
                        });
                      }
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
        Text('${time()[1]}内核酸检测结果'),
        const Text('【阴性】', style: TextStyle(
            color: green,
            fontWeight: FontWeight.bold
        )),
      ],
    );
  }
}
