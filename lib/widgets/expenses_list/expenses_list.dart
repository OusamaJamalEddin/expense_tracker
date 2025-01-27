import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});
  //expenses = _registeredExpenses in expenses.dart

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    /*Just like column, but with the help of .builder, this will create the 
    widgets only when they are needed, not heavy on the memory or the speed
    so better perforamnce */
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => ExpenseItem(expense: expenses[index]));
  }
}
