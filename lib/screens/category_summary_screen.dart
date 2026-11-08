import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';

class CategorySummaryScreen extends StatelessWidget {
  const CategorySummaryScreen({super.key});

  static const List<String> categories = [
    'Food',
    'Travel',
    'Shopping',
    'Entertainment',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final totalAmount = expenseProvider.totalExpenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Summary'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Your Spending by Category',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Total Expenses Card
          Card(
            child: ListTile(
              title: const Text('Total Expenses'),
              subtitle: const Text('All categories combined'),
              trailing: Text(
                '₹${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Category-wise Expenses
          ...categories.map((category) {
            final amount =
            expenseProvider.categoryTotal(category);

            final percentage = totalAmount > 0
                ? (amount / totalAmount)
                : 0.0;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(
                          _getCategoryIcon(category),
                          color: Colors.teal,
                        ),
                      ),
                      title: Text(
                        category,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${(percentage * 100).toStringAsFixed(1)}% of total expenses',
                      ),
                      trailing: Text(
                        '₹${amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Spending Progress Bar
                    LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(
                        Colors.teal,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Category Icons
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant;

      case 'Travel':
        return Icons.directions_bus;

      case 'Shopping':
        return Icons.shopping_bag;

      case 'Entertainment':
        return Icons.movie;

      default:
        return Icons.category;
    }
  }
}