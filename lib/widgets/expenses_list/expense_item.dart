import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge, //im using the style of the titleLarge that i defined in the main.dart file
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 4),
                      Text(
                        expense.formattedDate,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
