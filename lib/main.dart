import 'package:notes_tracker/home_page.dart';
import 'package:notes_tracker/pages/notes_add.dart';
import 'package:notes_tracker/services/db/db_provider.dart';
import 'package:notes_tracker/services/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("Notes");
  connectDb();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: NotesTracker(),
    ),
  );
}

class NotesTracker extends StatelessWidget {
  const NotesTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      home: const HomePage(),
      routes: {"/add_notes": (context) => const NoteAdd()},
    );
  }
}
