part of 'notes_bloc.dart';

@immutable
// sealed class NotesState {}

class NotesState {
  final List<Note> notes;
  const NotesState(this.notes);
}
