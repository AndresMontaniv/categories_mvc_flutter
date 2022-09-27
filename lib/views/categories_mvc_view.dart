import 'package:flutter/material.dart';
import 'package:mvc_categories/controllers/categories_controller.dart';
import 'package:mvc_categories/helpers/helpers.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryView> createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView> {
  void addCategory() {
    final id = categorias.length + 1;
    final newCategory = Categoria(id: id, name: 'Categoria $id');
    categorias.add(newCategory);
    setState(() {});
  }

  void rebuild() => setState(() {});

  TextEditingController idFieldCtrl = TextEditingController();
  TextEditingController nameFieldCtrl = TextEditingController();
  List<Categoria> categorias = [];

  @override
  void initState() {
    super.initState();
    CategoryController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categorias'),
          centerTitle: true,
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4,
                color: Colors.blue,
              ),
            ),
            tabs: [
              Tab(text: 'Tabla'),
              Tab(text: 'Operaciones'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: DataTable(
                    border: TableBorder.all(),
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('NAME')),
                    ],
                    rows: categorias
                        .map((category) => DataRow(
                              cells: [
                                DataCell(Text('${category.id}')),
                                DataCell(Text(category.name)),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: idFieldCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Id',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: nameFieldCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      child: const Text('Registrar'),
                      onPressed: () {
                        CategoryController.addCategory();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Editar'),
                      onPressed: () {
                        CategoryController.editCategory();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Eliminar'),
                      onPressed: () {
                        CategoryController.deleteCategory();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Listar'),
                      onPressed: () {
                        CategoryController.getAll();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
