import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vplayers/presentation/videoplayers/video_players_screen.dart';

void main() => runApp(
  MaterialApp(
    title: 'VideoPlayers',
    home: const VideoPlayersScreen(),
    debugShowCheckedModeBanner: kDebugMode,
  ),
);
