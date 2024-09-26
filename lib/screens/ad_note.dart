// lib/views/add_note_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/model/note_model.dart';
import '../note_bloc/bloc/notes_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;

                if (widget.note == null) {
                  // Adding a new note
                  final newNote = Note(
                    title: title,
                    content: content,
                  );
                  context.read<NotesBloc>().add(AddNote(newNote));
                } else {
                  // Updating an existing note
                  final updatedNote = Note(
                    id: widget.note!.id, // Keep the existing ID
                    title: title,
                    content: content,
                  );
                  context
                      .read<NotesBloc>()
                      .add(EditNote(widget.note!.id!, updatedNote));
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
