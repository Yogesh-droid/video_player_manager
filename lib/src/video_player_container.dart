import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_manager.dart' show VideoManager;

typedef VideoUIBuilder =
    Widget Function(
      BuildContext context,
      bool isPlaying,
      VideoPlayerController? controller,
    );

class VideoPlayerContainer extends StatelessWidget {
  final String videoUrl;
  final VideoUIBuilder builder;

  const VideoPlayerContainer({
    super.key,
    required this.videoUrl,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: VideoManager().activeUrl,
      builder: (context, activeUrl, _) {
        bool isThisPlaying = (activeUrl == videoUrl);
        return builder(context, isThisPlaying, VideoManager().controller);
      },
    );
  }
}
