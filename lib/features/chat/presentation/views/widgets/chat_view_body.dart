import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/core/utils/assets.dart';
import 'package:gemini/core/widgets/custom_text_form_field.dart';
import 'package:gemini/features/chat/presentation/views/widgets/messages_list_view.dart';
import 'package:gemini/features/chat/presentation/views/widgets/no_message_widget.dart';

import '../../manager/chat_cubit/chat_cubit.dart';
import '../../manager/chat_cubit/chat_states.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().initGemini();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.slowMiddle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset(
                AppAssets.icon,
                width: 25,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              AppAssets.logo,
              width: 90,
            ),
          ],
        ),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          // print('error:  ${state.selectedImage}');
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty
                      ? const NoMessagesWidget()
                      : MessagesListView(
                          scrollController: _scrollController,
                          isLoading: state.isLoading,
                          messages: state.messages,
                        ),
                ),
                if (BlocProvider.of<ChatCubit>(context).selectedImage != null)
                  _buildSelectedImagePreview(context, state.selectedImage!),
                _buildInputField(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectedImagePreview(BuildContext context, File? selectedImage) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.file(
              selectedImage!,
              height: 100,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                BlocProvider.of<ChatCubit>(context).clearImage();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
      child: Form(
        key: _formKey,
        child: CustomTextFormField(
          hintText: 'Type a message...',
          controller: _controller,
          onSaved: (_) {
            if (_formKey.currentState!.validate()) {
              context.read<ChatCubit>().sendMessage(_controller.text);
              BlocProvider.of<ChatCubit>(context).clearImage();
              _controller.clear();
              _scrollToEnd();
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a message';
            }
            return null;
          },
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  onPressed: () {
                    context.read<ChatCubit>().pickImage();
                  }),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ChatCubit>().sendMessage(_controller.text);
                    BlocProvider.of<ChatCubit>(context).clearImage();
                    _controller.clear();
                    _scrollToEnd();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
