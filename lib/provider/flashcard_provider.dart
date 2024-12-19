import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  final List<Flashcard> _flashcards = [];
  static const String _storageKey = 'flashcards';

  List<Flashcard> get flashcards => _flashcards;

  FlashcardProvider() {
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_storageKey);

    if (savedData == null) {
      // Initialize with default flashcards if first launch
      _flashcards.addAll([
        Flashcard(question: "What is Flutter?", answer: "A UI toolkit by Google."),
        Flashcard(question: "What is Dart?", answer: "A programming language."),
        Flashcard(question: "What is Stateful Widget?", answer: "Widget with state."),
        Flashcard(question: "What is Stateless Widget?", answer: "Widget without state."),
        Flashcard(question: "What is Provider?", answer: "A state management tool."),
      ]);
      _saveFlashcards();
    } else {
      // Load saved flashcards
      final List<dynamic> jsonData = json.decode(savedData);
      _flashcards.addAll(jsonData.map((item) => Flashcard(
            question: item['question'],
            answer: item['answer'],
          )));
    }
    notifyListeners();
  }

  Future<void> _saveFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, String>> jsonData = _flashcards
        .map((flashcard) => {'question': flashcard.question, 'answer': flashcard.answer})
        .toList();
    prefs.setString(_storageKey, json.encode(jsonData));
  }

  void addFlashcard(String question, String answer) {
    _flashcards.add(Flashcard(question: question, answer: answer));
    _saveFlashcards();
    notifyListeners();
  }

  void editFlashcard(int index, String question, String answer) {
    _flashcards[index].question = question;
    _flashcards[index].answer = answer;
    _saveFlashcards();
    notifyListeners();
  }

  void deleteFlashcard(int index) {
    _flashcards.removeAt(index);
    _saveFlashcards();
    notifyListeners();
  }
  
}
