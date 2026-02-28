import 'package:flutter/material.dart';
import 'package:ride_guide/resources/app_colors.dart';
import 'package:ride_guide/resources/app_strings.dart';
import 'package:ride_guide/resources/app_styles.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  int _selectedRole = -1; // -1 = none, 0 = Driver, 1 = Commuter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          AppStrings.chooseRole,
          style: AppStyles.titleX(size: 18, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Subtitle
              Text(
                AppStrings.chooseRoleDesc,
                textAlign: TextAlign.center,
                style: AppStyles.subText(size: 14, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // Driver Card
              _buildRoleCard(
                index: 0,
                icon: Icons.directions_car_rounded,
                title: AppStrings.driver,
                description: AppStrings.driverDesc,
              ),

              const SizedBox(height: 20),

              // Commuter Card
              _buildRoleCard(
                index: 1,
                icon: Icons.person_pin_circle_rounded,
                title: AppStrings.commuter,
                description: AppStrings.commuterDesc,
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selectedRole == -1
                      ? null
                      : () {
                    // TODO: Navigate to Sign Up screen with selected role
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.primaryColorLight,
                    disabledForegroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.continueText,
                    style: AppStyles.subText(size: 16, color: Colors.white).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required int index,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final bool isSelected = _selectedRole == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.12)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.grey.shade500,
              ),
            ),

            const SizedBox(width: 16),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.titleX(
                      size: 17,
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppStyles.subText(
                      size: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Radio indicator
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
