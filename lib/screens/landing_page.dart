// lib/screens/landing_page.dart

import 'package:flutter/material.dart';
import '../models/question.dart';
import '../theme/app_theme.dart';
import 'test_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<String> sports = ['Tenis', 'Futbol', 'Basketbol', 'Go Kart'];
  String? selectedSport;
  final Map<String, int> scores = {};

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
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.themeData;
    final hasScore = selectedSport != null && scores.containsKey(selectedSport);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Spor Testi'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Spor seçimi dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Spor Seç',
                floatingLabelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
              ),
              dropdownColor: theme.primaryColor,
              style: const TextStyle(color: Colors.white),
              value: selectedSport,
              items:
                  sports
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
              onChanged: (v) {
                setState(() {
                  selectedSport = v;
                });
              },
            ),
            const SizedBox(height: 32),

            if (selectedSport == null)
              Text(
                'Lütfen önce bir spor seç.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              )
            else if (hasScore)
              Column(
                children: [
                  Text(
                    '$selectedSport Test Skorun:',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${scores[selectedSport]}/10',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 36),
                  ),
                ],
              )
            else
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push<int>(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => TestPage(
                            questions: _questionsForSport(selectedSport!),
                          ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      scores[selectedSport!] = result;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'Teste Başla',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
