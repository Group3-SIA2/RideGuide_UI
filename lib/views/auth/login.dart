import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ride_guide/controllers/auth_controller.dart';
import 'package:ride_guide/resources/app_colors.dart';
import 'package:ride_guide/resources/app_routes.dart';
import 'package:ride_guide/resources/app_strings.dart';
import 'package:ride_guide/resources/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Login Method
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Clear previous errors
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Local validation
    bool hasError = false;

    if (email.isEmpty) {
      setState(() => _emailError = 'Email is required');
      hasError = true;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      hasError = true;
    }

    if (hasError) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthController.login(email, password);

      if (response.success) {
        // Login successful — navigate to verify email with login_2fa type
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
          Navigator.pushNamed(context, AppRoutes.verifyEmail, arguments: {
            'email': email,
            'type': 'login_2fa',
          });
        }
      } else {
        // Check for server-side field-level validation errors
        final errors = response.data?['errors'] as Map<String, dynamic>?;

        if (mounted) {
          setState(() {
            if (errors != null) {
              if (errors.containsKey('email')) {
                _emailError = (errors['email'] as List).first.toString();
              }
              if (errors.containsKey('password')) {
                _passwordError = (errors['password'] as List).first.toString();
              }
            }

            // If no field-level errors, show as email error (e.g. "account not found", "invalid credentials")
            if (_emailError == null && _passwordError == null) {
              _emailError = response.message;
            }
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.loginTitle,
          style: AppStyles.titleX(size: 18, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              // Email field
              _buildTextField(
                controller: _emailController,
                hintText: AppStrings.email,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),

              const SizedBox(height: 25),

              // Password field
              _buildTextField(
                controller: _passwordController,
                hintText: AppStrings.password,
                obscureText: _obscurePassword,
                errorText: _passwordError,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey,
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 35),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          AppStrings.loginTitle,
                          style: AppStyles.subText(size: 16, color: Colors.white)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                ),
              ),

              const SizedBox(height: 25),

              // Forgot Password
              Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: Navigate to Forgot Password
                  },
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppStyles.subText(
                      size: 16,
                      color: AppColors.primaryColor,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Don't have an account? Sign Up
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppStyles.subText(size: 14, color: Colors.grey),
                    children: [
                      TextSpan(text: AppStrings.dontHaveAccount),
                      TextSpan(
                        text: AppStrings.signUpTitle,
                        style: AppStyles.subText(
                          size: 14,
                          color: AppColors.primaryColor,
                        ).copyWith(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, AppRoutes.signup);
                          },
                      ),
                    ],
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: AppStyles.subText(size: 15, color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.subText(size: 15, color: Colors.grey.shade400),
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : AppColors.primaryColor,
                width: 1.5,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              errorText,
              style: AppStyles.subText(size: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }
}
