import 'package:flutter/material.dart';
import 'package:mvc_categories/controllers/categories_controller.dart';

import 'package:mvc_categories/views/views.dart';

class AppRoutes {
  static const initialRoute = 'categories/mvc';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll(
        {'categories': (BuildContext context) => const CategoriesView()});
    appRoutes.addAll({'home': (BuildContext context) => const HomeView()});
    appRoutes.addAll({
      'categories/mvc': (BuildContext context) => CategoryView(
            key: CategoryController.categoryView,
          )
    });

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertView(),
    );
  }
}
