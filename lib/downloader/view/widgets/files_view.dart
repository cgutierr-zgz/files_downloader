import 'dart:typed_data';

import 'package:file_downloader/app/app.dart';
import 'package:file_downloader/downloader/downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilesView extends StatelessWidget {
  const FilesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DownloaderCubit>();
    final preferencesCubit = context.watch<PreferencesCubit>();

    return BlocBuilder<DownloaderCubit, Map<String, Uint8List>>(
      builder: (context, files) {
        return Column(
          children: [
            if (files.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade400,
                      ),
                      onPressed: () => cubit.downloadAllFiles(
                        downloadImagesOnly: preferencesCubit.state.onlyImages,
                      ),
                      child: const Text('Download all'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        foregroundColor: Colors.red,
                      ),
                      onPressed: cubit.deleteAllFiles,
                      child: const Text('Delete all'),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            if (files.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final file in files.entries) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () =>
                                cubit.deleteFile(fileName: file.key),
                          ),
                          Expanded(
                            child: Text(
                              file.key,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text('(${file.value.length} bytes)'),
                          IconButton(
                            icon: const Icon(
                              Icons.download,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () => cubit.downloadFile(
                              fileName: file.key,
                              fileContent: file.value,
                              downloadImagesOnly:
                                  preferencesCubit.state.onlyImages,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              )
          ],
        );
      },
    );
  }
}
