import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini/features/chat/presentation/views/widgets/message_item.dart';
import '../../../../../core/utils/assets.dart';
import '../../../data/models/message.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView({
    super.key,
    required this.messages,
    required this.isLoading,
    required this.scrollController, // Add ScrollController
  });

  final List<Message> messages;
  final bool isLoading;
  final ScrollController scrollController;
  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration:
          const Duration(seconds: 2), // Duration of the rotation animation
      vsync: this,
    )..repeat(); // Repeats the animation infinitely
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController, // Attach ScrollController
      padding: EdgeInsets.zero,
      // physics: const BouncingScrollPhysics(),
      itemCount: widget.messages.length + (widget.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == widget.messages.length && widget.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
            child: _buildSkeleton(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10),
          child: MessageItem(
            message: widget.messages[index],
          ),
        );
      },
    );
  }

  Widget _buildSkeleton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(controller),
            child: SvgPicture.asset(
              AppAssets.geminiLogo,
              height: 30,
            ),
          ),
          Container(
            width: 250,
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[300]!,
                  const Color.fromARGB(255, 183, 214, 241),
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
