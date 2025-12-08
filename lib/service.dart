import 'package:dio/dio.dart';
import 'rest_client.dart';

/// A singleton service that provides a configured REST client.
/// Uses Dio under the hood for networking.
class ApiService {
  /// Private constructor for the singleton pattern.
  ApiService._internal() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    client = RestClient(dio);
  }

  /// The single shared instance of ApiService.
  static final ApiService _instance = ApiService._internal();

  /// Public factory constructor to return the same instance.
  factory ApiService() => _instance;

  /// The REST client used for API calls.
  late final RestClient client;
}
