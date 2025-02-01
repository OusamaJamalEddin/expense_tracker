import 'package:flutter/material.dart';
// OUR (DATASTRUCTURE) ? THAT WILL HOLD THE EXPENSE VARIABLES)

//For formatting dates
import 'package:intl/intl.dart';

//We will use uuid package here to dynamically have our IDs created
import 'package:uuid/uuid.dart';

const uuid = Uuid();

//just like machine learning models, we will use the formatter bellow as a model to acheive what we want
final formatter = DateFormat.yMd();

//fixed allowed values for our category, why not string and call it a day ?
// because if an invalid string was passed, no error will occure and no result
//will be returned, so fixed allowed to choose between them is the correct way
enum Category { food, travel, leisure, work } //custom type category

//i can either do this here, or just as i did in new_expense.dart file in the DropDownMenuButton
//and then i just use dropDownMenulist variable as (items variable in the button)
// final List<DropdownMenuItem> dropDownMenulist = Category.values
//     .map(
//       (category) => DropdownMenuItem(
//         value: category,
//         child: Text(
//           category.name.toUpperCase(),
//         ),
//       ),
//     )
//     .toList();

final categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //initializing  id

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
