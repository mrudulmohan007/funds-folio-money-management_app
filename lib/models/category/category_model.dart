import 'package:hive/hive.dart';

enum CategoryType {
  income,
  expense,
}

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final CategoryType type;

  CategoryModel(
      {required this.name,
      required this.id,
      this.isDeleted = false,
      required this.type});
}
