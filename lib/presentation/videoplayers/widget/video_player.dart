import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vplayers/presentation/videoplayers/common/asset_paths.dart';
import 'package:vplayers/presentation/videoplayers/common/constants.dart';

class VideoPlayerWidget extends StatefulWidget {
  final int index;
  final bool hasVolume;
  final void Function({required int index}) changeActiveVolume;
  const VideoPlayerWidget({
    super.key,
    required this.index,
    required this.hasVolume,
    required this.changeActiveVolume,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset(
            AssetPaths.videoPath(videoIndex: widget.index),
            videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
          )
          ..initialize().then((_) {
            _startVideo();
          });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    if (widget.hasVolume != oldWidget.hasVolume ||
        widget.index != oldWidget.index) {
      _refreshVolume();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => _controller.value.isInitialized
      ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              IconButton(
                icon: Icon(
                  widget.hasVolume ? Icons.volume_off : Icons.volume_up,
                ),
                color: Colors.black.withAlpha(100),
                onPressed: () => widget.changeActiveVolume(index: widget.index),
              ),
            ],
          ),
        )
      : SizedBox();

  void _startVideo() {
    _refreshVolume();
    _controller.play();
    setState(() {});
  }

  void _refreshVolume() => _controller.setVolume(
    widget.hasVolume ? Constants.maxVolume : Constants.minVolume,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
