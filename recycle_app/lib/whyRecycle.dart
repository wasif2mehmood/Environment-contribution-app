import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class _ExampleCard extends StatelessWidget {
  const _ExampleCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
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


class whyRecycle extends StatelessWidget {
  const whyRecycle({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: whyRecycleScreen(),
    );
  }
}

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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    // Initialize the controller and store the Future for later use.
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
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
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
                  onPressed: () {
                    // Wrap the play or pause in a call to `setState`.
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
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class allLists extends StatelessWidget {
  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        title: Text('All Lists'),
      ),
      body: ListView(
        children: <Widget>[
          _ExampleCard(title: 'Why Recycle?'),
          _ExampleCard(title: 'How to Recycle?'),
        
        ],
      ),
    );

  }
  
}