//   this file is returnig us the structure of list with which help of which we can show our
// reigteredExpensesList we've created already in [expenses.dart file]

import 'package:expense_tracker/Widgets/expenses_list/expenses_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{

  ExpensesList({super.key, required this.expenses, required this.onremoveExpense});

  final List<Expense> expenses; // expenses is a model list which we'll use to show our made list _registeredExpensesList

  final void Function(Expense expense) onremoveExpense; 
  @override
  Widget build(BuildContext context) {
    return ListView.builder( itemCount: expenses.length,
    itemBuilder: (ctx, index) => Dismissible(
      onDismissed: (direction) {
        onremoveExpense(expenses[index]);
      },
      key: ValueKey(expenses[index]), 
      background: Container(
        color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal,)
        ),
      
    child: ExpensesItem(expenses[index])
    ) );
  }
}