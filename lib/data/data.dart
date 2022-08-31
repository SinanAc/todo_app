import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo/data/get_all_note_response/get_all_note_response.dart';
import 'package:todo/data/note_model/note_model.dart';
import 'package:todo/data/url.dart';

abstract class ApiCalls {
  // --> CRUD operations
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> updateNote(NoteModel value);
  Future<void> deleteNote(String id);
}
  ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);
class NoteDB implements ApiCalls {

  // --> creating singleton
  // NoteDB.internal();
  // static NoteDB instance = NoteDB.internal();
  // NoteDB fac(){
  //   return instance;
  // }
  // === end of singleton ===
  final dio = Dio();
  final url = Url();

  NoteDB() {
    dio.options = BaseOptions(
      baseUrl: url.baseUrl,
      responseType: ResponseType.plain,
    );
  }
  @override
  Future<NoteModel?> createNote(NoteModel value) async {
    try {
      final result = await dio.post(url.createNote, data: value.toJson());
      final resultJson = jsonDecode(result.data);
      return NoteModel.fromJson(resultJson as Map<String, dynamic>);
    } on DioError catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    final result = await dio.delete(url.deleteNote.replaceFirst('{id}', id));
    if(result.data==null){
      return;
    }
    final index = noteListNotifier.value.indexWhere(
      (note) => note.id==id);
    if(index==-1){
      return;
    }
    noteListNotifier.value.removeAt(index);
    noteListNotifier.notifyListeners();
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final result =
        await dio.get(url.getAllNote);
        
    if (result.data != null) {
      final resultJson = jsonDecode(result.data);
      final getNotes =  GetAllNoteResponse.fromJson(resultJson);
      noteListNotifier.value.clear();
      noteListNotifier.value.addAll(getNotes.data.reversed);
      noteListNotifier.notifyListeners();
      return getNotes.data;
    } else {
      noteListNotifier.value.clear();
      return [];
    }
  }

  @override
  Future<NoteModel?> updateNote(NoteModel value) async {
    final result = await dio.put(
      url.updateNote,
      data:  value.toJson()
      );
    if (result.data==null){
      return null;
    }
    // --> find index
    final index = noteListNotifier.value.indexWhere(
      (note)=>note.id==value.id);
      if(index==-1){
        return null;
      }
    // -->  remove index
    noteListNotifier.value.removeAt(index);
    // -->  add note in that index 
    noteListNotifier.value.insert(index, value);
    noteListNotifier.notifyListeners();
    return value;
  }

  NoteModel? getNoteByID(String id){
    try{
    return noteListNotifier.value.firstWhere((note)=>note.id == id);
    }catch(_){
      return null;
    }
  }
}
