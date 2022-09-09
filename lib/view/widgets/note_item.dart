import 'package:flutter/material.dart';
import 'package:todo/data/data.dart';
import 'package:todo/view/add_edit_page.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {Key? key, required this.id, required this.title, required this.note})
      : super(key: key);
  final String title;
  final String note;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => AddAndEditPage(
              type: ActionType.editNote,
              id: id
              ),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 184, 232, 244),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      NoteDB().deleteNote(id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ]),
              const SizedBox(height: 5),
              Text(
                note,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
