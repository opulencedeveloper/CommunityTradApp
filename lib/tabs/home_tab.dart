import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/details_screen.dart';
import '../provider/content.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final myContent = Provider.of<Contents>(context);
    final _allContent = myContent.content;
    return ListView.builder(
      itemCount: _allContent.length,
      itemBuilder: (context, i) => _allContent[i].videoType == 'Text'
          ? Container(
              color: Colors.white,
              height: 270,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _allContent[i].name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 328,
                    height: 137,
                    child: Image.network(_allContent[i].image),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                      ),
                      Text(
                        ' 25 mins',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xff9E9E9E),
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 24,
                        width: 94,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                DetailsScreen.routeName,
                                arguments: _allContent[i].id);
                          },
                          child: Text(
                            'Continue Reading',
                            style: GoogleFonts.roboto(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          : Container(),
    );
  }
}
