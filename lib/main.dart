import 'package:flutter/material.dart';
import 'package:funds_folio_money_management_app/models/category/category_model.dart';
import 'package:funds_folio_money_management_app/models/transaction/transaction_model.dart';
import 'package:funds_folio_money_management_app/screens/add_transaction/screen_add_transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:funds_folio_money_management_app/screens/home/screen_home.dart';

import 'db/category/category_db.dart';
import 'db/transactions/transaction_db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
  await Hive.openBox<CategoryModel>(categoryModelDb);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName: (ctx) => const ScreenaddTransaction(),
      },
    );
  }
}
