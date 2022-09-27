import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvc_categories/helpers/helpers.dart';
import 'package:mvc_categories/models/models.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<OnGetAllCategoriesEvent>(_onGetAllCategories);
    on<OnAddCategoryEvent>(_onAddCategory);
    on<OnEditCategoryEvent>(_onEditCategory);
    on<OnDeleteCategoryEvent>(_onDeleteCategory);

    _init();
  }

  void _init() async {
    add(const OnGetAllCategoriesEvent());
  }

  void _onGetAllCategories(
      OnGetAllCategoriesEvent event, Emitter<CategoryState> emit) async {
    final categorias = await CategoryModel.getAllCategories();
    emit(state.copyWith(categories: categorias));
  }

  void _onAddCategory(
      OnAddCategoryEvent event, Emitter<CategoryState> emit) async {
    await CategoryModel.createCategory(name: event.name);
    final categorias = await CategoryModel.getAllCategories();
    emit(state.copyWith(categories: categorias));
  }

  void _onEditCategory(
      OnEditCategoryEvent event, Emitter<CategoryState> emit) async {
    await CategoryModel.editCategory(id: event.id, name: event.name);
    final categorias = await CategoryModel.getAllCategories();
    emit(state.copyWith(categories: categorias));
  }

  void _onDeleteCategory(
      OnDeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    await CategoryModel.deleteCategory(id: event.id);
    final categorias = await CategoryModel.getAllCategories();
    emit(state.copyWith(categories: categorias));
  }
}
