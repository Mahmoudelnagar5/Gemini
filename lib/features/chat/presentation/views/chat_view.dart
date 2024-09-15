import 'package:flutter/material.dart';
import 'package:gemini/features/chat/presentation/views/widgets/chat_view_body.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatViewBody(),
    );
  }
}
