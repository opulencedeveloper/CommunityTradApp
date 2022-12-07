import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/home_screen.dart';
import '../screens/account_screen.dart';
import '../screens/podcast_screen.dart';
import '../screens/play_learn_screen.dart';

class MyDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, VoidCallback tapHandler, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffD9D9D9),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          buildListTile('Home', () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }, context),
          buildListTile('Podcast', () {
            Navigator.of(context).pushReplacementNamed(PodcastScreen.routeName);
          }, context),
          buildListTile('Play and Learn', () {
            Navigator.of(context)
                .pushReplacementNamed(PlayLearnScreen.routeName);
          }, context),
          buildListTile('Account', () {
            Navigator.of(context).pushReplacementNamed(AccountScreen.routeName);
          }, context),
        ],
      ),
    );
  }
}
