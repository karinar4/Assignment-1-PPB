import 'package:flutter/material.dart';
import 'note.dart';
import 'note_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const NotesApp(),
    );
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  _NotesAppState createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  List<Note> notes = [
    Note(title: 'Meeting Notes', content: 'Discuss project milestones'),
    Note(title: 'Grocery List', content: 'Milk, Eggs, Bread'),
  ];

  void _addNote() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Content')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                  setState(() {
                    notes.add(Note(title: titleController.text, content: contentController.text));
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  void _editNote(Note note) {
    TextEditingController titleController = TextEditingController(text: note.title);
    TextEditingController contentController = TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: contentController, decoration: const InputDecoration(labelText: 'Content')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  note.title = titleController.text;
                  note.content = contentController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save', style: TextStyle(color: Colors.blueAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 28)),
        backgroundColor: Color(0xFFb6f1fc),
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteCard(
              note: notes[index],
              editNote: _editNote,
              deleteNote: () {
                setState(() {
                  notes.removeAt(index);
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Add Note',
        backgroundColor: Color(0xFFb6f1fc),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
