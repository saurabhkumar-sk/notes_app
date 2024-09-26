part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class LoadNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final Note note;
  AddNote(this.note);
}

class DeleteNote extends NotesEvent {
  final int id;
  DeleteNote(this.id);
}

class EditNote extends NotesEvent {
  final int id;
  final Note updatedNote;
  EditNote(this.id, this.updatedNote);
}
