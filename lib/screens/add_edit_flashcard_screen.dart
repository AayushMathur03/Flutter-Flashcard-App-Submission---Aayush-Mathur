import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/flashcard_provider.dart';

class AddEditFlashcardScreen extends StatelessWidget {
  final int? index;
  final String? question;
  final String? answer;

  AddEditFlashcardScreen({this.index, this.question, this.answer});

  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (question != null && answer != null) {
      _questionController.text = question!;
      _answerController.text = answer!;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 33, 37),
      appBar: AppBar(
        title: Text(
          index == null ? 'Add Flashcard' : 'Edit Flashcard',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 32, 33, 37),
        iconTheme: const IconThemeData(color: Colors.white), // Back button color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: 'Enter the Question',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white), // Set text color
                validator: (value) =>
                    value!.isEmpty ? 'Question cannot be empty' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(
                  labelText: 'Enter the Answer',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white), // Set text color
                validator: (value) =>
                    value!.isEmpty ? 'Answer cannot be empty' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Set button color to green
                  foregroundColor: Colors.white, // Set text color to white
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  index == null ? 'Add' : 'Save',
                  style: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final provider =
                        Provider.of<FlashcardProvider>(context, listen: false);
                    if (index == null) {
                      provider.addFlashcard(
                        _questionController.text,
                        _answerController.text,
                      );
                    } else {
                      provider.editFlashcard(
                        index!,
                        _questionController.text,
                        _answerController.text,
                      );
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
