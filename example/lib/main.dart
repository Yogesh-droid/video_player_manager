import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_manager/video_player_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Video player Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final urls = [
    'https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/bigbuck_bunny_8bit_200kbps_360p_60.0fps_h264.mp4',
    'https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/cutting_orange_tuil_200kbps_360p_59.94fps_h264.mp4',
    'https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/vegetables_tuil_200kbps_360p_59.94fps_h264.mp4',
    'https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/water_netflix_200kbps_360p_59.94fps_h264.mp4',
    'https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_2/segments/water_netflix_8s_387kbps_720p_59.94fps_h264.mp4',
    'https://avtshare01.rz.tu-ilmenau.de/avt-vqdb-uhd-1/test_1/segments/vegetables_tuil_200kbps_360p_59.94fps_h264.mp4',
  ];

  final List<String> thumbnails = [
    "https://images.unsplash.com/flagged/1/apple-gear-looking-pretty.jpg?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/2/06.jpg?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://fastly.picsum.photos/id/17/2500/1667.jpg?hmac=HD-JrnNUZjFiP2UZQvWcKrgLoC_pc_ouUSWv8kHsJJY",
    "https://fastly.picsum.photos/id/15/2500/1667.jpg?hmac=Lv03D1Y3AsZ9L2tMMC1KQZekBVaQSDc1waqJ54IHvo4",
    "https://fastly.picsum.photos/id/22/4434/3729.jpg?hmac=fjZdkSMZJNFgsoDh8Qo5zdA_nSGUAWvKLyyqmEt2xs0",
    "https://fastly.picsum.photos/id/27/3264/1836.jpg?hmac=p3BVIgKKQpHhfGRRCbsi2MCAzw8mWBCayBsKxxtWO8g",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: ListView.builder(
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
    );
  }
}
