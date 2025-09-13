
import 'dart:convert';

class Expense {
  final String note;
  Expense({
    required this.note,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      note: json["note"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "note": note,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
