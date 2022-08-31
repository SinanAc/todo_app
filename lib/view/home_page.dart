import 'package:flutter/material.dart';
import 'package:todo/view/add_edit_page.dart';
import 'package:todo/view/widgets/note_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            itemBuilder: ((context, index) {
              return NoteItem(
                  id: index,
                  title: 'New Note',
                  note:
                      'New note added now. If you want to update tap here to go to edit screen. All features are done by http methods and will be updated sooon');
            }),
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 2);
            },
            itemCount: 10),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>  AddAndEditPage(
                      type: ActionType.addNote,
                    )));
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
