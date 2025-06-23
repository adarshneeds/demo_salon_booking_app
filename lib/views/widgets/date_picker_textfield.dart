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

    if (pickedDate != null && context.mounted) {
      TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
        final dateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        widget.onDateSelected(dateTime);
        if (context.mounted) context.read<HomeProvider>().setSelectedDate(dateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        final selectedDate = provider.selectedDate;
        final dateText = selectedDate != null
            ? DateFormat('dd MMM yyyy, hh:mm a').format(selectedDate)
            : 'Select Date & Time';

        return TextField(
          controller: TextEditingController(text: dateText),
          readOnly: true,
          decoration: const InputDecoration(hintText: 'Select Date & Time', suffixIcon: Icon(Icons.calendar_today)),
          onTap: () => _selectDate(context),
        );
      },
    );
  }
}
