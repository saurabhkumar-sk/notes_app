import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/note_bloc/bloc/notes_bloc.dart';
import 'package:notesapp/widgets/database.dart';
import 'package:notesapp/screens/home.dart';
import 'package:notesapp/weathbloc/bloc/weather_bloc.dart';
import 'package:notesapp/widgets/weatherapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NotesBloc(NoteDatabase.instance)..add(LoadNotes()),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(
            Repo(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Note App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
