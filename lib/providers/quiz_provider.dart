import 'package:flutter/material.dart';
import '../models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  List<Quiz> questions = [];

  // options displayed on the screen
  List<List> options = [];

  // answers to questions
  List<String?> answers = [];

  // index of the current question
  int questionIndex = 0;

  int _score = 0;

  int get score => _score;

  // selected option
  String selectedOption = '';

  // options selected by user for each question
  List<String> selectedOptions = [];

  String remark = '';

  // make selected option null when next button is selected
  void clearSelected() {
    selectedOption = '';
    notifyListeners();
  }

  // shuffle the options derived from incorrect and correct answers
  void updateOptions() {
    options = questions.map((e) => e.incorrectAnswers).toList();
    answers = questions.map((e) => e.answer).toList();
    int index = 0;
    for (index; index < options.length; index++) {
      options[index].add(answers.elementAt(index));
      options[index].shuffle();
    }
  }

  void updateQuestions(List<Quiz>? questionFromApi) {
    reset();
    questions.addAll(questionFromApi!);
  }

  void incrementIndex() {
    questionIndex++;
    selectedOption = '';
    notifyListeners();
  }

  void updateScore() {
    for (var i in selectedOptions) {
      for (var j in answers) {
        if (i == j) {
          _score++;
        }
      }
    }
    notifyListeners();
  }

  void addToSelectedOptions(String option) {
    selectedOptions.add(option);
  }

  void updateSelected(String text) {
    selectedOption = text;
    notifyListeners();
  }

  void reset() {
    questions = [];
    options = [];
    answers = [];
    questionIndex = 0;
    _score = 0;
    selectedOptions = [];
  }

  void setRemark() {
    if (score <= 7) {
      remark = 'Poor';
    } else if (score > 7 && score <= 10) {
      remark = 'Fairly good';
    } else if (score > 11 && score <= 15) {
      remark = 'good';
    } else {
      remark = 'Very good';
    }
    notifyListeners();
  }
}
