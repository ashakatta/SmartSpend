import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [];

  bool _isLoading = true;
  String? _errorMessage;

  List<Expense> get expenses => List.unmodifiable(_expenses);

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> loadExpenses() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedData = prefs.getString('expenses');

      if (savedData != null) {
        final List<dynamic> decodedData = jsonDecode(savedData);

        final loadedExpenses = decodedData.map((item) {
          return Expense(
            id: item['id'],
            title: item['title'],
            amount: (item['amount'] as num).toDouble(),
            category: item['category'],
            date: DateTime.parse(item['date']),
            note: item['note'] ?? '',
          );
        }).toList();

        _expenses
          ..clear()
          ..addAll(loadedExpenses);
      }
    } catch (e) {
      _errorMessage =
      'Unable to load expenses. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    final String encodedData = jsonEncode(
      _expenses.map((expense) {
        return {
          'id': expense.id,
          'title': expense.title,
          'amount': expense.amount,
          'category': expense.category,
          'date': expense.date.toIso8601String(),
          'note': expense.note,
        };
      }).toList(),
    );

    await prefs.setString('expenses', encodedData);
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await saveExpenses();
    notifyListeners();
  }

  Future<void> deleteExpense(String id) async {
    _expenses.removeWhere((expense) => expense.id == id);
    await saveExpenses();
    notifyListeners();
  }

  Future<void> updateExpense(Expense updatedExpense) async {
    final index = _expenses.indexWhere(
          (expense) => expense.id == updatedExpense.id,
    );

    if (index != -1) {
      _expenses[index] = updatedExpense;
      await saveExpenses();
      notifyListeners();
    }
  }

  double get totalExpenses {
    double total = 0;

    for (var expense in _expenses) {
      total += expense.amount;
    }

    return total;
  }

  double categoryTotal(String category) {
    double total = 0;

    for (var expense in _expenses) {
      if (expense.category == category) {
        total += expense.amount;
      }
    }

    return total;
  }
}