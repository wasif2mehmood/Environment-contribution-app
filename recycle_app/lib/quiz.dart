import 'package:flutter/material.dart';

class MCQPage extends StatefulWidget {
  @override
  _MCQPageState createState() => _MCQPageState();
}

class _MCQPageState extends State<MCQPage> {
  int score = 0;
  Map<String, String> selectedOptions = {};

  // Define your list of questions and options here
  List<Map<String, dynamic>> mcqData = [
  {
    "question": "Why is recycling important?",
    "options": [
      "To reduce waste and conserve resources.",
      "To make money.",
      "To increase pollution.",
      "To save energy."
    ],
    "correctAnswer": "To reduce waste and conserve resources.",
  },
  {
    "question": "What should you do before placing items in recycling bins?",
    "options": [
      "Rinse or clean recyclable items.",
      "Throw them in as is.",
      "Leave them dirty.",
      "Mix them with non-recyclables."
    ],
    "correctAnswer": "Rinse or clean recyclable items.",
  },
  {
    "question": "How can you support recycling?",
    "options": [
      "Ignore recycling programs.",
      "Throw everything in the trash.",
      "Recycle only on weekends.",
      "Support recycling programs and initiatives in your community."
    ],
    "correctAnswer": "Support recycling programs and initiatives in your community.",
  },
  {
    "question": "What happens to recyclables after collection?",
    "options": [
      "They are sent to a landfill.",
      "They are incinerated.",
      "They are processed and turned into new products.",
      "They are buried in the backyard."
    ],
    "correctAnswer": "They are processed and turned into new products.",
  },
  {
    "question": "Which of the following materials is commonly recycled?",
    "options": [
      "Plastic bags",
      "Pizza boxes with grease stains",
      "Aluminum cans",
      "Broken glass"
    ],
    "correctAnswer": "Aluminum cans",
  },
  // Add more questions and options as needed
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 133, 198, 137),
      appBar: AppBar(
        title: Text("MCQ Quiz"),
        backgroundColor: Color.fromARGB(255, 4, 72, 23),
      ),
      body: ListView.builder(
        itemCount: mcqData.length,
        itemBuilder: (context, index) {
          final question = mcqData[index]["question"];
          final options = List<String>.from(mcqData[index]["options"]);
          final correctAnswer = mcqData[index]["correctAnswer"];

          return Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    question,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Column(
                  children: options.map((option) {
                    return ListTile(
                      leading: Radio(
                        value: option,
                        groupValue: selectedOptions[question],
                        onChanged: (value) {
                          if(value == correctAnswer) {
                            score += 1;
                          }
                          setState(() {
                            selectedOptions[question] = value!;
                          });
                        },
                      ),
                      title: Text(option),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                  selectedOptions[question] == correctAnswer
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: selectedOptions[question] == correctAnswer
                      ? Colors.green
                      : Colors.red,
                ),
                ),
                
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 4, 72, 23),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Good Job! "),
                content: Text("Keep it up!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
