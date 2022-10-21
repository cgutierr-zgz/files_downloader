import 'package:file_downloader/downloader/downloader.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const primaryColor = Colors.blueGrey;
  static const secondaryColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DownloaderPage(),
    );
  }
}
