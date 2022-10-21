import 'dart:async';
import 'dart:developer';

import 'package:file_downloader/app/app.dart';
import 'package:file_downloader/downloader/downloader.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  await _setupHydratedBloc(await builder());
}

/// Sets up the hydrated storage for the app and passes over root providers
Future<void> _setupHydratedBloc(Widget child) async {
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorage.webStorageDirectory,
  );
  final observer = AppBlocObserver();

  Bloc.observer = observer;

  return HydratedBlocOverrides.runZoned(
    () async {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => PreferencesCubit(),
              lazy: false,
            ),
            BlocProvider(
              create: (_) => DownloaderCubit(),
              lazy: false,
            ),
          ],
          child: child,
        ),
      );
    },
    storage: storage,
    blocObserver: observer,
  );
}
