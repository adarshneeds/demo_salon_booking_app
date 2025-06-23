import 'package:demo_app/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField({required this.onDateSelected, super.key});
  final Function(DateTime) onDateSelected;

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        final selectedDate = provider.selectedDate;
        final dateText = selectedDate != null ? DateFormat('dd MMM yyyy').format(selectedDate) : 'Select Date';
        return TextField(
          controller: TextEditingController(text: dateText),
          readOnly: true,
          decoration: InputDecoration(hintText: 'Select Date', suffixIcon: Icon(Icons.calendar_today)),
          onTap: () => _selectDate(context),
        );
      },
    );
  }
}
