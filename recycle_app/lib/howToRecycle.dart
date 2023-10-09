import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recycle_app/quiz.dart';
import 'package:video_player/video_player.dart';

class whyRecycleScreen extends StatefulWidget {
  const whyRecycleScreen({super.key});

  @override
  State<whyRecycleScreen> createState() => _whyRecycleScreenState();
}

class _whyRecycleScreenState extends State<whyRecycleScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://player.vimeo.com/external/371864111.sd.mp4?s=8db6fa3ae678cfe95198e8a563c4a69852983962&profile_id=164&oauth2_token_id=57447761',
      ),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          
          GestureDetector(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
            
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 255, 255),),
            onPressed: () {
              // Wrap the play ory pause in a call to `setState`.
              setState(() {
                // If the video is playing, pause it.
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  // If the video is paused, play it.
                  _controller.play();
                }
              });
            },
            child: Container( // Change this color to your desired color
    padding: EdgeInsets.all(0), // Adjust the padding as needed
    child: Icon(
      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      color: Color.fromARGB(255, 22, 155, 36), // Change this color to your desired icon color
    ),
  ),
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green, // Change this line to set the background color
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.airline_seat_flat_angled),
            title: Text(title),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
              TextButton(
                child: const Text('SELL TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class howToMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 133, 198, 137),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 72, 23),
        title: const Center(
          child: Text(
            "Eco Cycle",
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
  children: <Widget>[
    SizedBox(
      height: 20,
    ),
    Card(
      color: Color.fromARGB(255, 22, 155, 36),
      elevation: 5.0,
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
           
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.video_collection, color: Color.fromARGB(255, 22, 155, 36)),
            ),
            title: Text(
              'Video Message',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Stack(
            alignment: FractionalOffset.bottomRight +
                const FractionalOffset(-0.1, -0.1),
            children: <Widget>[
              whyRecycleScreen(),
            ],
          ),
        ],
      ),
    ),
    SizedBox(
      height: 10,
    ),
    Card(
      color: Color.fromARGB(255, 22, 155, 36),
      elevation: 8.0, // Increased elevation for a layered effect
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.pageview, color: Color.fromARGB(255, 22, 155, 36)),
            ),
            title: Text(
              'Why Recycle',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
  'Recycling helps reduce waste and conserves resources. '
  'It plays a crucial role in protecting the environment '
  'and ensuring a sustainable future for our planet.\n\n'
  'To recycle products:\n'
  '1. Separate materials into recyclables and non-recyclables.\n'
  '2. Check local recycling guidelines for specific instructions.\n'
  '3. Rinse or clean recyclable items before placing them in recycling bins.\n'
  '4. Avoid contaminating recycling bins with non-recyclable items.\n'
  '5. Support recycling programs and initiatives in your community.',
  style: TextStyle(
    fontSize: 16.0,
    color: Colors.white,
  ),
),

          ),
        ],
      ),
    ),
    SizedBox(
      height: 10,
    ),

    Card(
      color: Color.fromARGB(255, 22, 155, 36),
      elevation: 8.0, // Increased elevation for a layered effect
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            
            leading: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.quiz, color: Color.fromARGB(255, 22, 155, 36)),
            ),
            title: Text(
              'Bonus Quiz',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: const Text('Start Quiz', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  MCQPage(),
                      ),
                    );
                },
              ),
              TextButton(
                child: const Text('No Thanks', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    ),
    
  ],
),

    );
  }
}
