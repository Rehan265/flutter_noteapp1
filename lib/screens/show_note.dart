import 'package:flutter/material.dart';
import 'package:myapp/providers/notes_provider.dart';
import 'package:myapp/screens/create_note.dart';
import 'package:myapp/screens/update_note.dart';
import 'package:provider/provider.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      const Color(0xFF87CEEB),
      const Color(0xFFFFCBA4),
      const Color(0xFF98FF98),
      const Color(0xFFE6E6FA),
      const Color(0xFFF08080),
    ];
    int colorIndex = -1;

    List<Map> notes = Provider.of<NotesProvider>(context).notes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note app"),
        centerTitle: true,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          Map note = notes[index];
          colorIndex >= colors.length - 1 ? colorIndex = 0 : colorIndex++;
          return GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateNote(
                    note: note,
                    index: index,
                  ),
                ),
              );
            },
            onHorizontalDragUpdate: (details) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete"),
                  content:
                      const Text("Are you sure you want to deklete this ?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<NotesProvider>(context, listen: false)
                            .removeNote(note);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Note Deleted",
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Yes",
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: colors[colorIndex],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text(
                    note["title"],
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    note["content"],
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateNote()));
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
