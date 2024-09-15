import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/features/chat/presentation/manager/chat_cubit/chat_states.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/constants.dart';
import '../../../data/models/message.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  Future<void> initGemini() async {
    Gemini.init(apiKey: kApiKey);
  }

  File? selectedImage;
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      emit(state.copyWith(selectedImage: selectedImage));
    }
  }

  void sendMessage(String text) async {
    if (text.isEmpty && state.selectedImage == null) return;

    // Add the user's message
    final userMessage = Message(
      text: text,
      isUser: true,
      imageUrl: selectedImage?.path,
    );

    emit(state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
    ));

    try {
      // Send message to the Gemini API
      Gemini gemini = Gemini.instance;
      Candidates? geminiResponse;

      if (selectedImage != null) {
        geminiResponse = await gemini.textAndImage(
          text: text,
          images: [await selectedImage!.readAsBytes()],
        );
      } else {
        geminiResponse = await gemini.text(text);
      }

      // Add the AI's response
      final aiMessage = Message(
        text: geminiResponse?.content?.parts?.last.text ?? 'No response',
        isUser: false,
      );
      selectedImage = null;
      emit(state.copyWith(
        messages: [...state.messages, aiMessage],
        isLoading: false,
        selectedImage: null, // Clear selected image after sending
      ));
    } catch (e) {
      print("Error: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  void clearImage() {
    selectedImage = null;
    emit(state.copyWith(selectedImage: null)); // Emit new state with null image
  }
}
