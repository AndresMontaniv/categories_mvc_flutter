part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<Categoria> categories;
  const CategoryState({this.categories = const []});

  CategoryState copyWith({
    List<Categoria>? categories,
  }) =>
      CategoryState(categories: categories ?? this.categories);

  @override
  List<Object> get props => [
        categories,
      ];
}
