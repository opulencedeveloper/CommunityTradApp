import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/background_image.dart';
import '../widgets/my_drawer.dart';
import '../widgets/music_player.dart';
import '../provider/content.dart';

class PodcastScreen extends StatelessWidget {
  static const routeName = './podcast-route';
  const PodcastScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final myMusic = Provider.of<Contents>(context);
    final _allMusic = myMusic.music;
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: SafeArea(
        child: BackgroundImage(
          widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ListView.builder(
                itemCount: _allMusic.length,
                itemBuilder: (context, i) => Column(children: [
                  if (i == 0) const SizedBox(height: 20),
                  if (i == 0)
                    Text(
                      'PODCAST',
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  if (i == 0) const SizedBox(height: 30),
                  Container(
                      height: 182,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.primary,
                            width: 2,
                          ),
                          color: const Color(0xffD9D9D9)),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            _allMusic[i].audioName,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          MusicPlayer(url: _allMusic[i].audioLink),
                        ],
                      ))
                ]),
              )
              // Column(
              //   children: [
              //     const SizedBox(height: 20),
              //     Text(
              //       'PODCAST',
              //       style: GoogleFonts.robotoCondensed(
              //         fontSize: 40,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //     const SizedBox(height: 30),
              //     const Music(),
              //     // Container(
              //     //   height: 63,
              //     //   decoration: BoxDecoration(
              //     //       border: Border.all(
              //     //         color: theme.primary,
              //     //         width: 2,
              //     //       ),
              //     //       color: const Color(0xffD9D9D9)),
              //     //   alignment: Alignment.center,
              //     //   child: Text(
              //     //     'Play Audio File',
              //     //     style: GoogleFonts.urbanist(
              //     //       fontSize: 16,
              //     //       fontWeight: FontWeight.w600,
              //     //     ),
              //     //   ),
              //     // ),
              //     const SizedBox(height: 40),
              //   ],
              // ),
              ),
        ),
      ),
    );
  }
}
