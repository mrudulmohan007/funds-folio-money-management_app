import 'package:flutter/material.dart ';
import 'package:funds_folio_money_management_app/screens/add_transaction/screen_add_transaction.dart';
import 'package:funds_folio_money_management_app/screens/category/category_add_popup.dart';
import 'package:funds_folio_money_management_app/screens/category/screen_category.dart';
import 'package:funds_folio_money_management_app/screens/home/widgets/bottom_navigation.dart';
import 'package:funds_folio_money_management_app/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 111, 218, 166),
      appBar: AppBar(
        title: const Text(
          'FUNDSFOLIO',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 206, 234, 196),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (Buildcontext, updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
            print('Add Category');
            ShowCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
