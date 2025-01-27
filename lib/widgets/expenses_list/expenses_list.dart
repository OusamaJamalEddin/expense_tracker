import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final void Function(Expense expense) onRemoveExpense;
  //expenses = _registeredExpenses in expenses.dart

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    /*Just like column, but with the help of .builder, this will create the 
    widgets only when they are needed, not heavy on the memory or the speed
    so better perforamnce */
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          margin: EdgeInsets.symmetric(
              //flutter thinks that the value might be null thats why it gives an error without the ! mark, by using the excalamition mark, we are forcing it to accept it and ignore that thinking
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          decoration: const BoxDecoration(
            // the color must be here if im going to define a decoration, if not, it should be along side the margin part above
            color: Color.fromARGB(186, 238, 101, 91),
            //making the borders ciruclar
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
