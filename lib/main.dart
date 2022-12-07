import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/get_started_screen.dart';
import './screens/signin_screen.dart';
import './screens/signup_screen.dart';
import './screens/details_screen.dart';
import './screens/sign_choice_screen.dart';
import './screens/home_screen.dart';
import './screens/podcast_screen.dart';
import './screens/account_screen.dart';
import './screens/play_learn_screen.dart';

import './provider/auth.dart';
import './provider/content.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Contents(),
        ),
      ],
      child: MaterialApp(
        title: 'Community App',
        theme: ThemeData(
          //fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xffC96B6B),
          ),
        ),
        home: const GetStartedScreen(),
        routes: {
          SignChoiceScreen.routeName: (ctx) => const SignChoiceScreen(),
          SignInScreen.routeName: (ctx) => const SignInScreen(),
          SignUpScreen.routeName: (ctx) => const SignUpScreen(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          DetailsScreen.routeName: (ctx) => const DetailsScreen(),
          PodcastScreen.routeName: (ctx) => const PodcastScreen(),
          AccountScreen.routeName: (ctx) => const AccountScreen(),
          PlayLearnScreen.routeName: (ctx) => const PlayLearnScreen(),
        },
      ),
    );
  }
}
