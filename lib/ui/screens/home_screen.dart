import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/state/bloc/note_bloc.dart';
import 'package:notes_app/state/bloc/note_event.dart';
import 'package:notes_app/state/bloc/note_state.dart';

final List<Color> noteColors = [
  Color(0xFFFFB3BA),
  Color(0xFFFFDFBA),
  Color(0xFFFFFFBA),
  Color(0xFFBAFFC9),
  Color(0xFFBAE1FF),
  Color(0xFFE1BAFF),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 0,
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
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
                        final random = Random();
                        final bgColor =
                            noteColors[random.nextInt(noteColors.length)];
                        return Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ListTile(
                            title: Text(
                              note.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              note.description,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Colors.black,
                                  onPressed: () {
                                    showEditNote(
                                      context,
                                      note.id!,
                                      note.title,
                                      note.description,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.black,
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
        backgroundColor: Color(0xFF26A69A),
        foregroundColor: Colors.white,
        elevation: 6,
        child: Icon(Icons.add, size: 28),
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
      backgroundColor: Colors.grey[900],
      title: Text("Add Note"),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: addTitleController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              hintText: "Add a title...",
              hintStyle: TextStyle(fontSize: 18, color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: addDescriptionController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              hintText: "Add a description...",
              hintStyle: TextStyle(fontSize: 18, color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
            ),
            maxLines: 10,
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
          child: Text("Ok", style: TextStyle(color: Colors.teal[600])),
        ),
      ],
    ),
  );
}

void showEditNote(
  BuildContext context,
  int id,
  String oldTitle,
  String oldDescription,
) {
  final editTitleController = TextEditingController(text: oldTitle);
  final editDescriptionController = TextEditingController(text: oldDescription);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text("Edit Note"),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: editTitleController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              hintText: "Update the title",
              hintStyle: TextStyle(fontSize: 18, color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: editDescriptionController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[850],
              hintText: "Update the description",
              hintStyle: TextStyle(fontSize: 18, color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
            ),
            maxLines: 10,
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
              EditNote(
                id: id,
                title: editTitleController.text,
                description: editDescriptionController.text,
              ),
            );
            Navigator.pop(context);
          },
          child: Text("Ok", style: TextStyle(color: Colors.teal[600])),
        ),
      ],
    ),
  );
}
