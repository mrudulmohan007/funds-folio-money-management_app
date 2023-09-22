import 'package:flutter/material.dart%20';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:funds_folio_money_management_app/models/category/category_model.dart';

const categoryModelDb = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryModelDb);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryModelDb);
    return _categoryDB.values.toList();
  }

  //future function to refresh ui
  Future<void> refreshUI() async {
    //getting all categories which includes income and expense
    final _allCategories = await getCategories();

    //to avoid duplication
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();

    //splitting income and expense categories
    await Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(categoryModelDb);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
}
