import 'package:flutter/material.dart';

class AmPm extends StatelessWidget {
  final bool isItAm;
  AmPm({required this.isItAm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        child: Center(
            child: Text(
          isItAm == true ? "am" : "pm",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
    );
  }
}
