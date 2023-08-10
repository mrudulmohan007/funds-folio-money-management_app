import 'package:flutter/material.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Transactions',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
    ]);
  }
}
