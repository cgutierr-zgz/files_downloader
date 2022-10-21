// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:file_downloader/downloader/downloader.dart';
import 'package:file_downloader/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class DropZone extends StatefulWidget {
  const DropZone({super.key});

  @override
  State<DropZone> createState() => _DropZoneState();
}

class _DropZoneState extends State<DropZone> {
  late final DropzoneViewController controller;
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DownloaderCubit>();

    return Center(
      child: _DropZoneDecoration(
        onHover: onHover,
        child: Stack(
          children: [
            DropzoneView(
              onCreated: (ctrl) => controller = ctrl,
              cursor: onHover ? CursorType.copy : null,
              operation: DragOperation.copy,
              // onLoaded: () {},
              // onError: (ev) {},
              onHover: () => setState(() => onHover = true),
              onDrop: (ev) async {
                final name = await controller.getFilename(ev);
                final data = await controller.getFileData(ev);
                setState(() => onHover = false);
                final added = cubit.addFile(
                  fileName: name,
                  fileContent: data,
                );
                if (!added) {
                  context.showSnackbar(
                    error: true,
                    'File with name "$name" already exists',
                  );
                }
              },
              onLeave: () => setState(() => onHover = false),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Drop your files here'),
                  FilePickerButton(),
                ],
              ),
            ),
          ],
        ).constrain(),
      ),
    );
  }
}

class _DropZoneDecoration extends StatelessWidget {
  const _DropZoneDecoration({
    required this.child,
    required this.onHover,
  });

  final Widget child;
  final bool onHover;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 300,
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: onHover ? Colors.blue.shade100 : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [10, 10],
        color: onHover ? Colors.blue : Colors.grey,
        strokeWidth: 2,
        child: child,
      ),
    );
  }
}
