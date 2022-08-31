// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_note_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNoteResponse _$GetAllNoteResponseFromJson(Map<String, dynamic> json) =>
    GetAllNoteResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetAllNoteResponseToJson(GetAllNoteResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
