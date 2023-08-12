import 'package:hive_flutter/hive_flutter.dart';
import 'package:funds_folio_money_management_app/models/category/category_model.dart';

const categoryModelDb = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryModelDb);
    _categoryDB.add(value);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryModelDb);
    return _categoryDB.values.toList();
  }
}
