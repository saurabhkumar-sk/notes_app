import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notesapp/widgets/database.dart';
import 'package:notesapp/model/note_model.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteDatabase database;

  NotesBloc(this.database) : super(const NotesState([])) {
    on<LoadNotes>((event, emit) async {
      final notes = await database.readAllNotes();
      emit(NotesState(notes));
    });

    on<AddNote>((event, emit) async {
      await database.create(event.note);
      final notes = await database.readAllNotes();
      emit(NotesState(notes));
    });

    on<DeleteNote>((event, emit) async {
      await database.delete(event.id);
      final notes = await database.readAllNotes();
      emit(NotesState(notes));
    });

    on<EditNote>((event, emit) async {
      await database.update(event.id, event.updatedNote); // Update the note in the database
      final notes = await database.readAllNotes(); // Read all notes after the update
      emit(NotesState(notes)); // Emit the updated state
    });
  }
}
