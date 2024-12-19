import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flip_card/flip_card.dart'; // Import the flip_card package
import '../provider/flashcard_provider.dart';
import 'add_edit_flashcard_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? tappedIndex; // Track which card is tapped, or null if none is tapped

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 33, 37),
      appBar: AppBar(
        title: Text(
          'Flashcards',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 32, 33, 37),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            // Handle menu icon press
          },
        ),
        actions: [
          CircleAvatar(
            backgroundImage:
                AssetImage('lib/assets/image.png'), // Profile image
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle three-dot icon press
            },
          ),
        ],
      ),
      body: Consumer<FlashcardProvider>(
        builder: (context, provider, _) {
          return ListView.builder(
            itemCount: provider.flashcards.length,
            itemBuilder: (context, index) {
              final flashcard = provider.flashcards[index];
              bool isTapped =
                  tappedIndex == index; // Check if the card is tapped

              return GestureDetector(
                onTap: () {
                  setState(() {
                    // Toggle the tapped card
                    tappedIndex = isTapped ? null : index;
                  });
                },
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL, // Flip horizontally
                  flipOnTouch: true, // Flip the card on tap
                  front: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Increased margin
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16), // Rounded corners for cards
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color:
                                Colors.black.withOpacity(0.5), // Dark overlay
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: isTapped
                              ? 300
                              : 220, // Adjust height based on tapped state
                          padding:
                              EdgeInsets.all(16), // Padding inside the card
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              Colors.black,
                              Colors.transparent
                            ]),
                            borderRadius: BorderRadius.circular(
                                16), // Rounded corners for the container
                            image: DecorationImage(
                               opacity: 0.6,
                              image: AssetImage(
                                  'lib/assets/1.png'), // Background image path
                              fit: BoxFit
                                  .cover, // Ensures the image covers the entire container
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flashcard.question, // Main question text
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      22, // Increased font size for question
                                  color:
                                      Colors.white, // White color for the text
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Space between question and flashcard number
                              Spacer(), // Spacer to push index to the bottom
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Distribute space
                                children: [
                                  Text(
                                    'Flashcard ${index + 1}', // Flashcard number
                                    style: TextStyle(
                                      fontSize: 14, // Font size for the number
                                      color: Colors
                                          .white, // Lighter color for the number
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                        color: Colors.white,),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                AddEditFlashcardScreen(
                                              index: index,
                                              question: flashcard.question,
                                              answer: flashcard.answer,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                        color: Colors.white,),
                                        onPressed: () =>
                                            _confirmDelete(context, index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  back: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16), // Increased margin
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          16), // Rounded corners for cards
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color:
                                Colors.black.withOpacity(0.4), // Dark overlay
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: isTapped
                              ? 300
                              : 220, // Adjust height based on tapped state
                          padding:
                              EdgeInsets.all(16), // Padding inside the card
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.black,
                              Colors.black,
                              Colors.transparent
                            ]),
                            borderRadius: BorderRadius.circular(
                                16), // Rounded corners for the container
                            image: DecorationImage(
                              opacity: 0.7,
                              image: AssetImage(
                                  'lib/assets/1.png'), // Background image path
                              fit: BoxFit
                                  .cover, // Ensures the image covers the entire container
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flashcard
                                    .answer, // Display the answer on the back
                                style: TextStyle(
                                  fontSize: 20, // Larger font size for answer
                                  color:
                                      Colors.white, // White color for the text
                                ),
                              ),
                              Spacer(), // Spacer to push index to the bottom
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Distribute space
                                children: [
                                  Text(
                                    'Flashcard ${index + 1}', // Flashcard number
                                    style: TextStyle(
                                      fontSize: 14, // Font size for the number
                                      color: Colors
                                          .white, // Lighter color for the number
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                AddEditFlashcardScreen(
                                              index: index,
                                              question: flashcard.question,
                                              answer: flashcard.answer,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _confirmDelete(context, index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddEditFlashcardScreen(),
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Flashcard'),
        content: Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Provider.of<FlashcardProvider>(context, listen: false)
                  .deleteFlashcard(index);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
