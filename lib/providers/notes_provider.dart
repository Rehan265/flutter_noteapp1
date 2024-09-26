import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  List<Map> notes = [];

  void addNote(Map item) {
    notes.add(item);
    notifyListeners();
  }

  void removeNote(Map item) {
    notes.remove(item);
    notifyListeners();
  }

  void updateNote(int index, Map item) {
    notes[index] = item;
    notifyListeners();
  }
}
