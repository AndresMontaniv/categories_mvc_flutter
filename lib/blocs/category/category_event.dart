part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllCategoriesEvent extends CategoryEvent {
  const OnGetAllCategoriesEvent();
}

class OnAddCategoryEvent extends CategoryEvent {
  final String name;
  const OnAddCategoryEvent({required this.name});
}

class OnEditCategoryEvent extends CategoryEvent {
  final int id;
  final String name;
  const OnEditCategoryEvent({
    required this.id,
    required this.name,
  });
}

class OnDeleteCategoryEvent extends CategoryEvent {
  final int id;
  const OnDeleteCategoryEvent({required this.id});
}
