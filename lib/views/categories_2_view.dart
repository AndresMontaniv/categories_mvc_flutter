import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_categories/blocs/blocs.dart';
import 'package:mvc_categories/helpers/category_parser.dart';
import 'package:mvc_categories/helpers/show_popup_helper.dart';

class CategoriasTable extends StatelessWidget {
  final List<Categoria> categorias;
  const CategoriasTable({
    Key? key,
    required this.categorias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);
    return Center(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('NAME')),
          DataColumn(label: Text('ACTIONS')),
        ],
        rows: categorias
            .map(
              (category) => DataRow(
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
              ),
            )
            .toList(),
      ),
    );
  }
}
