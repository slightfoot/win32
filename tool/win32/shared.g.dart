// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeDef _$TypeDefFromJson(Map<String, dynamic> json) {
  return TypeDef(
    (json['prototype'] as List).map((dynamic e) => e as String).toList(),
  )
    ..neutralApiName = json['neutralApiName'] as String
    ..nativeReturn = json['nativeReturn'] as String
    ..dartReturn = json['dartReturn'] as String
    ..nativeParams = Map<String, String>.from(json['nativeParams'] as Map)
    ..dartParams = Map<String, String>.from(json['dartParams'] as Map)
    ..dllLibrary = json['dllLibrary'] as String
    ..comment = json['comment'] as String;
}

Map<String, dynamic> _$TypeDefToJson(TypeDef instance) => <String, dynamic>{
      'neutralApiName': instance.neutralApiName,
      'prototype': instance.prototype,
      'nativeReturn': instance.nativeReturn,
      'dartReturn': instance.dartReturn,
      'nativeParams': instance.nativeParams,
      'dartParams': instance.dartParams,
      'dllLibrary': instance.dllLibrary,
      'comment': instance.comment,
    };
