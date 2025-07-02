import 'package:flutter/material.dart';
import '../models/question.dart';
import '../theme/app_theme.dart';
import 'test_page.dart';

class StartTestPage extends StatelessWidget {
  final String sport;
  final List<Question> questions;
  const StartTestPage({Key? key, required this.sport, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.themeData;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(sport), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          Text(
            'Seviyeni\nHemen Ölç!',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 28),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push<double>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TestPage(questions: questions),
                      ),
                    );
                    Navigator.pop(context, result);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Hemen Başla',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('Daha Sonra'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
