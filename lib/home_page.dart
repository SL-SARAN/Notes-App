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
    List<String> allnotes = context.watch<NoteProvider>().notes;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Notes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: allnotes.length,
        itemBuilder: (context, index) {
          final note = allnotes[index];
          return Column(
            children: [
              ListTile(
                title: Text(note),
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed("/add_notes", arguments: index);
                },
                trailing: IconButton(
                  onPressed: () async {
                    await deleteDialog(index);
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

  Future<dynamic> deleteDialog(int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete"),
          content: Text("Are you sure to delete?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                context.read<NoteProvider>().providerDeleteNotes(index);
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
