import 'package:dio/dio.dart';
import 'package:ride_guide/services/api.dart';
import 'package:ride_guide/services/api_routes.dart';
import 'package:ride_guide/models/results.dart';

class AuthController {
  // Register a new user
  static Future<Result<Map<String, dynamic>>> register(String email, String password) async {
    try {
      final result = await ApiService.post(ApiRoutes.registerUrl, {
        'email': email,
        'password': password,
      });

      final data = result.data;

      return Result(
        success: data['success'] ?? true,
        message: data['message'] ?? 'Sign Up Successfully',
        data: data['data'],
      );

    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null && responseData is Map<String, dynamic>) {
        // Extract field-level errors from Laravel validation
        final errors = responseData['errors'] as Map<String, dynamic>?;

        return Result(
          success: false,
          message: responseData['message'] ?? 'Something went wrong.',
          data: errors != null ? {'errors': errors} : null,
        );
      }

      return Result(
        success: false,
        message: 'Something went wrong. Please try again.',
      );
    }
  }

  // Login
  static Future<Result<Map<String, dynamic>>> login(String email, String password) async {
    try {
      final result = await ApiService.post(ApiRoutes.loginUrl, {
        'email': email,
        'password': password,
      });

      final data = result.data;

      return Result(
        success: data['success'] ?? true,
        message: data['message'] ?? 'Login successful.',
        data: data['data'],
      );

    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null && responseData is Map<String, dynamic>) {
        final errors = responseData['errors'] as Map<String, dynamic>?;

        return Result(
          success: false,
          message: responseData['message'] ?? 'Invalid credentials.',
          data: errors != null ? {'errors': errors} : null,
        );
      }

      return Result(
        success: false,
        message: 'Something went wrong. Please try again.',
      );
    }
  }

  // Verify OTP
  static Future<Result<Map<String, dynamic>>> verifyOtp(String email, String otp, String type) async {
    try {
      final result = await ApiService.post(ApiRoutes.verifyOtpUrl, {
        'email': email,
        'otp': otp,
        'type': type
      });

      final data = result.data;

      return Result(
        success: data['success'] ?? true,
        message: data['message'] ?? 'Verification successful.',
        data: data['data'],
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null && responseData is Map<String, dynamic>) {
        return Result(
          success: false,
          message: responseData['message'] ?? 'Invalid OTP.',
        );
      }

      return Result(
        success: false,
        message: 'Something went wrong. Please try again.',
      );
    }
  }

  // Resend OTP
  static Future<Result<Map<String, dynamic>>> resendOtp(String email, String type) async {
    try {
      final result = await ApiService.post(ApiRoutes.resendOtpUrl, {
        'email': email,
        'type': type,
      });

      final data = result.data;

      return Result(
        success: data['success'] ?? true,
        message: data['message'] ?? 'OTP resent successfully.',
        data: data['data'],
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData != null && responseData is Map<String, dynamic>) {
        return Result(
          success: false,
          message: responseData['message'] ?? 'Failed to resend OTP.',
        );
      }

      return Result(
        success: false,
        message: 'Something went wrong. Please try again.',
      );
    }
  }
}