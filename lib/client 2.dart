// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,
// no_leading_underscores_for_local_identifiers,
// unused_element, unnecessary_string_interpolations,
// unused_element_parameter

/// Auto-generated implementation of the [RestClient].
/// This file is created by Retrofit and should not be edited manually.
class _RestClient implements RestClient {
  /// Creates an instance of [_RestClient] with optional [baseUrl] and [errorLogger].
  _RestClient(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://jsonplaceholder.typicode.com';
  }

  final Dio _dio;

  /// Optional custom base URL. Defaults to 'https://jsonplaceholder.typicode.com'.
  String? baseUrl;

  /// Optional error logger for network requests.
  final ParseErrorLogger? errorLogger;

  /// Fetches a single [Profile] from `/posts/1`.
  @override
  Future<Profile> getProfile() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{}
