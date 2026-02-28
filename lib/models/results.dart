import 'package:json_annotation/json_annotation.dart';

part 'results.g.dart';

@JsonSerializable(genericArgumentFactories: true)

class Result<T> {
  final bool success;
  final String message;
  T? data;

  Result({required this.success, required this.message, this.data});

  /// Connect the generated [_$ResultFromJson] function to the `fromJsonT`
  /// factory.
  factory Result.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$ResultFromJson(json, fromJsonT);

  /// Connect the generated [_$ResultToJson] function to the `toJsonT` method.
  Map<String, dynamic> toJson(Object Function(T value) toJsonT)
  => _$ResultToJson(this, toJsonT);

}