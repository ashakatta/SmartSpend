import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/expense.dart';
import '../providers/expense_provider.dart';
import 'edit_expense_screen.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final Expense expense;

  const ExpenseDetailsScreen({
    super.key,
    required this.expense,
  });

  @override
  State<ExpenseDetailsScreen> createState() =>
      _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();

    final expense = expenseProvider.expenses.firstWhere(
          (item) => item.id == widget.expense.id,
      orElse: () => widget.expense,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.receipt_long,
              size: 65,
              color: Colors.teal,
            ),

            const SizedBox(height: 25),

            Text(
              expense.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text('Amount'),
                subtitle: Text(
                  '₹${expense.amount.toStringAsFixed(2)}',
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Category'),
                subtitle: Text(expense.category),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Date'),
                subtitle: Text(
                  '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Note'),
                subtitle: Text(
                  expense.note.isEmpty
                      ? 'No note added'
                      : expense.note,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditExpenseScreen(
                        expense: expense,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Expense'),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await expenseProvider.deleteExpense(expense.id);

                  if (!context.mounted) return;

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete Expense'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}