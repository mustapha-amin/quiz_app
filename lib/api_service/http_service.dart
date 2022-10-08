import 'dart:convert';
import 'package:http/http.dart';
import '../models/quiz.dart';

class HttpService {
  static Future<List<Quiz>> getQuizzes(String? number,
      int? category, String? difficulty) async {
    final urlA =
        "https://opentdb.com/api.php?amount=$number&category=$category&difficulty=$difficulty&type=multiple";
    final urlB =
        "https://opentdb.com/api.php?amount=$number&category=$category&type=multiple";
    var url = difficulty != 'any' ? urlA : urlB;
    var uri = Uri.parse(url);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> questions = json['results'];
      List<Quiz> quizQuestions =
          questions.map((e) => Quiz.fromJson(e)).toList();
      return quizQuestions;
    } else {
      throw ("can't get quizzes");
    }
  }
}
