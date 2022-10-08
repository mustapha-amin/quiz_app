import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';

class Result extends StatelessWidget {
  String? question;
  int? optionsIndex;
  Result({Key? key, this.question, this.optionsIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var quiz = Provider.of<QuizProvider>(context);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(thickness: 2, color: Colors.grey,),
            Text(
              question!,
              style: GoogleFonts.lato(
                fontSize: 26,
              ),
            ),
            quiz.selectedOptions[optionsIndex!] != quiz.answers[optionsIndex!]
                ? Container(
                    constraints: BoxConstraints(minHeight: size.width / 3),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              quiz.selectedOptions[optionsIndex!],
                            ),
                            const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${quiz.answers[optionsIndex!]}",
                            ),
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        quiz.selectedOptions[optionsIndex!],
                      ),
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
