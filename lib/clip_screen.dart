import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'music_player_component.dart';

class ClipScreen extends StatefulWidget {
  @override
  _ClipScreenState createState() => _ClipScreenState();
}

class _ClipScreenState extends State<ClipScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  String filepath;
  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              color: Colors.red,
              onPressed: () async {
                File file = await FilePicker.getFile(
                  type: FileType.custom,
                  allowedExtensions: ['mp3', 'wav'],
                );
                setState(() {
                  filepath = file.path;
                });
                print(file.path);
              },
              child: Text('Get Directory'),
            ),
            MusicPlayerComponent(audioPlayer: audioPlayer, filepath: filepath)
          ],
        ),
      ),
    );
  }
}
