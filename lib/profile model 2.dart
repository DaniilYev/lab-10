part of 'profile_model.dart';

/// **************************************************************************
/// JsonSerializableGenerator
/// **************************************************************************

/// Creates a Profile object from a JSON map.
Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      userId: (json['userId'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
    );

/// Converts a Profile instance into a JSON map.
Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
