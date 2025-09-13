import 'package:hive_ce/hive.dart';

late Box? _db;

void connectDb() {
  _db = Hive.box("Notes");
}

List<String> initializeDb() {
  final db = _db?.get("notes") ?? [];
  return List<String>.from(db);
}

void saveToDb(List<String> expenses) {
  _db?.put("notes", expenses);
}

void deleteFromDb(int index, List<String> expenses) {
  expenses.removeAt(index);
  saveToDb(expenses);
}


