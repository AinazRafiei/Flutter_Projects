import 'package:flutter/material.dart';
import 'package:weelscroll/hours.dart';
import 'package:weelscroll/minutes.dart';
import 'package:weelscroll/tile.dart';
import 'tile.dart';
import 'minutes.dart';
import 'am_pm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FixedExtentScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //hoursweel
            Container(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                  controller: _controller,
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 13,
                      builder: (context, index) {
                        return MyHours(
                          hours: index,
                        );
                      })),
            ),
            SizedBox(
              width: 10,
            ),
            //minutesweel
            Container(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return MyMinutes(
                          mins: index,
                        );
                      })),
            ),
            Container(
              width: 70,
              child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 2,
                      builder: (context, index) {
                        if (index == 0) {
                          return AmPm(
                            isItAm: true,
                          );
                        } else {
                          return AmPm(
                            isItAm: false,
                          );
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
