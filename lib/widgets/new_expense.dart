import 'package:expense_tracker/components/date_iconbutton.dart';
import 'package:expense_tracker/components/expense_amount_textfield.dart';
import 'package:expense_tracker/components/expense_name_textfield.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
//we will use the intl formatter so we can format our date
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final invalidAmount = (enteredAmount == null || enteredAmount <= 0);
    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please make sure the entered Title, Date, Amount and Category are valid"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"))
          ],
        ),
      );
      return;
    } else {
      widget.onAddExpense(
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory!),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final double width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  //First row if landscape
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: ExpenseNameTextfield(
                                titleController: _titleController)),
                        const SizedBox(width: 20),
                        Expanded(
                            child: ExpenseAmountTextfield(
                                amountController: _amountController))
                      ],
                    )
                  else
                    //first row if portrait
                    ExpenseNameTextfield(titleController: _titleController),
                  //Second row if landscape
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          hint: const Text("Select Category "),
                          icon: const Icon(Icons.category),
                          value: _selectedCategory,
                          //Tranferring the Category enum values to a list of DropdownMenuItem variables,
                          // by using .map to iterate among each category i have in the enum Category,
                          //and then transferring it to a list at the end. -> .toList()
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value:
                                      category, //this is important, onChanged uses it!
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: Theme.of(context)
                                        .dropdownMenuTheme
                                        .textStyle,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            //if no item is choosen, then dont do anything.
                            if (value == null) {
                              return;
                            }
                            //if an item has been selected, then assign it.
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        Expanded(
                          //this is a row, so a row inside the upper row, will need expanded
                          child: DateIconbutton(
                              presentDatePicker: _presentDatePicker,
                              selectedDate: _selectedDate),
                        ),
                      ],
                    )
                  //Second row if portrait
                  else
                    Row(
                      children: [
                        Expanded(
                            child: ExpenseAmountTextfield(
                                amountController: _amountController)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DateIconbutton(
                            presentDatePicker: _presentDatePicker,
                            selectedDate: _selectedDate,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  //Third row if landscape
                  if (width >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(103, 244, 67, 54),
                          ),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                            onPressed: _submitData,
                            child: const Text("Save Expense")),
                      ],
                    )
                  //Third row if portrait
                  else
                    Row(
                      children: [
                        DropdownButton(
                          hint: const Text("Select Category "),
                          icon: const Icon(Icons.category),
                          value: _selectedCategory,
                          //Tranferring the Category enum values to a list of DropdownMenuItem variables,
                          // by using .map to iterate among each category i have in the enum Category,
                          //and then transferring it to a list at the end. -> .toList()
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value:
                                      category, //this is important, onChanged uses it!
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: Theme.of(context)
                                        .dropdownMenuTheme
                                        .textStyle,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            //if no item is choosen, then dont do anything.
                            if (value == null) {
                              return;
                            }
                            //if an item has been selected, then assign it.
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(103, 244, 67, 54),
                          ),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 6),
                        ElevatedButton(
                            onPressed: _submitData,
                            child: const Text("Save Expense"))
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
