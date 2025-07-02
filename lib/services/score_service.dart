import "../models/question.dart";

class ScoreService {
  /// Calculates a score for a list of questions and their selected answers.
  ///
  /// The score is averaged across all selected options and normalised to a
  /// 0–10 scale. If no selections are made, the result is `0.0`.
  static double calculateScore(
    List<Question> questions,
    List<Set<int>> answers,
  ) {
    double totalScore = 0;
    int totalSelections = 0;

    for (var i = 0; i < questions.length; i++) {
      final q = questions[i];
      for (var index in answers[i]) {
        totalScore += q.scores[index];
        totalSelections++;
      }
    }

    if (totalSelections == 0) return 0.0;

    final average = totalScore / totalSelections;
    const maxPerOption = 4.0;
    final normalised = (average / maxPerOption) * 10;
    return double.parse(normalised.toStringAsFixed(1));
  }
}

