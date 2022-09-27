import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_categories/blocs/blocs.dart';
import 'package:mvc_categories/helpers/show_popup_helper.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Categorias'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.refresh_outlined,
                ),
                onPressed: () {
                  categoryBloc.add(const OnGetAllCategoriesEvent());
                },
              )
            ],
          ),
          body: Center(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('NAME')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: state.categories
                  .map((category) => DataRow(
                        cells: [
                          DataCell(Text('${category.id}')),
                          DataCell(Text(category.name)),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  constraints: const BoxConstraints(
                                    maxWidth: 35,
                                  ),
                                  icon: const Icon(Icons.edit),
                                  splashRadius: 15,
                                  onPressed: () async {
                                    final name = await showEditActionDialog(
                                      context: context,
                                      value: category.name,
                                    );
                                    if (name == null) return;
                                    categoryBloc.add(OnEditCategoryEvent(
                                      id: category.id,
                                      name: name,
                                    ));
                                  },
                                ),
                                IconButton(
                                  constraints: const BoxConstraints(
                                    maxWidth: 35,
                                  ),
                                  icon: const Icon(Icons.delete),
                                  splashRadius: 15,
                                  onPressed: () {
                                    categoryBloc.add(
                                      OnDeleteCategoryEvent(id: category.id),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final name = await showEditActionDialog(context: context);
              if (name == null) return;
              categoryBloc.add(
                OnAddCategoryEvent(name: name),
              );
            },
          ),
        );
      },
    );
  }
}
