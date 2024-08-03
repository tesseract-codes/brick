// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brick.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brick _$BrickFromJson(Map<String, dynamic> json) => Brick(
      heading: json['heading'] as String,
      message: json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      intervalDays: json['intervalDays'] as int,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$BrickToJson(Brick instance) => <String, dynamic>{
      'heading': instance.heading,
      'message': instance.message,
      'time': instance.time.toIso8601String(),
      'intervalDays': instance.intervalDays,
      'isActive': instance.isActive,
    };
