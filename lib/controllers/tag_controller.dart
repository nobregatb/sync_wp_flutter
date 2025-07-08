import 'package:flutter/foundation.dart';
import '../models/tag.dart';
import '../services/wordpress_service.dart';

class TagController extends ChangeNotifier {
  List<Tag> _tags = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Tag> get tags => _tags;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Carregar tags do WordPress ao iniciar a aplicação
  Future<void> loadTags() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _tags = await WordPressService.fetchTags();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      _tags = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Adicionar nova tag
  Future<void> addTag(String name, String tagIcon, String tagColor) async {
    try {
      Tag newTag = Tag(
        id: 0, // Será definido pelo WordPress
        tagName: name,
        tagIcon: tagIcon,
        tagColor: tagColor,
        count: 0,
      );

      Tag createdTag = await WordPressService.createTag(newTag);
      _tags.add(createdTag);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Atualizar tag existente
  Future<void> updateTag(Tag tag) async {
    try {
      Tag updatedTag = await WordPressService.updateTag(tag);
      
      int index = _tags.indexWhere((t) => t.id == tag.id);
      if (index != -1) {
        _tags[index] = updatedTag;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Deletar tag
  Future<void> deleteTag(int tagId) async {
    try {
      bool success = await WordPressService.deleteTag(tagId);
      if (success) {
        _tags.removeWhere((tag) => tag.id == tagId);
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Limpar mensagem de erro
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}