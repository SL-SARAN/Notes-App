import 'dart:convert';
import 'package:notes_tracker/services/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> allnotes = context.watch<ExpenseProvider>().notes;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Notes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: allnotes.length,
        itemBuilder: (context, index) {
          final notes = jsonDecode(allnotes[index]);
          return Column(
            children: [
              ListTile(
                title: Text("${notes['note']}"),
                onTap: () {
                  Navigator.of(context).pushNamed("/add_notes", arguments: index);
                },
                trailing: IconButton(
                  onPressed: () {
                    context.read<ExpenseProvider>().providerDeleteNotes(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          Navigator.of(context).pushNamed("/add_notes", arguments: -1);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
