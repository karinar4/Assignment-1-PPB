import 'package:flutter/material.dart';
import 'note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback deleteNote;
  final Function(Note) editNote;

  NoteCard({required this.note, required this.deleteNote, required this.editNote});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      color: Color(0xFFe0faff),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                note.content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () => editNote(note),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.blueAccent),
                  onPressed: deleteNote,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
