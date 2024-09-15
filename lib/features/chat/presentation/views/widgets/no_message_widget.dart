import 'package:flutter/material.dart';
import 'package:gemini/features/chat/presentation/views/widgets/wlcome_text.dart';
import 'package:google_fonts/google_fonts.dart';

class NoMessagesWidget extends StatelessWidget {
  const NoMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const WelcomeText(),
            const Text(
              'How can I help you today?',
              style: TextStyle(
                fontSize: 31,
                color: Color(0xff6D7170),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xff444746).withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "A team of reviewers is looking at some saved conversations to improve Google's AI technologies. If you don't want your future conversations to be reviewed, you can turn off 'Gemini app activity'. If this setting is on, we recommend that you avoid entering any information that you would not want to be reviewed or used.",
                style: GoogleFonts.poppins(
                  color: const Color(0xff889bd5).withOpacity(0.85),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
