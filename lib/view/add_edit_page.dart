// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

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
  Widget get elvButton {
    return SizedBox(
      width: 200,
      height: 42,
      child: ElevatedButton(
        onPressed: () {
          switch (type) {
            case ActionType.addNote:
              //
              break;
            case ActionType.editNote:
              //
              break;
          }
        },
        child: Text(
          type.name == 'addNote' ? 'Submit' : 'Update',
          style: const TextStyle(
            fontSize: 16,

          ),
          )
          ,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                counterText: ''
                ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: noteControl,
            maxLines: 8,
            maxLength: 300,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Note...'),
          ),
          elvButton
        ]),
      ),
    );
  }
}

enum ActionType {
  addNote,
  editNote,
}
