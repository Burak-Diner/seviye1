import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ScoreGauge extends StatelessWidget {
  final int score;
  const ScoreGauge({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.themeData;
    const double width = 80;
    final double position = (score.clamp(0, 10) / 10) * width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: width,
          height: 20,
          child: Stack(
            children: [
              Container(
                width: width,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              Positioned(
                left: position - 6,
                top: 0,
                child: Icon(
                  Icons.navigation,
                  color: theme.primaryColor,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score/10',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
