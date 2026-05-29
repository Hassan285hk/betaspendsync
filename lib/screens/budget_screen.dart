// lib/screens/budget_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_button.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _budgetController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = false;

  Future<void> _updateBudget(String uid, AppState state) async {
    final valueText = _budgetController.text.trim();
    final double? amount = double.tryParse(valueText);
    
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid budget amount')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await state.updateBudget(uid, amount);
      setState(() {
        _isEditing = false;
        _budgetController.clear();
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Budget limit updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update budget: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? '';

    // Calculate budget utilization details
    double percentageUsed = 0.0;
    if (state.monthlyBudget > 0) {
      percentageUsed = (state.totalExpensesThisMonth / state.monthlyBudget);
    }
    final int percentInt = (percentageUsed * 100).clamp(0, 100).toInt();

    // Visual indicators
    Color statusColor = AppColors.success;
    String statusText = "You're within your spending limit.";
    if (percentageUsed >= 1.0) {
      statusColor = AppColors.error;
      statusText = "Overbudget! Try to limit further expenses.";
    } else if (percentageUsed >= 0.8) {
      statusColor = AppColors.warning;
      statusText = "Warning: 80% or more budget has been spent.";
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Budget Overview'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 120), // Padding for floating navbar
        child: Column(
          children: [
            // Circular Budget Gauge Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.surfaceLight.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'BUDGET CONVENTIONS',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textLight,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 28),
                  
                  // Circular Progress Indicator Stack
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: CircularProgressIndicator(
                          value: percentageUsed > 1.0 ? 1.0 : percentageUsed,
                          strokeWidth: 16,
                          backgroundColor: AppColors.surfaceLight.withOpacity(0.5),
                          color: statusColor,
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '$percentInt%',
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Spent',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  
                  // Status Indicator Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      statusText,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Statistics Row Card (Quick Info)
            Row(
              children: [
                Expanded(
                  child: _infoDetailCard(
                    title: 'Total Budget',
                    value: 'Rs ${state.monthlyBudget.toStringAsFixed(0)}',
                    icon: Icons.savings_rounded,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _infoDetailCard(
                    title: 'Remaining',
                    value: 'Rs ${state.remainingBudget.toStringAsFixed(0)}',
                    icon: Icons.account_balance_wallet_rounded,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Edit Budget Section Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.surfaceLight.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Set Monthly Limit',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (!_isEditing)
                        IconButton(
                          onPressed: () => setState(() {
                            _isEditing = true;
                            _budgetController.text = state.monthlyBudget.toStringAsFixed(0);
                          }),
                          icon: const Icon(Icons.edit_rounded, color: AppColors.primary, size: 20),
                        )
                      else
                        IconButton(
                          onPressed: () => setState(() => _isEditing = false),
                          icon: const Icon(Icons.close_rounded, color: AppColors.textLight, size: 20),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (!_isEditing)
                    Text(
                      'Adjust your budget layout to balance your finances. Current budget limit is set to Rs ${state.monthlyBudget.toStringAsFixed(0)}.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    )
                  else
                    Column(
                      children: [
                        TextField(
                          controller: _budgetController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: 'New Budget Limit (Rs)',
                            prefixIcon: Icon(Icons.monetization_on_rounded, color: AppColors.primary),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          label: 'Update Limit',
                          icon: Icons.check_rounded,
                          onPressed: () => _updateBudget(uid, state),
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoDetailCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.surfaceLight.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
