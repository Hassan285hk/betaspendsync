// data/dummy_data.dart
// Local dummy data for SpendSync Lite — compatible with Firebase Expense model

import '../models/expense_model.dart';

/// Returns a fresh list of dummy expenses for testing
List<Expense> getDummyExpenses() {
  final now = DateTime.now();

  return [
    Expense(
      id: '1',
      title: 'KFC Dinner',
      amount: 1200,
      category: 'Food',
      date: now.subtract(const Duration(days: 0)),
    ),
    Expense(
      id: '2',
      title: 'Uber Ride',
      amount: 350,
      category: 'Transport',
      date: now.subtract(const Duration(days: 1)),
    ),
    Expense(
      id: '3',
      title: 'Electricity Bill',
      amount: 3500,
      category: 'Bills',
      date: now.subtract(const Duration(days: 2)),
    ),
    Expense(
      id: '4',
      title: 'Zara Shopping',
      amount: 4500,
      category: 'Shopping',
      date: now.subtract(const Duration(days: 3)),
    ),
    Expense(
      id: '5',
      title: 'Netflix Subscription',
      amount: 1000,
      category: 'Entertainment',
      date: now.subtract(const Duration(days: 4)),
    ),
    Expense(
      id: '6',
      title: 'McDonald\'s Lunch',
      amount: 800,
      category: 'Food',
      date: now.subtract(const Duration(days: 5)),
    ),
    Expense(
      id: '7',
      title: 'Daewoo Bus Ticket',
      amount: 1500,
      category: 'Transport',
      date: now.subtract(const Duration(days: 6)),
    ),
    Expense(
      id: '8',
      title: 'Internet Bill',
      amount: 2200,
      category: 'Bills',
      date: now.subtract(const Duration(days: 7)),
    ),
    Expense(
      id: '9',
      title: 'Centaurus Mall',
      amount: 6000,
      category: 'Shopping',
      date: now.subtract(const Duration(days: 8)),
    ),
    Expense(
      id: '10',
      title: 'Cinema Ticket',
      amount: 1200,
      category: 'Entertainment',
      date: now.subtract(const Duration(days: 9)),
    ),
    Expense(
      id: '11',
      title: 'Grocery - Carrefour',
      amount: 2800,
      category: 'Food',
      date: now.subtract(const Duration(days: 10)),
    ),
    Expense(
      id: '12',
      title: 'Fuel Refill',
      amount: 5000,
      category: 'Transport',
      date: now.subtract(const Duration(days: 11)),
    ),
    Expense(
      id: '13',
      title: 'Misc Expense',
      amount: 500,
      category: 'Others',
      date: now.subtract(const Duration(days: 12)),
    ),
  ];
}

/// Dummy user info
const Map<String, String> dummyUser = {
  'name': 'Ali Hassan',
  'email': 'ali.hassan@example.com',
};

/// Default monthly budget
const double defaultMonthlyBudget = 25000;
