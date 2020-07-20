import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayerComponent extends StatefulWidget {
  const MusicPlayerComponent({
    Key key,
    @required this.audioPlayer,
    @required this.filepath,
  }) : super(key: key);

  final AudioPlayer audioPlayer;
  final String filepath;

  @override
  _MusicPlayerComponentState createState() => _MusicPlayerComponentState();
}

class _MusicPlayerComponentState extends State<MusicPlayerComponent> {
  double duration = 10;
  double current_position = 0;
  StreamView<Duration> audioPositionStream;
  StreamView<Duration> audioDurationStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPositionStream =
        StreamView<Duration>(widget.audioPlayer.onAudioPositionChanged);
    audioDurationStream =
        StreamView<Duration>(widget.audioPlayer.onDurationChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                try {
                  int setAudioUrl = await widget.audioPlayer
                      .setUrl(widget.filepath, isLocal: true);
                  audioDurationStream.listen((value) {
                    setState(() {
                      duration = value.inMilliseconds.toDouble();
                    });
                  });

                  widget.audioPlayer.play(widget.filepath);

                  audioPositionStream.listen((value) {
                    setState(() {
                      current_position = value.inMilliseconds.toDouble();
                    });
                  });
                } catch (e) {
                  print(e);
                }
              },
              child: CircleAvatar(child: Icon(Icons.arrow_right), radius: 30),
            ),
            GestureDetector(
              onTap: () {
                try {
                  widget.audioPlayer.stop();
                } catch (e) {
                  print(e);
                }
              },
              child: CircleAvatar(child: Icon(Icons.crop_square), radius: 30),
            ),
          ],
        ),
        Slider(
          onChanged: (value) {
            setState(() {
              current_position = value;
              widget.audioPlayer.seek(
                Duration(
                  milliseconds: value.toInt(),
                ),
              );
            });
          },
          value: current_position,
          min: 0,
          max: duration,
        ),
      ],
    );
  }
}
