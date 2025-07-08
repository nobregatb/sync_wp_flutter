import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tag.dart';

class WordPressService {
  // Substitua pela URL do seu site WordPress
  static const String baseUrl = 'https://www.casabn.com.br/wp-json/wp/v2';
  static const String getTagsUrl = 'https://www.casabn.com.br/wp-json/get/v1/my_tags/';
  
  // Se precisar de autenticação, adicione suas credenciais aqui
  static const String username = 'user';
  static const String password = 'h34UtneEQgEsSbXNlK89O1DB';

  static String get basicAuth {
    String credentials = '$username:$password';
    String encoded = base64Encode(utf8.encode(credentials));
    return 'Basic $encoded';
  }

  static Future<List<Tag>> fetchTags() async {
    try {
      final response = await http.get(
        Uri.parse('$getTagsUrl'),
        headers: {
          'Content-Type': 'application/json',
          // Descomente se precisar de autenticação
          // 'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);        
        return jsonData.map((json) => Tag.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar tags: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  static Future<Tag> createTag(Tag tag) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bill_tag'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth, // Necessário para criar/editar
        },
        body: json.encode({
          'tag_name': tag.tagName,
          'tag_icon': tag.tagIcon,
          'tag_color': tag.tagColor,
        }),
      );

      if (response.statusCode == 201) {
        return Tag.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao criar tag: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao criar tag: $e');
    }
  }

  static Future<Tag> updateTag(Tag tag) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/bill_tag/${tag.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth, // Necessário para criar/editar
        },
        body: json.encode({
          'tag_name': tag.tagName,
          'tag_icon': tag.tagIcon,
          'tag_color': tag.tagColor,
        }),
      );

      if (response.statusCode == 200) {
        return Tag.fromJson(json.decode(response.body));
      } else {
        throw Exception('Falha ao atualizar tag: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar tag: $e');
    }
  }

  static Future<bool> deleteTag(int tagId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/bill_tag/$tagId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth, // Necessário para deletar
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Erro ao deletar tag: $e');
    }
  }
}