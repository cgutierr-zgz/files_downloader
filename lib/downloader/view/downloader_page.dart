import 'package:file_downloader/downloader/downloader.dart';
import 'package:file_downloader/helpers/extensions.dart';
import 'package:flutter/material.dart';

class DownloaderPage extends StatelessWidget {
  const DownloaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Files Downloader',
                style: theme.textTheme.headline4,
              ).constrain(400),
            ),
            const DropZone().constrain(),
            Column(
              children: [
                const FileTypeSelector().constrain(400),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    '''
How it works:
1. Drag and drop files to the drop zone or pick files from your computer
2. Select file type: All types or only images (Based on Mime Type)
3. Click on "Download all" button or the download icon on the right side of each file
4. We will scan the files for valid URL's and download them as files

Ensure the file(s) has the URLs that you want to download all the files from.
There's no need for a specific file format, as long as the URLs are in the file, we will find them.
                ''',
                    style: theme.textTheme.bodySmall,
                  ).constrain(400),
                ),
                const SizedBox(height: 20),
                const FilesView().constrain(300),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
