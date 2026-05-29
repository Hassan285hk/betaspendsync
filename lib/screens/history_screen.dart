// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../state/app_state.dart';
import '../utils/colors.dart';
import '../widgets/expense_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final expenses = state.expenses;
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),
      body: expenses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.surfaceLight.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.history_toggle_off_rounded,
                      size: 40,
                      color: AppColors.textLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No transaction records',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 120), // Padding for floating bottom nav
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                // Reverse to show newest transactions first
                final expense = expenses[expenses.length - 1 - index];

                return ExpenseCard(
                  expense: expense,
                  onDelete: () => state.deleteExpense(uid, expense.id),
                );
              },
            ),
    );
  }
}
