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
}