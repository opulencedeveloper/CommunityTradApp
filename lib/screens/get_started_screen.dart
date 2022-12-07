import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/sign_choice_screen.dart';

import '../widgets/background_image.dart';
import '../widgets/button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BackgroundImage(
          widget: Column(children: [
            const SizedBox(height: 50),
            Text(
              'NDIENUANI',
              style: GoogleFonts.robotoCondensed(
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Celebrating the Enuani Culture and People Worldwide',
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            const Button(
              text: 'Get Started',
              route: SignChoiceScreen.routeName,
            ),
            const SizedBox(
              height: 70,
            ),
          ]),
        ),
      ),
    );
  }
}
