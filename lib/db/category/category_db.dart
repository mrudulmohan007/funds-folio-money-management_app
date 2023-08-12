import 'package:funds_folio_money_management_app/models/category/category_model.dart';

abstract class CategoryDbFunctions {
  //List<CategoryModel> getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) {
    // TODO: implement insertCategory
    throw UnimplementedError();
  }
}
