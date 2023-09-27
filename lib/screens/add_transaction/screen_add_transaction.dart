import 'package:flutter/material.dart';
import 'package:funds_folio_money_management_app/db/category/category_db.dart';
import 'package:funds_folio_money_management_app/db/transactions/transaction_db.dart';
import 'package:funds_folio_money_management_app/models/category/category_model.dart';
import 'package:funds_folio_money_management_app/models/transaction/transaction_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({super.key});

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  final _purposeEditingTextController = TextEditingController();
  final _amountEditingTextController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  //purpose,date,amount,Income/expense,CategoryType etc are needed here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //purpose
          children: [
            TextFormField(
              controller: _purposeEditingTextController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Purpose',
              ),
            ),
            //amount
            TextFormField(
              controller: _amountEditingTextController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
            ),

            //calender
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDateTemp.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toString(),
              ),
            ),

            //category
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.income;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.expense;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text('Expense'),
                  ],
                ),
              ],
            ),
            //categoryType
            DropdownButton<String>(
              hint: const Text('Select Category'),
              value: _categoryID,
              items: (_selectedCategorytype == CategoryType.income
                      ? CategoryDB.instance.incomeCategoryListListener
                      : CategoryDB.instance.expenseCategoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedCategoryModel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
                setState(() {
                  _categoryID = selectedValue;
                });
              },
              onTap: () {},
            ),

            //submit button

            ElevatedButton.icon(
              onPressed: () {
                addTransaction();
                // this pop works only here
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.check),
              label: Text('Submit'),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    var _purposeText = _purposeEditingTextController.text.trim();
    final _amountText = _amountEditingTextController.text.trim();
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
    );

    TransactionDB.instance.addTransaction(_model);
    TransactionDB.instance.refresh();
  }
}
