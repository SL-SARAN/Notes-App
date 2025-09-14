import 'dart:convert';
import 'package:notes_tracker/models/notes.dart';
import 'package:notes_tracker/services/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseAdd extends StatefulWidget {
  const ExpenseAdd({super.key});

  @override
  State<ExpenseAdd> createState() => _ExpenseAddState();
}

class _ExpenseAddState extends State<ExpenseAdd> {
  @override
  void initState() {
    super.initState();
  }
  int index = -1;
  final TextEditingController _note = TextEditingController();
  void addExpense() {
    final String note = _note.text;
    Expense notes = Expense(
      note: note
    );
    if (index == -1) {
      context.read<ExpenseProvider>().providerAddNotes(notes);
    } else {
      context.read<ExpenseProvider>().providerUpdateNotes(notes, index);
      index = -1;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    index = ModalRoute.of(context)!.settings.arguments as int;
    String buttonText = "Add";
    if (index != -1) {
      String textToUpdate = context.read<ExpenseProvider>().notes[index];
      _note.text = jsonDecode(textToUpdate)["note"];
      buttonText = "Update";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Add the Notes"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _note,
              decoration: InputDecoration(labelText: "Note"),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      addExpense();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 62, 139, 248),
                      foregroundColor: Colors.black,
                    ),
                    child: Text(buttonText, style: TextStyle(
                      fontSize: 20,
                    ),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _note.dispose();
  }
}
