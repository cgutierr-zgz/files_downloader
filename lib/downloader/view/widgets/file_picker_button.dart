// ignore_for_file: use_build_context_synchronously

import 'package:file_downloader/downloader/downloader.dart';
import 'package:file_downloader/helpers/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilePickerButton extends StatelessWidget {
  const FilePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DownloaderCubit>();

    return TextButton(
      // onHover: (ev) {},
      onPressed: () async {
        final result = await FilePicker.platform.pickFiles(allowMultiple: true);

        if (result != null) {
          for (final file in result.files) {
            if (file.bytes != null) {
              final added = cubit.addFile(
                fileName: file.name,
                fileContent: file.bytes!,
              );
              if (!added) {
                context.showSnackbar(
                  error: true,
                  '''File with name "${file.name}" already exists''',
                );
              }
            }
          }
        } else {
          // User canceled the picker
        }
      },
      child: const Text(
        'or click here to pick files',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
