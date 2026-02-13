
Video Manager
A lightweight, singleton-based video controller for Flutter that simplifies managing a single active VideoPlayerController across your entire application.

## Features
Singleton Pattern: Ensure only one video is active at a time globally.

Auto-Cleanup: Automatically pauses and disposes of the previous controller when a new video starts.

State Tracking: Includes ValueNotifier hooks for the active URL and play/pause status, making UI updates reactive and simple.

Seamless Switching: Handles the logic of initializing new network URLs while maintaining a clean memory footprint.

## Getting started

Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  video_player_manager: ^0.0.1  # Replace with your actual version

flutter pub get

To implement the video list, use the `VideoManager` within a `ListView.builder`:

```dart
ListView.builder(
  itemCount: urls.length,
  shrinkWrap: true,
  itemBuilder: (context, listIndex) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 12),
      child: Column(
        children: [
          ValueListenableBuilder<String?>(
            valueListenable: VideoManager().activeUrl,
            builder: (context, value, child) {
              return VideoPlayerContainer(
                videoUrl: urls[listIndex],
                // ... rest of your code
              );
            },
          ),
        ],
      ),
    );
  },
)

