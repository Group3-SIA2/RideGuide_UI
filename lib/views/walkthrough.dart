import 'package:flutter/material.dart';
import 'package:ride_guide/resources/app_colors.dart';
import 'package:ride_guide/resources/app_routes.dart';
import 'package:ride_guide/resources/app_strings.dart';
import 'package:ride_guide/resources/app_styles.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'assets/images/realtime.png',
      'title': AppStrings.realTime,
      'description': AppStrings.realTimeDesc,
    },
    {
      'image': 'assets/images/fare_calculator.png',
      'title': AppStrings.fareCalculator,
      'description': AppStrings.fareCalculatorDesc,
    },
    {
      'image': 'assets/images/search_location.png',
      'title': AppStrings.searchLocation,
      'description': AppStrings.searchLocationDesc,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // PageView takes up the available space
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(
                    image: _pages[index]['image']!,
                    title: _pages[index]['title']!,
                    description: _pages[index]['description']!,
                  );
                },
              ),
            ),

            // Page indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(index),
              ),
            ),

            const SizedBox(height: 32),

            // Sign Up button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.signUp,
                    style: AppStyles.subText(size: 16, color: Colors.white).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: BorderSide(color: AppColors.primaryColorLight, width: 1.5),
                    backgroundColor: AppColors.primaryColorLight.withValues(alpha: 0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.login,
                    style: AppStyles.subText(size: 16, color: AppColors.primaryColor).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Walkthrough image
          Image.asset(
            image,
            width: 280,
            height: 280,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.titleX(size: 28, color: Colors.black),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppStyles.subText(size: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 10 : 8,
      height: _currentPage == index ? 10 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryColor
            : AppColors.primaryColorLight,
        shape: BoxShape.circle,
      ),
    );
  }
}
