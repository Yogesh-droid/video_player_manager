import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoManager {
  static final VideoManager _instance = VideoManager._internal();
  factory VideoManager() => _instance;
  VideoManager._internal();
  VideoPlayerController? _activeController;
  final ValueNotifier<String?> activeUrl = ValueNotifier(null);
  final ValueNotifier<bool> isVideoPlaying = ValueNotifier(false);
  VideoPlayerController? get controller => _activeController;

  Future<void> playNewVideo(String url) async {
    if (activeUrl.value == url) return;
    if (_activeController != null) {
      await _activeController?.pause();
      await _activeController?.dispose();
      _activeController = null;
      activeUrl.value = null;
      isVideoPlaying.value = false;
      await Future.delayed(const Duration(milliseconds: 100));
    }
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await controller.initialize();
      _activeController = controller;
      // 2. Set the new URL - this triggers all listeners to rebuild
      activeUrl.value = url;
      isVideoPlaying.value = true;
      _activeController!.play();
    } catch (e) {
      debugPrint("Init Error: $e");
    }
  }

  Future<void> togglePlayPause() async {
    if (_activeController != null) {
      if (_activeController!.value.isPlaying) {
        await _activeController?.pause();
        isVideoPlaying.value = false;
        await Future.delayed(const Duration(milliseconds: 100));
      } else {
        await _activeController?.play();
        isVideoPlaying.value = true;
      }
    }
  }
}
