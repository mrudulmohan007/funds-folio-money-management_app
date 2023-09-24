import 'package:flutter/material.dart ';
import 'package:funds_folio_money_management_app/db/transactions/transaction_db.dart';

import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) {
            final _value = newList[index];
            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    parseDate(_value.date),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: _value.type == CategoryType.income
                      ? Colors.green
                      : Colors.red,
                ),
                title: Text('RS ${_value.amount}'),
                subtitle: Text(_value.category.name),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    return '${date.day}\n${date.month}';
  }
}
