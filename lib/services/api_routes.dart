class ApiRoutes {
  static String baseUrl = 'http://192.168.1.6:8000/api';
  static String registerUrl = '$baseUrl/auth/register';
  static String loginUrl = '$baseUrl/auth/login';
  static String verifyOtpUrl = '$baseUrl/auth/verify-otp';
  static String resendOtpUrl = '$baseUrl/auth/resend-otp';
}