import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // Global app state
  int _selectedIndex = 0;
  
  int get selectedIndex => _selectedIndex;
  
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  
  // App-wide settings
  bool _darkMode = false;
  bool get darkMode => _darkMode;
  
  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
  
  // Cost tracking
  double _totalCost = 0.0;
  double get totalCost => _totalCost;
  
  void addCost(double cost) {
    _totalCost += cost;
    notifyListeners();
  }
  
  void resetCost() {
    _totalCost = 0.0;
    notifyListeners();
  }
}