import 'package:json_annotation/json_annotation.dart';
import 'package:todo/data/note_model/note_model.dart';
part 'get_all_note_response.g.dart';

@JsonSerializable()
class GetAllNoteResponse {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  GetAllNoteResponse({this.data = const []});

  factory GetAllNoteResponse.fromJson(Map<String,dynamic> json) {
    return _$GetAllNoteResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllNoteResponseToJson(this);
}
