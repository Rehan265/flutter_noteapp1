import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesProvider extends ChangeNotifier {
  List<Map> notes = [];

  Future<void> addDataFromLocalStorage() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("Notes", json.encode(notes));
  }

  Future<List> getDataFromLocalStorage() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final data = sp.getString("Notes");

    if (data != null) {
      notes = List<Map>.from(json.decode(data));
      return notes;
    } else {
      return [];
    }
  }

  void addNote(Map item) {
    notes.add(item);
    addDataFromLocalStorage();
    notifyListeners();
  }

  void removeNote(Map item) {
    notes.remove(item);
    addDataFromLocalStorage();
    notifyListeners();
  }

  void updateNote(int index, Map item) {
    notes[index] = item;
    addDataFromLocalStorage();
    notifyListeners();
  }
}
