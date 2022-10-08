import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/shared/spacings.dart';
import '../shared/result.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool expanded = false;
  final ScrollController scrollController = ScrollController();

  void scrollToTop() {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    var quiz = Provider.of<QuizProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Center(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${quiz.score} / ${quiz.questions.length}"),
                Text(
                  "Completed",
                  style: GoogleFonts.lato(fontSize: 40),
                ),
                addVerticalSpacing(10),
                Text(
                  quiz.remark,
                  style: GoogleFonts.raleway(
                    fontSize: 27,
                  ),
                ),
                addVerticalSpacing(30),
                const Icon(
                  Icons.check_circle_sharp,
                  color: Colors.green,
                  size: 60,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.home),
                  label: const Text(
                    "Home",
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ == 2);
                    quiz.reset();
                  },
                ),
                Card(
                  elevation: 1,
                  child: ExpansionTile(
                    onExpansionChanged: (expand) {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    title: Text(expanded ? "Hide result" : "Show results"),
                    children: [
                      ...quiz.questions
                          .map(
                            (e) => Result(
                              question: e.question,
                              optionsIndex: quiz.questions.indexOf(e),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'back to top',
        onPressed: scrollToTop,
        child: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }
}
