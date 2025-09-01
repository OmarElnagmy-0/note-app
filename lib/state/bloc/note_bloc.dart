import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/data/services/note_db.dart';
import 'package:notes_app/state/bloc/note_event.dart';
import 'package:notes_app/state/bloc/note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NotesInitial()) {
    on<LoadNotes>((event, emit) async {
      final notes = await NoteDatabase.getNotes();
      emit(NoteState(notes: notes));
    });

    on<AddNote>((event, emit) async {
      await NoteDatabase.addNote(
        Note(title: event.title, description: event.description),
      );
      final notes = await NoteDatabase.getNotes();
      emit(NoteState(notes: notes));
    });

    on<EditNote>((event, emit) async {
      await NoteDatabase.editNote(
        Note(title: event.title, description: event.description),
        event.id,
      );
      final notes = await NoteDatabase.getNotes();
      emit(NoteState(notes: notes));
    });

    on<DeleteNote>((event, emit) async {
      await NoteDatabase.deleteNote(event.id);
      final notes = await NoteDatabase.getNotes();
      emit(NoteState(notes: notes));
    });
  }
}
