import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/api_service/http_service.dart';
import 'package:quiz_app/shared/spacings.dart';
import 'quiz_screen.dart';
import '../models/categories.dart';

class Detail extends StatefulWidget {
  Category? category;
  String? imageUrl;
  Detail({Key? key, this.category, this.imageUrl}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String? _difficulty;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: '${widget.category!.id}',
                  child: Container(
                    width: double.infinity,
                    height: size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/${widget.category!.id}.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 9,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_circle_left),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Text(
                    widget.category!.name!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: [
                  addVerticalSpacing(20),
                  const Text("Select difficulty"),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    width: double.infinity,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                        hint: const Text(
                          " Select difficulty",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: _difficulty,
                        items: [
                          ...difficulty
                              .map((String e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e,
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ))
                              .toList()
                        ],
                        onChanged: (newvalue) {
                          setState(() {
                            _difficulty = newvalue;
                          });
                        },
                      ),
                    ),
                  ),
                  addVerticalSpacing(10),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _difficulty != null ? Colors.amber[600] : Colors.grey,
                        elevation: 0,
                        minimumSize: Size(size.width / 2, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      label: const Text("Start quiz"),
                      onPressed: () {
                        _difficulty != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return QuizScreen(
                                      categoryId: widget.category!.id,
                                      difficulty: _difficulty!.toLowerCase(),
                                    );
                                  },
                                ),
                              )
                            : null;
                      },
                      icon: const Icon(Icons.play_arrow_outlined),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
