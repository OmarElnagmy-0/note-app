abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String title;
  final String description;

  AddNote({required this.title, required this.description});
}

class EditNote extends NoteEvent {
  final int id;
  final String title;
  final String description;

  EditNote({required this.id, required this.title, required this.description});
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote({required this.id});
}
