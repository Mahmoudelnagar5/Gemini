// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/utils/app_router.dart';
import 'package:gemini/features/chat/presentation/manager/chat_cubit/chat_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => ChatCubit(),
      child: const Gemini(),
    ),
  );
}

class Gemini extends StatelessWidget {
  const Gemini({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      title: 'Gemini',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
    );
  }
}
