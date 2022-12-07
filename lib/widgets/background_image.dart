import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget widget;
  const BackgroundImage({required this.widget, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/background_image.png"),
            fit: BoxFit.cover),
      ),
      child: widget,
    );
  }
}
