import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ebuck_item.dart';
import '../utils/constants.dart';

class ApiService {
  static Future<List<EBuckItem>> fetchItems() async {
    final res = await http.get(Uri.parse(Constants.apiBase));
    if (res.statusCode == 200) {
      final List data = json.decode(res.body) as List;
      return data.take(20).map((e) => EBuckItem.fromJson(e)).toList();
    } else {
      throw Exception('Falha ao buscar dados: ${res.statusCode}');
    }
  }
}

