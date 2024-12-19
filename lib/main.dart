import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/flashcard_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      
      create: (_) => FlashcardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      
        title: 'Flashcard App',
        theme: ThemeData(primarySwatch: Colors.blue),
        
        home: MainScreen(

        ),
      ),
    );
  }
}
