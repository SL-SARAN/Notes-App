import 'package:notes_tracker/models/notes.dart';
import 'package:notes_tracker/services/db/db_provider.dart';
import 'package:flutter/widgets.dart';

class ExpenseProvider extends ChangeNotifier{

  final List<String> _allNotes = initializeDb();

  List<String> get notes => _allNotes;

  void providerAddNotesToDb() {
    saveToDb(_allNotes);
  }

  void providerAddNotes(Expense notes) {
    _allNotes.add(notes.toJson());
    providerAddNotesToDb();
    notifyListeners();
  }

  void providerDeleteNotes(int index) {
    _allNotes.removeAt(index);
    providerAddNotesToDb();
    notifyListeners();
  }

  void providerUpdateNotes(Expense notes, int index) {
    providerDeleteNotes(index);
    _allNotes.insert(index, notes.toJson());
    providerAddNotesToDb();
    notifyListeners();
  }
}