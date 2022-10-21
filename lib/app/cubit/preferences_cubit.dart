import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'preferences.dart';

class PreferencesCubit extends HydratedCubit<Preferences> {
  PreferencesCubit() : super(const Preferences(onlyImages: true));

  void toogleOnlyImages({required bool onlyImages}) =>
      emit(state.copyWith(onlyImages: onlyImages));

  @override
  Preferences? fromJson(Map<String, dynamic> json) => Preferences.fromMap(json);

  @override
  Map<String, dynamic>? toJson(Preferences state) => state.toMap();
}
