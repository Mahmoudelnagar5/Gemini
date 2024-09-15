import 'package:gemini/features/chat/presentation/views/chat_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const initialRoute = '/';
  static const chatRoute = '/chat';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: chatRoute,
        builder: (context, state) => const ChatView(),
      ),
    ],
  );
}
