import 'package:flutter/material.dart';
import 'package:gemini/features/chat/presentation/views/widgets/gradient_text.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const GradientText(
      text: 'Welcome to Gemini',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
