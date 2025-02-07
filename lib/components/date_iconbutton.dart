import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class DateIconbutton extends StatelessWidget {
  const DateIconbutton(
      {required this.presentDatePicker, required this.selectedDate, super.key});
  final DateTime? selectedDate;
  final void Function() presentDatePicker;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          // ignore: unnecessary_null_comparison
          selectedDate == null
              ? "No selected Date"
              : formatter.format(selectedDate!),
        ),
        IconButton(
            onPressed: () {
              presentDatePicker();
            },
            icon: const Icon(Icons.calendar_month))
      ],
    );
  }
}
