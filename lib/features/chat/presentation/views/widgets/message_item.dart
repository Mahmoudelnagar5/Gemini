import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/message.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser
              ? const Color(0xff444746).withOpacity(0.5)
              : const Color.fromARGB(255, 101, 99, 99).withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft:
                message.isUser ? const Radius.circular(15) : Radius.zero,
            bottomRight:
                message.isUser ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imageUrl != null) // Display image if available
              Image.file(
                File(message.imageUrl!),
                height: 200,
              ),
            message.imageUrl != null
                ? const SizedBox(height: 10)
                : const SizedBox(),
            if (message.text.isNotEmpty) // Display text if available
              Text(
                message.text,
                softWrap: true,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: message.isUser ? TextAlign.right : TextAlign.left,
              ),
          ],
        ),
      ),
    );
  }
}
