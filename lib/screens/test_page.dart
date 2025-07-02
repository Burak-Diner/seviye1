// lib/screens/test_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../theme/app_theme.dart';

class TestPage extends StatefulWidget {
  final List<Question> questions;
  const TestPage({Key? key, required this.questions}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentIndex = 0;
  late List<Set<int>> answers;

  @override
  void initState() {
    super.initState();
    answers = List.generate(widget.questions.length, (_) => <int>{});
  }

  void _finishTest() {
    double totalScore = 0;
    int totalSelections = 0;

    for (var i = 0; i < widget.questions.length; i++) {
      final q = widget.questions[i];
      for (var idx in answers[i]) {
        totalScore += q.scores[idx];
        totalSelections++;
      }
    }

    if (totalSelections == 0) {
      Navigator.pop(context, 0.0);
      return;
    }

    final double average = totalScore / totalSelections;
    const double maxPerOption = 4.0;
    final double normalized = (average / maxPerOption) * 10;
    final double displayScore = double.parse(normalized.toStringAsFixed(1));

    Navigator.pop(context, displayScore);
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.themeData;
    final q = widget.questions[currentIndex];
    final total = widget.questions.length;
    final selSet = answers[currentIndex];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress bar
              LinearProgressIndicator(
                value: (currentIndex + 1) / total,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                minHeight: 6,
              ),
              const SizedBox(height: 12),

              // Soru sayacı
              Text(
                '${currentIndex + 1}/$total',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              // Soru metni
              Text(
                q.text,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 24),

              // Seçenekler
              Expanded(
                child: ListView.builder(
                  itemCount: q.options.length,
                  itemBuilder: (_, i) => _OptionTile(
                    text: q.options[i],
                    isSelected: selSet.contains(i),
                    onTap: () {
                      setState(() {
                        if (q.isMultiSelect) {
                          if (selSet.contains(i)) {
                            selSet.remove(i);
                          } else {
                            selSet.add(i);
                          }
                        } else {
                          selSet
                            ..clear()
                            ..add(i);
                        }
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 12),
              const Text('Birden fazla seçim işaretleyebilirsiniz.'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentIndex > 0)
                    TextButton.icon(
                      onPressed: () => setState(() => currentIndex--),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Geri Gel'),
                      style: TextButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                      ),
                    )
                  else
                    const SizedBox(width: 80),
                  ElevatedButton(
                    onPressed: selSet.isNotEmpty
                        ? () {
                            if (currentIndex + 1 < total) {
                              setState(() => currentIndex++);
                            } else {
                              _finishTest();
                            }
                          }
                        : null,
                    child: Text(currentIndex + 1 < total ? 'İlerle' : 'Bitir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = AppTheme.themeData.primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? primary : Colors.grey[300]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primary : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected ? primary : Colors.white,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? primary : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
