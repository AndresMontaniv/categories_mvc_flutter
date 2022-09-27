import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_categories/blocs/blocs.dart';
import 'package:mvc_categories/helpers/show_popup_helper.dart';
import 'package:mvc_categories/views/views.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryBloc = BlocProvider.of<CategoryBloc>(context);

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
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return CategoriasTable(
            categorias: state.categories,
          );
        },
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
  }
}
