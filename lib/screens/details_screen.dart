import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/content.dart';
import '../widgets/background_image.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = './details-route';
  const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final contentId = ModalRoute.of(context)!.settings.arguments as String;
    final _loadedContent = Provider.of<Contents>(context, listen: false)
        .findContentById(contentId);
    return Scaffold(
      body: SafeArea(
        child: BackgroundImage(
          widget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: theme.primary,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primary,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      alignment: Alignment.center,
                      child: Column(children: [
                        Text(
                          _loadedContent.name,
                          style: GoogleFonts.roboto(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _loadedContent.details,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                          ),
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
