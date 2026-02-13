
Video Manager
A lightweight, singleton-based video controller for Flutter that simplifies managing a single active VideoPlayerController across your entire application.

Features
Singleton Pattern: Ensure only one video is active at a time globally.

Auto-Cleanup: Automatically pauses and disposes of the previous controller when a new video starts.

State Tracking: Includes ValueNotifier hooks for the active URL and play/pause status, making UI updates reactive and simple.

Seamless Switching: Handles the logic of initializing new network URLs while maintaining a clean memory footprint.

## Getting started

dependencies:
  video_manager: ^0.0.1 # Replace with your version

  Then run:
flutter pub get

## Usage
ListView.builder(
        itemCount: urls.length,
        shrinkWrap: true,
        itemBuilder: (context, listIndex) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<String?>(
                  valueListenable: VideoManager().activeUrl,
                  builder: (context, value, child) {
                    return VideoPlayerContainer(
                      videoUrl: urls[listIndex],
                      builder: (context, isPlaying, controller) {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            value == urls[listIndex] && controller != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: 280,
                                      child: VideoPlayer(controller),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: thumbnails[listIndex],
                                      fit: BoxFit.fill,
                                      width: 400,
                                    ),
                                  ),
                            IconButton(
                              icon: Icon(
                                value == urls[listIndex]
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: () =>
                                  urls[listIndex] !=
                                      VideoManager().activeUrl.value
                                  ? VideoManager().playNewVideo(urls[listIndex])
                                  : VideoManager().togglePlayPause(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),


