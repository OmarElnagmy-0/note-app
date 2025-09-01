import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/state/bloc/note_bloc.dart';
import 'package:notes_app/state/bloc/note_event.dart';
import 'package:notes_app/state/bloc/note_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state.notes.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/note.png'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "No Notes Yet. \nClick the + button to add a note.",
                          style: TextStyle(fontSize: 24, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ListTile(
                            title: Text(
                              note.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              note.description,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // IconButton(
                                //   icon: Icon(Icons.edit),
                                //   color: Colors.teal[300],
                                //   onPressed: () {
                                //     BlocProvider.of<NoteBloc>(
                                //       context,
                                //     ).add(DeleteNote(id: note.id!));
                                //   },
                                // ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.teal[300],
                                  onPressed: () {
                                    BlocProvider.of<NoteBloc>(
                                      context,
                                    ).add(DeleteNote(id: note.id!));
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNote(context);
        },
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

void showAddNote(BuildContext context) {
  final addTitleController = TextEditingController();
  final addDescriptionController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Add Note"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: addTitleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Add Title",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: addDescriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Add Description",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel", style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<NoteBloc>(context).add(
              AddNote(
                title: addTitleController.text,
                description: addDescriptionController.text,
              ),
            );
            Navigator.pop(context);
          },
          child: Text("Ok", style: TextStyle(color: Colors.green[600])),
        ),
      ],
    ),
  );
}
