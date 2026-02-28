import 'package:dio/dio.dart';

class ApiService {
  static final dio = Dio();

  // POST (Pass data to create a new resource)
  static Future<Response> post(String url, Map<String, dynamic> body) async {
    final response = await dio.post(url, data: body, options: Options(headers: {
       'Accept': 'application/json',
    }) );
    return response;

  }

  // GET (View or List)
  static Future<Response> get(String url, Map<String, dynamic> params) async {

    final response = await dio.get(url, queryParameters: params, options: Options(headers: {
      'Accept': 'application/json',
    }) );
    return response;

  }

  // PUT (full update)
  static Future<Response> put(String url, Map<String, dynamic> body) async {
    final response = await dio.put(url, data: body, options: Options(headers: {
      'Accept': 'application/json',
    }));
    return response;
  }

  // PATCH (partial update)
  static Future<Response> patch(String url, Map<String, dynamic> body) async {
    final response = await dio.patch(url, data: body, options: Options(headers: {
      'Accept': 'application/json',
    }));
    return response;
  }

  // DELETE (hard delete)
  static Future<Response> delete(String url, {Map<String, dynamic>? body}) async {
    final response = await dio.delete(url, data: body, options: Options(headers: {
      'Accept': 'application/json',
    }));
    return response;
  }
}