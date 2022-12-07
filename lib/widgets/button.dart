import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final String route;
  const Button({required this.text, required this.route, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: 194,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            route,
          );
        },
        child: Text(
          text,
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
    );
  }
}
