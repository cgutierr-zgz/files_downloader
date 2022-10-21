import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_web_downloader/flutter_web_downloader.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class DownloaderCubit extends HydratedCubit<Map<String, Uint8List>> {
  DownloaderCubit() : super({});

  bool addFile({required String fileName, required Uint8List fileContent}) {
    if (!state.containsKey(fileName)) {
      emit({...state, fileName: fileContent});
      return true;
    }
    return false;
  }

  void deleteFile({required String fileName}) {
    if (state.containsKey(fileName)) {
      final newState = {...state}..remove(fileName);

      emit(newState);
    }
  }

  void deleteAllFiles() => emit({});

  Future<void> downloadAllFiles({
    required bool downloadImagesOnly,
  }) async {
    for (final file in state.entries) {
      await downloadFile(
        fileName: file.key,
        fileContent: file.value,
        downloadImagesOnly: downloadImagesOnly,
      );
    }
  }

  Future<void> downloadFile({
    required String fileName,
    required Uint8List fileContent,
    required bool downloadImagesOnly,
  }) async {
    try {
      await FlutterWebDownloader.downloadUrlsFromFile(
        fileContent,
        downloadImagesOnly: downloadImagesOnly,
      );
    } catch (e) {
      log('Error while downloading file: $fileName', error: e);
    }
    Future.delayed(
      const Duration(milliseconds: 250),
      () => deleteFile(fileName: fileName),
    );
    //deleteFile(fileName: fileName);
  }

  @override
  Map<String, Uint8List>? fromJson(Map<String, dynamic> json) =>
      json.map((key, value) => MapEntry(key, value as Uint8List));

  @override
  Map<String, dynamic>? toJson(Map<String, Uint8List> state) =>
      state.map(MapEntry.new);
}
