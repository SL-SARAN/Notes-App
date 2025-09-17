import 'package:notes_tracker/models/notes.dart';
import 'package:notes_tracker/services/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key});

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  @override
  void initState() {
    super.initState();
  }
  int index = -1;
  String buttonText = "Add";
  final TextEditingController _note = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    index = ModalRoute.of(context)!.settings.arguments as int;
    if (index != -1) {
      String textToUpdate = context.read<NoteProvider>().notes[index];
      _note.text = textToUpdate;
      buttonText = "Update";
    }
  }
  void addExpense() {
    final String note = _note.text;
    Note notes = Note(
      note: note
    );
    if (index == -1) {
      context.read<NoteProvider>().providerAddNotes(notes);
    } else {
      context.read<NoteProvider>().providerUpdateNotes(notes, index);
      index = -1;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
