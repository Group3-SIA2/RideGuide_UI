import 'package:flutter/material.dart';
import 'package:ride_guide/resources/app_colors.dart';
import 'package:ride_guide/resources/app_routes.dart';
import 'package:ride_guide/resources/app_strings.dart';
import 'package:ride_guide/views/auth/choose_role.dart';
import 'package:ride_guide/views/auth/login.dart';
import 'package:ride_guide/views/auth/signup.dart';
import 'package:ride_guide/views/splash_screen.dart';
import 'package:ride_guide/views/walkthrough.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
        fontFamily: 'Inter'
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.walkthrough: (context) => const WalkthroughScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.chooseRole: (context) => const ChooseRoleScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
      },
    );

  }
}
