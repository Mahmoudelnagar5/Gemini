// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gemini/core/widgets/custom_text_form_field.dart';
// import 'package:gemini/features/chat/presentation/views/widgets/messages_list_view.dart';
// import 'package:gemini/features/chat/presentation/views/widgets/no_message_widget.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../data/models/message.dart';

// class ChatViewBody extends StatefulWidget {
//   const ChatViewBody({super.key});

//   @override
//   State<ChatViewBody> createState() => _ChatViewBodyState();
// }

// class _ChatViewBodyState extends State<ChatViewBody> {
//   final TextEditingController _controller = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final List<Message> _messages = [];
//   File? selectedImage;
//   bool isLoading = false;
//   final ScrollController _scrollController =
//       ScrollController(); // Add ScrollController

//   @override
//   void initState() {
//     Gemini.init(apiKey: 'AIzaSyBJwcN4jOk4-lcWOAE3pSWu06CA8aH9_TA');
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose(); // Dispose of the ScrollController
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//   }

//   Future<void> callGeminiModel() async {
//     Gemini gemini = Gemini.instance;
//     try {
//       if (_controller.text.isNotEmpty || selectedImage != null) {
//         _messages.add(Message(
//           text: _controller.text,
//           isUser: true,
//           imageUrl: selectedImage?.path,
//         ));
//         setState(() {
//           isLoading = true;
//         });
//         _scrollToEnd();

//         Candidates? geminiResponse;
//         if (selectedImage != null) {
//           geminiResponse = await gemini.textAndImage(
//             text: _controller.text,
//             images: [await selectedImage!.readAsBytes()],
//           );
//         } else {
//           geminiResponse = await gemini.text(_controller.text);
//         }

//         setState(() {
//           _messages.add(Message(
//             text: geminiResponse?.content?.parts?.last.text ?? 'No response',
//             isUser: false,
//             imageUrl: selectedImage?.path,
//           ));
//           isLoading = false;

//           // Scroll to the end of the list after adding the response
//           _scrollToEnd();
//         });
//       }
//     } catch (e) {
//       print("Error: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _scrollToEnd() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0),
//               child: Image.asset(
//                 'assets/lottie/images/icon.png',
//                 width: 25,
//               ),
//             ),
//             const SizedBox(width: 5),
//             SvgPicture.asset(
//               'assets/images/logo.svg',
//               width: 90,
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: _messages.isEmpty
//                   ? const NoMessagesWidget()
//                   : MessagesListView(
//                       scrollController: _scrollController,
//                       isLoading: isLoading,
//                       messages: _messages,
//                     ),
//             ),
//             if (selectedImage != null) _buildSelectedImagePreview(),
//             _buildInputField(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectedImagePreview() {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Image.file(selectedImage!, height: 200),
//           ),
//           Positioned(
//             left: 70,
//             top: -10,
//             child: IconButton(
//               icon: const Icon(Icons.cancel_sharp, color: Colors.red),
//               onPressed: () {
//                 setState(() => selectedImage = null);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputField() {
//     return CustomTextFormField(
//       hintText: 'Type a message...',
//       controller: _controller,
//       onSaved: (_) {
//         setState(
//           () {
//             callGeminiModel();
//             _controller.clear();
//             selectedImage = null;
//           },
//         );
//       },
//       suffixIcon: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.add_photo_alternate_outlined),
//             onPressed: _pickImage,
//           ),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: isLoading
//                 ? null
//                 : () {
//                     setState(
//                       () {
//                         callGeminiModel();
//                         _controller.clear();
//                         selectedImage = null;
//                       },
//                     );
//                   },
//           ),
//         ],
//       ),
//     );
//   }
// }
