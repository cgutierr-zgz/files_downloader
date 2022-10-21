// ignore_for_file: sort_constructors_first

part of 'preferences_cubit.dart';

@immutable
class Preferences extends Equatable {
  const Preferences({
    required this.onlyImages,
  });

  final bool onlyImages;

  Preferences copyWith({
    bool? onlyImages,
  }) {
    return Preferences(
      onlyImages: onlyImages ?? this.onlyImages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'onlyImages': onlyImages,
    };
  }

  factory Preferences.fromMap(Map<String, dynamic> map) {
    return Preferences(
      onlyImages: map['onlyImages'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Preferences.fromJson(String source) =>
      Preferences.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [onlyImages];
}
