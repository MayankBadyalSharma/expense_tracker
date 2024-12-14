// this is the landing screen of the application

import 'package:expense_tracker/Widgets/charts/chart.dart';
import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}
class _ExpensesState extends State<Expenses>{
 final List<Expense> _registeredExpenses = [
  Expense(title: "Udemy Course", amount: 499.99, date: DateTime.now(), category: Category.work),
  Expense(title: "Theatre", amount: 399.99, date: DateTime.now(), category: Category.leisure)

 ];


 void _openAddExpenseOverlay(){
  showModalBottomSheet(
    useSafeArea: true, // to stay away from device taskbar in case of modalbottomsheet[As it is automatically true in case of Widgets]
    isScrollControlled: true,
    context: context,
   builder: (ctx) =>  
   NewExpense(onAddExpense: _addExpense,),
  );
 }

 void _addExpense(Expense expense){
setState(() {
  _registeredExpenses.add(expense);
});
 }

 void _removeExpense(Expense expense){
  final expenseIndex = _registeredExpenses.indexOf(expense);
  setState(() {
    _registeredExpenses.remove(expense);
  });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
           onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
           }),

        ));
 }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // it will get the width of the device [mediaquery]
    Widget mainContent = const Center(child: Text('No Expense Found!, Please Add some'),);

    if(_registeredExpenses.isNotEmpty){
       mainContent =  ExpensesList(expenses: _registeredExpenses, onremoveExpense: _removeExpense,);
    }
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker App'),
        actions: [
          
          IconButton(onPressed: _openAddExpenseOverlay, // it will open the showmodalbottomsheet
          icon: Icon(Icons.add),)
        ],
      ),
      body:  width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child : mainContent, // expenses: here is coming from expenses_list.dart file
          ),
        ],
      ): Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses), ),
        ],
      )
    );
  }
}