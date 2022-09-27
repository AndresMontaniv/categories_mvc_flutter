import 'package:flutter/material.dart';
import 'package:mvc_categories/helpers/helpers.dart';
import 'package:mvc_categories/models/models.dart';
import 'package:mvc_categories/views/categories_mvc_view.dart';

class CategoryController {
  static GlobalKey<CategoryViewState> categoryView =
      GlobalKey<CategoryViewState>();

  static void getAll() async {
    final view = categoryView.currentState;
    if (view == null) return;

    final list = await CategoryModel.getAllCategories();
    view.categorias = list;
    view.rebuild();
  }

  static void addCategory() async {
    final view = categoryView.currentState;
    if (view == null) return;
    final name = view.nameFieldCtrl.text.trim();
    if (name.isEmpty) return;
    final newCategory = await CategoryModel.createCategory(name: name);
    if (newCategory == null) return;
    view.categorias.add(newCategory);
    view.rebuild();
  }

  static void editCategory() async {
    final view = categoryView.currentState;
    if (view == null) return;
    final id = int.tryParse(view.idFieldCtrl.text.trim());
    final name = view.nameFieldCtrl.text.trim();
    if (id == null || name.isEmpty) return;
    final edited = await CategoryModel.editCategory(id: id, name: name);
    if (edited) {
      getAll();
    }
  }

  static void deleteCategory() async {
    final view = categoryView.currentState;
    if (view == null) return;
    final id = int.tryParse(view.idFieldCtrl.text.trim());
    if (id == null) return;
    final deleted = await CategoryModel.deleteCategory(id: id);
    if (deleted) {
      getAll();
    }
  }
}
