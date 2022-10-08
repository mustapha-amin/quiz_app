import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/api_service/http_service.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/completed.dart';
import 'package:quiz_app/screens/error_page.dart';
import 'package:quiz_app/shared/options.dart';
import 'package:quiz_app/shared/spacings.dart';
import '../models/quiz.dart';

class QuizScreen extends StatefulWidget {
  int? categoryId;
  String? difficulty;
  QuizScreen({Key? key, this.categoryId, this.difficulty}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Quiz>>? quizzes;

  @override
  void initState() {
    try {
      quizzes = HttpService.getQuizzes(
        '20',
        widget.categoryId,
        widget.difficulty,
      );
    } catch (e) {
      quizzes = HttpService.getQuizzes(
        '10',
        widget.categoryId,
        widget.difficulty,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var quiz = Provider.of<QuizProvider>(context);
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final popscope = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Quit game"),
                content: const Text("Do you want to quit the game"),
                actions: [
                  TextButton(
                      onPressed: () {
                        int count = 0;
                        quiz.reset();
                        Navigator.of(context).popUntil((_) => count++ == 3);
                      },
                      child: const Text("Yes")),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No"),
                  ),
                ],
              );
            });
        return popscope;
      },
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: quizzes,
            builder:
                (BuildContext context, AsyncSnapshot<List<Quiz>> snapshot) {
              if (snapshot.hasData) {
                if (quiz.questions.isEmpty) {
                  quiz.updateQuestions(snapshot.data!);
                  quiz.updateOptions();
                  quiz.options.map((e) => print);
                } else {}
                return quiz.questionIndex == 20
                    ? Container(color: Colors.white)
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              addVerticalSpacing(size.height / 20),
                              Text(
                                "${quiz.questionIndex + 1} / ${quiz.questions.length}",
                                style: GoogleFonts.aBeeZee(fontSize: 23),
                              ),
                              addVerticalSpacing(25),
                              LinearProgressIndicator(
                                backgroundColor: Colors.grey[500],
                                value:
                                    quiz.questionIndex / quiz.questions.length,
                              ),
                              addVerticalSpacing(25),
                              Text(
                                quiz.questions[quiz.questionIndex].question!,
                                style: GoogleFonts.lato(fontSize: 30),
                              ),
                              addVerticalSpacing(10),
                              ...quiz.options[quiz.questionIndex]
                                  .map((option) => GestureDetector(
                                        onTap: () {
                                          context
                                              .read<QuizProvider>()
                                              .updateSelected(option);
                                        },
                                        child: Option(
                                          text: option,
                                          color: option == quiz.selectedOption
                                              ? Colors.amber[300]
                                              : Colors.grey[300],
                                        ),
                                      ))
                                  .toList(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 0,
                                      minimumSize: Size(size.width / 3.5, 40),
                                      backgroundColor: quiz.selectedOption == ''
                                          ? Colors.grey
                                          : Colors.blue[700],
                                    ),
                                    onPressed: () {
                                      if (quiz.selectedOption != '') {
                                        context
                                            .read<QuizProvider>()
                                            .addToSelectedOptions(
                                                quiz.selectedOption);
                                        context
                                            .read<QuizProvider>()
                                            .incrementIndex();
                                        log(quiz.questionIndex.toString());
                                        if (quiz.questionIndex ==
                                            quiz.questions.length) {
                                          quiz.setRemark();
                                          quiz.updateScore();
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const CompletedScreen();
                                          }));
                                        }
                                      } else {
                                        null;
                                      }
                                    },
                                    child: Text(
                                      quiz.questionIndex + 1 <
                                              quiz.questions.length
                                          ? "Next"
                                          : "Finish",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
