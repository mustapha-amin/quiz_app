class Quiz {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  List incorrectAnswers;
  String? answer;

  Quiz({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.incorrectAnswers,
    required this.answer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      incorrectAnswers: json['incorrect_answers'],
      answer: json['correct_answer'],
    );
  }
}
