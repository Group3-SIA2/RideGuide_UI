import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ride_guide/resources/app_colors.dart';
import 'package:ride_guide/resources/app_strings.dart';
import 'package:ride_guide/resources/app_styles.dart';

import '../resources/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo (SVG – transparent background)
            SvgPicture.asset(
              'assets/images/rideguide_design.svg',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),

            // App name
            Text(
              AppStrings.appName,
              style: AppStyles.titleX(size: 36, color: Colors.white)
            ),
            // Tagline
            Text(
              AppStrings.subName,
              style: AppStyles.subText(size: 19, color: Colors.white70)
            ),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    initApp();
    super.initState();
  }

  // Splash Screen, After 4 seconds, navigate to the Walkthrough screen
  void initApp() {
    Future.delayed(const Duration(seconds: 4),
            () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.walkthrough));
  }
}


