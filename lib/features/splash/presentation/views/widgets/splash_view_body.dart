import 'package:flutter/material.dart';
import 'package:gemini/core/utils/assets.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/utils/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotationAnimation;
  late AnimationController textController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    rotationAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.repeat();
    textController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    scaleAnimation =
        Tween<double>(begin: 0.5, end: 2.0).animate(textController);
    textController.forward();
    excuteNavigation();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedBuilder(
            animation: rotationAnimation,
            builder: (context, _) {
              return Opacity(
                opacity: rotationAnimation.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: Lottie.asset(
                      AppAssets.splashImage,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  void excuteNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).push(AppRouter.chatRoute);
    });
  }
}
