import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              Spacer(),
              Row(
                children: [
                  Icon(CategoryIcons[expense.category]),
                  Text(expense.formmatDate)
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
