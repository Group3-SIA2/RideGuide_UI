import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_guide/controllers/auth_controller.dart';
import 'package:ride_guide/resources/app_colors.dart';
import 'package:ride_guide/resources/app_routes.dart';
import 'package:ride_guide/resources/app_strings.dart';
import 'package:ride_guide/resources/app_styles.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  bool _isResending = false;
  String? _errorText;
  String _email = '';
  String _type = 'email_verification';

  // Resend timer
  int _resendSeconds = 300;
  Timer? _resendTimer;
  bool get _canResend => _resendSeconds == 0;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, dynamic>) {
      _email = args['email'] ?? '';
      _type = args['type'] ?? 'email_verification';
    }
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() => _resendSeconds = 300);
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_resendSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_resendSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get _maskedEmail {
    if (_email.isEmpty) return '';
    final parts = _email.split('@');
    if (parts.length != 2) return _email;
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return '$name*****@$domain';
    return '${name.substring(0, 2)}${'*' * (name.length - 2)}@$domain';
  }

  String get _otpCode => _otpControllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    final otp = _otpCode;

    if (otp.length < 6) {
      setState(() => _errorText = 'Please enter the complete 6-digit code');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    try {
      final response = await AuthController.verifyOtp(_email, otp, _type);

      if (response.success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );

          // Navigate based on type
          if (_type == 'email_verification') {
            Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.chooseRole, (route) => false,
            );
          } else if (_type == 'login_2fa') {
            Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.chooseRole, (route) => false,
            );
          }
        }
      } else {
        if (mounted) {
          setState(() => _errorText = response.message);
          for (final controller in _otpControllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _errorText = 'Something went wrong. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    setState(() {
      _isResending = true;
      _errorText = null;
    });

    try {
      final response = await AuthController.resendOtp(_email, _type);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );

        if (response.success) {
          _startResendTimer();
          for (final controller in _otpControllers) {
            controller.clear();
          }
          _focusNodes[0].requestFocus();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to resend OTP. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isResending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
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
          AppStrings.verifyEmailTitle,
          style: AppStyles.titleX(size: 18, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),

              // Heading
              Text(
                AppStrings.verifyEmailHeading,
                style: AppStyles.titleX(size: 28, color: Colors.black),
              ),

              const SizedBox(height: 30),

              // OTP fields
              _buildOtpFields(),

              // Error text
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorText!,
                    style: AppStyles.subText(size: 12, color: Colors.red),
                  ),
                ),

              const SizedBox(height: 24),

              // Timer
              Text(
                _formattedTime,
                style: AppStyles.titleX(
                    size: 16, color: AppColors.primaryColor),
              ),

              const SizedBox(height: 16),

              // Description with masked email
              RichText(
                text: TextSpan(
                  style: AppStyles.subText(size: 13, color: Colors.grey),
                  children: [
                    TextSpan(text: AppStrings.verifyEmailDesc),
                    TextSpan(
                      text: _maskedEmail,
                      style: AppStyles.subText(size: 13, color: Colors.black87)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(text: AppStrings.verifyEmailDescSuffix),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Resend code
              _buildResendButton(),

              const SizedBox(height: 75),

              // Verify button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
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
                          AppStrings.verifyButton,
                          style: AppStyles.subText(
                                  size: 16, color: Colors.white)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      children: List.generate(6, (index) {
        final hasValue = _otpControllers[index].text.isNotEmpty;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < 5 ? 8 : 0),
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (_otpControllers[index].text.isEmpty && index > 0) {
                    _otpControllers[index - 1].clear();
                    _focusNodes[index - 1].requestFocus();
                    setState(() {});
                  }
                }
              },
              child: TextField(
                controller: _otpControllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: AppStyles.titleX(size: 22, color: Colors.black),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '●',
                  hintStyle: AppStyles.subText(
                    size: 12,
                    color: Colors.grey.shade300,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _errorText != null
                          ? Colors.red
                          : hasValue
                              ? AppColors.primaryColor
                              : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _errorText != null
                          ? Colors.red
                          : AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (_errorText != null) {
                    setState(() => _errorText = null);
                  }

                  // Handle paste (multiple digits)
                  if (value.length > 1) {
                    _handlePaste(value, index);
                    return;
                  }

                  if (value.isNotEmpty && index < 5) {
                    _focusNodes[index + 1].requestFocus();
                  }

                  setState(() {});

                  if (_otpCode.length == 6) {
                    FocusScope.of(context).unfocus();
                    _verifyOtp();
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  void _handlePaste(String value, int startIndex) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    for (int i = 0; i < digits.length && (startIndex + i) < 6; i++) {
      _otpControllers[startIndex + i].text = digits[i];
    }

    final nextIndex = (startIndex + digits.length).clamp(0, 5);
    _focusNodes[nextIndex].requestFocus();

    setState(() {});

    if (_otpCode.length == 6) {
      FocusScope.of(context).unfocus();
      _verifyOtp();
    }
  }

  Widget _buildResendButton() {
    return GestureDetector(
      onTap: _canResend && !_isResending ? _resendOtp : null,
      child: _isResending
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 2,
              ),
            )
          : RichText(
              text: TextSpan(
                style: AppStyles.subText(
                  size: 13,
                  color: _canResend ? Colors.black87 : Colors.grey.shade400,
                ),
                children: [
                  TextSpan(text: AppStrings.didntReceiveCode),
                  TextSpan(
                    text: AppStrings.resendCode,
                    style: AppStyles.subText(
                      size: 13,
                      color: _canResend
                          ? AppColors.primaryColor
                          : Colors.grey.shade400,
                    ).copyWith(
                      fontWeight: FontWeight.w600,
                      decoration: _canResend
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
