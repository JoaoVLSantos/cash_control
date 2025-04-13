import 'package:cash_control/data/services/category_service.dart';
import 'package:cash_control/domain/models/category.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _categoryService;
  CategoryViewModel(this._categoryService) {
    loadCategories();
  }

  int _selectedIndex = 1;
  String _errorMessage = '';
  bool _isLoading = false;
  List<Category> _categories = [];

  int get selectedIndex => _selectedIndex;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<Category> get categories => _categories;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _categoryService.findAllCategories();
    } catch (e) {
      _errorMessage = 'Erro ao carregar categorias';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
