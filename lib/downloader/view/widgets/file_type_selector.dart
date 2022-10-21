import 'package:file_downloader/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileTypeSelector extends StatelessWidget {
  const FileTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesCubit = context.watch<PreferencesCubit>();
    final downloadImagesOnly = preferencesCubit.state.onlyImages;

    return Row(
      children: [
        if (downloadImagesOnly) ...[
          _oButton('All supported types', preferencesCubit, false),
          const SizedBox(width: 10),
          _eButton('Only images', preferencesCubit, true),
        ] else ...[
          _eButton('All supported types', preferencesCubit, false),
          const SizedBox(width: 10),
          _oButton('Only images', preferencesCubit, true),
        ]
      ],
    );
  }

  Widget _eButton(
    String text,
    PreferencesCubit preferences,
    bool setOnlyImages,
  ) =>
      Expanded(
        child: ElevatedButton(
          onPressed: () =>
              preferences.toogleOnlyImages(onlyImages: setOnlyImages),
          child: Text(text),
        ),
      );
  Widget _oButton(
    String text,
    PreferencesCubit preferences,
    bool setOnlyImages,
  ) =>
      Expanded(
        child: OutlinedButton(
          onPressed: () =>
              preferences.toogleOnlyImages(onlyImages: setOnlyImages),
          child: Text(text),
        ),
      );
}
