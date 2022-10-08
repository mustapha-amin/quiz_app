import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Option extends StatefulWidget {
  String? text;
  Color? color;
  Option({Key? key, this.text, this.color}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height / 13,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            widget.text!,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}