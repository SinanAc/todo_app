import 'package:flutter/material.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/note_model/note_model.dart';
import 'package:todo/view/add_edit_page.dart';
import 'package:todo/view/widgets/note_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await NoteDB().getAllNotes();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: noteListNotifier, 
          builder: (ctx,List<NoteModel>newNotes,_){
            if(newNotes.isEmpty){
              return const Center(
                child:Text('Note list is empty !!')
              );
            }
            return ListView.separated(
            itemBuilder: ((context, index) {
              final note = noteListNotifier.value[index];
              if (note.id == null) {
                return const SizedBox();
              }
              return NoteItem(
                  id: note.id!,
                  title: note.title??'No title !!',
                  note: note.content??'No content !!');
            }),
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 2);
            },
            itemCount: newNotes.length
            );
          }
          )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => AddAndEditPage(
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
