import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String _serviceType = 'select';
  DateTime? _selectedDate;

  String get serviceType => _serviceType;
  DateTime? get selectedDate => _selectedDate;

  void setServiceType(String service) {
    _serviceType = service;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void reset() {
    _serviceType = 'select';
    _selectedDate = null;
    notifyListeners();
  }
}
