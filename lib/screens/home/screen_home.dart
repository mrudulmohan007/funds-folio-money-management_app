import 'package:flutter/material.dart ';
import 'package:funds_folio_money_management_app/screens/home/widgets/bottom_navigation.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: Text('Home'),
      ),
    );
  }
}
