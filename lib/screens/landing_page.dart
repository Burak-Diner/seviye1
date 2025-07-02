// lib/screens/landing_page.dart

import 'package:flutter/material.dart';
import '../models/question.dart';
import '../theme/app_theme.dart';
import 'start_test_page.dart';
import '../widgets/score_gauge.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<String> sports = ['Tenis', 'Futbol', 'Basketbol', 'Go Kart'];
  final Map<String, double> scores = {};

  // Soru şablonları ve her bir şablonun seçenek/puanları
  static final _questionTemplates = <Map<String, dynamic>>[
    {
      'template': '{sport}da aşağıdakilerden hangi seviyedesin?',
      'options': ['Başlangıç', 'Orta', 'Orta / Üst', 'İleri'],
      'scores': [1, 2, 3, 4],
    },
    {
      'template': 'Cinsiyetiniz nedir?',
      'options': ['Kadın', 'Erkek', 'Diğer'],
      'scores': [1, 1, 1],
    },
    {
      'template': 'Daha önce en fazla hangi seviyede yarışmaya katıldın?',
      'options': ['Kulüp Turnuvası', 'İl Turnuvası', 'Bölge Turnuvası', 'Yok'],
      'scores': [1, 2, 3, 0],
    },
    {
      'template': 'Ne kadar zamandır düzenli {sport} oynuyorsun?',
      'options': ['< 6 ay', '6–12 ay', '1–3 yıl', '> 3 yıl'],
      'scores': [1, 2, 3, 4],
    },
    {
      'template': 'Başka benzer oyunlar oynadın mı?',
      'options': ['Evet', 'Hayır'],
      'scores': [1, 0],
    },
    {
      'template': 'Geçtiğimiz 6 ayda haftada ortalama kaç maç yaptın?',
      'options': ['0', '1–2', '3–4', '> 4'],
      'scores': [0, 1, 2, 3],
    },
    {
      'template': 'Son yıllarda hiç {sport} dersi aldın mı?',
      'options': ['Evet', 'Hayır'],
      'scores': [1, 0],
    },
    {
      'template': 'Kaç yaşındasın?',
      'options': ['< 18', '18–25', '26–40', '> 40'],
      'scores': [1, 2, 3, 4],
    },
    {
      'template': '{sport} dışında başka spor etkinliğin ne düzeyde?',
      'options': ['Hiç', 'Ara sıra', 'Düzenli', 'Profesyonel'],
      'scores': [0, 1, 2, 3],
    },
  ];

  List<Question> _questionsForSport(String sport) {
    return _questionTemplates.map((tpl) {
      final text = (tpl['template'] as String).replaceAll(
        '{sport}',
        sport.toLowerCase(),
      );
      return Question(
        text: text,
        options: List<String>.from(tpl['options']),
        scores: List<int>.from(tpl['scores']),
        isMultiSelect: true,
      );
    }).toList();
  }

  void _startTest(String sport) async {
    final result = await Navigator.push<double>(
      context,
      MaterialPageRoute(
        builder: (_) => StartTestPage(
          sport: sport,
          questions: _questionsForSport(sport),
        ),
      ),
    );
    if (result != null) {
      setState(() {
        scores[sport] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.themeData;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Spor Seç'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: sports.map((sport) {
          final hasScore = scores.containsKey(sport);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sport, style: theme.textTheme.titleMedium),
                hasScore
                    ? ScoreGauge(score: scores[sport]!)
                    : ElevatedButton(
                        onPressed: () => _startTest(sport),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Teste Başla',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
