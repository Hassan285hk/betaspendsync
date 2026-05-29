// lib/state/app_state.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense_model.dart';

class AppState extends ChangeNotifier {
  String _userName = "User";
  String _userEmail = "No email";
  double _monthlyBudget = 50000;

  List<Expense> _expenses = [];

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  double get monthlyBudget => _monthlyBudget;
  List<Expense> get expenses => _expenses;

  double get totalExpensesThisMonth {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.date.month == now.month && e.date.year == now.year)
        .fold(0, (sum, e) => sum + e.amount);
  }

  double get remainingBudget => _monthlyBudget - totalExpensesThisMonth;

  Map<String, double> get categoryTotals {
    final Map<String, double> totals = {};
    for (final e in _expenses) {
      totals[e.category] = (totals[e.category] ?? 0) + e.amount;
    }
    return totals;
  }

  // Load user profile from Firestore
  Future<void> loadUserData(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      _userName = data['name'] ?? 'User';
      _userEmail = data['email'] ?? 'No email';
      _monthlyBudget = (data['monthlyBudget'] ?? 50000).toDouble();
      notifyListeners();
    }
  }

  // Load all expenses for this user
  Future<void> loadExpenses(String uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .get();

    _expenses = snapshot.docs.map((doc) {
      final data = doc.data();
      return Expense(
        id: doc.id,
        title: data['title'] ?? '',
        category: data['category'] ?? '',
        note: data['note'] ?? '',
        amount: (data['amount'] ?? 0).toDouble(),
        date: (data['date'] as Timestamp).toDate(),
      );
    }).toList();

    notifyListeners();
  }

  // Add expense to AppState and Firestore
  Future<void> addExpense(String uid, Expense expense) async {
    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .add({
          'title': expense.title,
          'category': expense.category,
          'note': expense.note,
          'amount': expense.amount,
          'date': Timestamp.fromDate(expense.date),
        });

    _expenses.add(expense.copyWith(id: docRef.id));
    notifyListeners();
  }

  // Delete expense from AppState and Firestore
  Future<void> deleteExpense(String uid, String expenseId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .doc(expenseId)
        .delete();

    _expenses.removeWhere((e) => e.id == expenseId);
    notifyListeners();
  }

  // Update monthly budget
  Future<void> updateBudget(String uid, double budget) async {
    _monthlyBudget = budget;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'monthlyBudget': budget,
    });
    notifyListeners();
  }

  // Update user profile
  Future<void> updateProfile(String uid, String name, String email) async {
    _userName = name;
    _userEmail = email;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
      'email': email,
    });

    notifyListeners();
  }
}
