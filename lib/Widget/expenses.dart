import 'package:expense_tracker/Widget/chart/chart.dart';
import 'package:expense_tracker/Widget/expensesList/expenses_list.dart';
import 'package:expense_tracker/Widget/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registerExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 12.55,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'M abdo',
        amount: 125.55,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: 'lkyutyc',
        amount: 155.255,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  //----------------------------------------------------
  void openAddNewExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              addNewExpense: addNewExpense,
            ));
  }

//-------------------------------------------------
  void addNewExpense(Expense expense) {
    setState(() {
      registerExpenses.add(expense);
    });
  }
//-----------------------------------------------

  void removeExpense(Expense expense) {
    final expenseIndex = registerExpenses.indexOf(expense);
    setState(() {
      registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Expense deleted"),
      duration: Duration(seconds: 4),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registerExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

//--------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text("No expenses found, start adding some"),
    );
    if (registerExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: registerExpenses,
        removeExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text("Flutter ExpenseTracker"), actions: [
        IconButton(
          onPressed: openAddNewExpense,
          icon: Icon(Icons.add),
        )
      ]),
      body: Column(
        children: [
          Chart(expenses: registerExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
