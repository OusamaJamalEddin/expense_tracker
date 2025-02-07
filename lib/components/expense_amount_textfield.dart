import 'package:flutter/material.dart';

class ExpenseAmountTextfield extends StatelessWidget {
  const ExpenseAmountTextfield({required this.amountController, super.key});
  final TextEditingController amountController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: "\$ ",
        label: Text("Amount"),
      ),
    );
  }
}
