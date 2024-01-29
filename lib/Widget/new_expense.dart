import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addNewExpense});
  final void Function(Expense expense) addNewExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //---------------------------------------------------
  final titleConrollar = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;
//---------------------------------------------------
  void presentDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

//---------------------------------------------
  @override
  void dispose() {
    titleConrollar.dispose();
    amountController.dispose();
    super.dispose();
  }
//-------------------------------------------------

  void submitExpense() {
    final enteredAmount = double.tryParse(amountController.text);

    if (titleConrollar.text.trim().isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0 ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
              "Please make sure a valid title, amount, date, and category was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        ),
      );
      return;
    }

    widget.addNewExpense(Expense(
        title: titleConrollar.text,
        amount: enteredAmount,
        date: selectedDate!,
        category: selectedCategory));
    Navigator.pop(context);
  }

//----------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: titleConrollar,
            //keyboardType: TextInputType.text,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: '\$',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(selectedDate == null
                        ? "no selected date"
                        : formatter.format(selectedDate!)),
                    IconButton(
                      onPressed: presentDate,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
//-------------------------------------------------------------------------
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              Spacer(),
//----------------------------------------------------------------------------
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: submitExpense,
                child: const Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
