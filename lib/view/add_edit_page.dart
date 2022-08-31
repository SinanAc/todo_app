// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/note_model/note_model.dart';

class AddAndEditPage extends StatelessWidget {
  final subControl = TextEditingController();
  final noteControl = TextEditingController();
  final ActionType type;
  String? id;
  AddAndEditPage({
    Key? key,
    required this.type,
    this.id,
  }) : super(key: key);
  Widget elvButton(context) {
    return SizedBox(
      width: 200,
      height: 42,
      child: ElevatedButton(
        onPressed: () {
          switch (type) {
            case ActionType.addNote:
              // save note function
              submitNote(context);
              break;
            case ActionType.editNote:
              // save edited note function
              saveEditedNote(context);
              break;
          }
        },
        child: Text(
          type.name == 'addNote' ? 'Submit' : 'Update',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (type == ActionType.editNote) {
      if (id == null) {
        Navigator.of(context).pop();
      }
      final note = NoteDB().getNoteByID(id!);
      if (note == null) {
        Navigator.of(context).pop();
      }
      subControl.text = note!.title ?? "No title";
      noteControl.text = note.content ?? "No content";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(type.name == 'addNote' ? 'Add Note' : 'Update Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        child: Column(children: [
          TextField(
            controller: subControl,
            maxLength: 20,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Subject',
                counterText: ''),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: noteControl,
            maxLines: 8,
            maxLength: 300,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Note...'),
          ),
          elvButton(context)
        ]),
      ),
    );
  }

  Future<void> submitNote(ctx) async {
    final subject = subControl.text;
    final note = noteControl.text;
    final newNot = NoteModel.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: subject,
        content: note);

    final noteContent = await NoteDB().createNote(newNot);
    if (noteContent != null) {
      await NoteDB().getAllNotes();
      Navigator.of(ctx).pop();
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text(
            'Error while saving note',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 206, 83, 75),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> saveEditedNote(ctx) async {
    final title = subControl.text;
    final note = noteControl.text;
    final editedNote =NoteModel.create(
      id: id, 
      title: title, 
      content: note
      );
    final editedNoteCompleted = await NoteDB().updateNote(editedNote); 
    if(editedNoteCompleted!=null){
     Navigator.of(ctx).pop();
    }else{
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text(
            'Error while editing note',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 206, 83, 75),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );      
    }
  }
}

enum ActionType {
  addNote,
  editNote,
}
