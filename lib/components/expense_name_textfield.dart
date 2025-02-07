import 'package:flutter/material.dart';

class ExpenseNameTextfield extends StatelessWidget {
  const ExpenseNameTextfield({required this.titleController, super.key});
  final TextEditingController titleController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text("Expense name"),
      ),
    );
  }
}
