import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '../models/page_manager.dart';

class MusicPlayer extends StatefulWidget {
  final String url;
  const MusicPlayer({required this.url, Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late final PageManager _pageManager;
  //late PlayerController playerController;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager(url: widget.url);
    //playerController = PlayerController();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  final List<double> values = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ValueListenableBuilder<ProgressBarState>(
          valueListenable: _pageManager.progressNotifier,
          builder: (_, value, __) {
            return ProgressBar(
              progress: value.current,
              buffered: value.buffered,
              total: value.total,
              onSeek: _pageManager.seek,
              baseBarColor: Colors.white,
              bufferedBarColor: theme.colorScheme.secondary,
              progressBarColor: theme.primaryColor,
              thumbColor: Colors.green,
            );
          },
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.shuffle_rounded, size: 24),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.skip_previous_outlined, size: 24),
          // ),
          ValueListenableBuilder<ButtonState>(
            valueListenable: _pageManager.buttonNotifier,
            builder: (_, value, __) {
              switch (value) {
                case ButtonState.loading:
                  return const CircularProgressIndicator();
                case ButtonState.paused:
                  return IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: _pageManager.play,
                  );
                case ButtonState.playing:
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: _pageManager.pause,
                  );
              }
            },
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.skip_next_outlined, size: 24),
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.repeat, size: 24),
          // ),
        ]),
      ],
    );
  }
}
