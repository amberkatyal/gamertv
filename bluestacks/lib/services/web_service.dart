import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart';

import 'network_exceptions.dart';

enum HTTPMethod { GET, POST }

abstract class WebService {
  // factory Service._() => null;

  static const String _baseURL =
      'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/';

  final Client _client = Client();

  Future<Response> request(HTTPMethod httpMethod, String route,
      {Map<String, Object> params}) async {
    switch (httpMethod) {
      case HTTPMethod.GET:
        return _client.get('$_baseURL/$route');
      case HTTPMethod.POST:
        return _client.post('$_baseURL/$route',
            headers: {"Content-Type": "application/json"},
            body: json.encode(params));
      default:
        return throw RequestTypeNotFoundException(
            'The HTTP request mentioned is not found');
    }
  }
}
