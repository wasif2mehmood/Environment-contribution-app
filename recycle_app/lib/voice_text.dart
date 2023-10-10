import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:recycle_app/db.dart';

// ignore: camel_case_types
class speech extends StatefulWidget {
  const speech({super.key});

  @override
  State<speech> createState() => _speechState();
}

class _speechState extends State<speech> {
  List<Map<String, dynamic>> record = [];
  final SpeechToText speech_to_text = SpeechToText();
  var enebaled_speech = false;
  var words = '';
  var data = "";
  var recording = false;

  void refresh() async {
    final data = await database.getData();
    setState(() {
      record = data;
    });
  }

  final TextEditingController title_controller = TextEditingController();
  final TextEditingController desc_controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    init_speech();
    desc_controller.text = words;
    refresh();
  }

  Future<void> add_data() async {
    await database.records(title_controller.text, desc_controller.text);
    refresh();
  }

  void init_speech() async {
    enebaled_speech = await speech_to_text.initialize();
    setState(() {});
  }

  void start_listening() async {
    await speech_to_text.listen(onResult: on_speech_result);
    setState(() {});
  }

  void stop_listening() async {
    await speech_to_text.stop();
    setState(() {
      
    });
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void on_speech_result(SpeechRecognitionResult result) {
    setState(() {
      words = result.recognizedWords;
      desc_controller.text = words;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 133, 198, 137),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
 glowColor: Color.fromARGB(255, 4, 83, 29),
 endRadius: 90.0,
 duration: Duration(milliseconds: 2000),
 repeat: true,
 showTwoGlows: true,
 repeatPauseDuration: Duration(milliseconds: 100),
 child: Material(     // Replace this child with your own
   elevation: 8.0,
   shape: CircleBorder(),
   child: CircleAvatar(
     backgroundColor: Colors.grey[100],
     child: GestureDetector(
            onTapDown: (details) {
              setState(() {
                start_listening();
                recording = true;
                print("Listening Startedssssssssssssssssssss");
              });
            },
            onTapUp: (details) {
              setState(() {
                stop_listening();
                print('listening stopeddddddddddddddddddddddddddddddddddddd');
                recording = false;
              });
            },
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 22, 155, 36),
              radius: 35,
              child: Icon(
                Icons.mic,
                color: Colors.white,
              ),
            ),
          ),
     radius: 40.0,
   ),
 ),
),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 72, 23),
        title: const Text("Speech To Text"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: title_controller,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                  hintText: "Enter Title",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: desc_controller,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                  hintText: "Enter Description",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (title_controller.text == "") {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error!'),
                          content: const Text('Title cannot be empty!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      await add_data();
                      title_controller.text = "";
                      desc_controller.text = "";

                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Data Stored Successful'),
                          content: const Text('Data Entered successfully!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                   backgroundColor: Color.fromARGB(255, 22, 155, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Add Data"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'To record, hold down the button. When you finish speaking or want to take a break, release the button when you hear the stop bell. To stop recording completely, wait for the stop bell and then hold the button again to continue.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
