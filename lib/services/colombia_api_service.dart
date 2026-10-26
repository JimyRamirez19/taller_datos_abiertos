
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ColombiaApiService {
  ColombiaApiService({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  String get _baseUrl {
    final value = dotenv.env['API_BASE_URL'];

    if (value == null || value.isEmpty) {
      throw Exception('No se encontró API_BASE_URL en el archivo .env');
    }

    return value;
  }

  Future<List<Map<String, dynamic>>> getList(String category) async {
    final uri = Uri.parse('$_baseUrl/$category');

    final response = await _client
        .get(uri)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
        'Error al consultar $category. Código HTTP: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));

    if (decoded is! List) {
      throw const FormatException('La API no devolvió una lista válida.');
    }

    return decoded.whereType<Map<String, dynamic>>().toList();
  }

  Future<Map<String, dynamic>> getDetail(
    String category,
    String id,
  ) async {
    final uri = Uri.parse('$_baseUrl/$category/$id');

    final response = await _client
        .get(uri)
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw Exception(
        'Error al consultar el detalle. Código HTTP: ${response.statusCode}',
      );
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('La API no devolvió un detalle válido.');
    }

    return decoded;
  }

  void dispose() {
    _client.close();
  }
}
