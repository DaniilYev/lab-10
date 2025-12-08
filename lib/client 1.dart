import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'profile_model.dart';

part 'rest_client.g.dart';

/// A Retrofit API client used to interact with the backend service.
/// Provides typed networking using Dio under the hood.
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com')
abstract class RestClient {
  /// Factory constructor that generates the implementation in `rest_client.g.dart`.
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// Fetches a sample profile object from the server.
  /// The endpoint returns `/posts/1` from jsonplaceholder.
  @GET('/posts/1')
  Future<Profile> getProfile();
}
