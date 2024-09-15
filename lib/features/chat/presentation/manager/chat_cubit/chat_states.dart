import 'dart:io';
import '../../../data/models/message.dart';

class ChatState {
  final List<Message> messages;
  final File? selectedImage;
  final bool isLoading;

  ChatState({
    this.messages = const [],
    this.selectedImage,
    this.isLoading = false,
  });

  ChatState copyWith({
    List<Message>? messages,
    File? selectedImage,
    bool? isLoading,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      selectedImage: selectedImage ?? this.selectedImage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
