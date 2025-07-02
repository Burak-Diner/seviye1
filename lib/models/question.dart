// lib/models/question.dart

class Question {
  final String text;
  final List<String> options;
  final List<int> scores;
  final bool isMultiSelect;

  Question({
    required this.text,
    required this.options,
    required this.scores,
    this.isMultiSelect = false,
  }) : assert(
         scores.length == options.length,
         'scores ve options uzunlukları eşit olmalı',
       );
}
