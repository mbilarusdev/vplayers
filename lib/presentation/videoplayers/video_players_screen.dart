import 'package:flutter/material.dart';
import 'package:vplayers/presentation/videoplayers/widget/video_player.dart';

class VideoPlayersScreen extends StatefulWidget {
  final int videoPlayersCount;
  final int activeVolumeIndex;
  const VideoPlayersScreen({
    super.key,
    this.videoPlayersCount = 2,
    this.activeVolumeIndex = 0,
  });

  @override
  State<VideoPlayersScreen> createState() => _VideoPlayersScreenState();
}

class _VideoPlayersScreenState extends State<VideoPlayersScreen> {
  // I had value notifier better than bloc/cubit in this case but we has only 1 flag to change
  late final _activeVolumeNotifier = ValueNotifier<int>(
    widget.activeVolumeIndex,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 20.0,
          children: List.generate(
            widget.videoPlayersCount,
            (i) => VideoPlayerWidget(
              index: i,
              hasVolume: i == _activeVolumeNotifier.value,
              changeActiveVolume: _changeActiveVolume,
            ),
          ),
        ),
      ),
    );
  }

  void _changeActiveVolume({required int index}) =>
      setState(() => _activeVolumeNotifier.value = index);

  @override
  void dispose() {
    _activeVolumeNotifier.dispose();
    super.dispose();
  }
}
