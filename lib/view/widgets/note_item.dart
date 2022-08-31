import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {Key? key, required this.id, required this.title, required this.note})
      : super(key: key);
  final String title;
  final String note;
  final int id;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 185, 237, 250),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ]),
            const SizedBox(height: 5),
            Text(
              note,
              // maxLines: 5,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
