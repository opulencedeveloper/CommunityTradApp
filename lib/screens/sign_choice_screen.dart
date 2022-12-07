import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/button.dart';
import '../widgets/background_image.dart';
import '../screens/signin_screen.dart';
import '../screens/signup_screen.dart';

class SignChoiceScreen extends StatelessWidget {
  static const routeName = "sign-route";
  const SignChoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
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
            const Spacer(),
            const Button(
              text: 'Sign In',
              route: SignInScreen.routeName,
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 54,
              width: 194,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.primary, width: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
          ]),
        ),
      ),
    );
  }
}
