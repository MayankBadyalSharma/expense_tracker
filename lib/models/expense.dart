// We've created a model class of all required fields which further will be used


import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // used to get the formatted date
// uuid is a variable which is having Uuid() method inside it

final formatter = DateFormat.yMd(); // will format the date into years/months/days and store it in formatter variable

const uuid = Uuid(); // we added uuid dependency inside our project to access this class

enum Category {food, travel , leisure, work } // only these categories will be available on UI Screen then

const categoryIcons = {
Category.food :Icons.lunch_dining,
Category.travel : Icons.flight_takeoff,
Category.leisure : Icons.movie ,
Category.work : Icons.work,

};

class Expense {
Expense({required this.title,
required this.amount,
required this.date,
required this.category,
}) :id = uuid.v4(); // v4 is method of uuid which takes string values as input



final String id;
final String title;
final double amount;
final DateTime date;
final Category category;

// this functoin will return the formated date
String get formattedDate{
  return formatter.format(date);
}
}

class ExpenseBucket{

  const ExpenseBucket({
    required this.category,
    required this.expenses,

  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;

  }
}