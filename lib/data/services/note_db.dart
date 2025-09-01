import 'package:notes_app/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDatabase {
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (database, version) {
        return database.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<List<Note>> getNotes() async {
    final db = await openDB();
    final List<Map<String, dynamic>> notes = await db.query('notes');
    return List.generate(notes.length, (index) {
      return Note(
        id: notes[index]['id'],
        title: notes[index]['title'],
        description: notes[index]['description'],
      );
    });
  }

  static Future<void> addNote(Note note) async {
    final db = await openDB();
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> editNote(Note note, int id) async {
    final db = await openDB();
    await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteNote(int id) async {
    final db = await openDB();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
