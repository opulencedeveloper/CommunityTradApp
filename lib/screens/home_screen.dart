import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/background_image.dart';
import '../widgets/my_drawer.dart';
import '../tabs/home_tab.dart';
import '../provider/content.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = './home-route';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool screenState = true;
  Future<dynamic>? _allContentFuture;

  Future _obtainAllContentFuture() {
    return Provider.of<Contents>(context, listen: false)
        .fetchAndSetAllContent();
  }

  @override
  void initState() {
    super.initState();
    _allContentFuture = _obtainAllContentFuture();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      bottomNavigationBar: Container(
        height: 53,
        color: theme.primary,
        padding: const EdgeInsets.only(bottom: 20, right: 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    screenState = true;
                  });
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ]),
      ),
      body: SafeArea(
        child: SafeArea(
          child: BackgroundImage(
            widget: FutureBuilder(
              future: _allContentFuture,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: theme.primary,
                  ));
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const HomeTab();
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
