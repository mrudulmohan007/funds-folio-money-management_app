import 'package:flutter/material.dart';
import 'package:funds_folio_money_management_app/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.selectedIndexNotifier,
        builder: (BuildContext ctx, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 206, 234, 196),
            selectedItemColor: Colors.black,
            iconSize: 30,
            unselectedItemColor: Colors.grey,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Categories'),
            ],
          );
        });
  }
}
