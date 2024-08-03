import 'package:json_annotation/json_annotation.dart';

part 'brick.g.dart';

@JsonSerializable()
class Brick {
  final String heading;
  final String message;
  final DateTime time; // Changed from TimeOfDay to DateTime
  final int intervalDays;
  bool isActive;

  Brick({
    required this.heading,
    required this.message,
    required this.time,
    required this.intervalDays,
    this.isActive = true,
  });

// Add a method to convert to JSON and from JSON if needed



  factory Brick.fromJson(Map<String, dynamic> json) => _$BrickFromJson(json);
  Map<String, dynamic> toJson() => _$BrickToJson(this);
}
