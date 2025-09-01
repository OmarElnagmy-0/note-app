import 'package:notes_app/data/models/note_model.dart';

class NoteState {
  final List<Note> notes;

  NoteState({required this.notes});
}

final class NotesInitial extends NoteState {
  NotesInitial() : super(notes: []);
}
