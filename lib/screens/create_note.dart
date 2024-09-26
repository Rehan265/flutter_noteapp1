import 'package:flutter/material.dart';
import 'package:myapp/providers/notes_provider.dart';
import 'package:myapp/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({
    super.key,
  });

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerDescription =
      TextEditingController();

  @override
  void dispose() {
    textEditingControllerTitle.dispose();
    textEditingControllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            CustomTextField(
              controller: textEditingControllerTitle,
              title: "Title",
              fontSize: 24,
            ),
            CustomTextField(
              controller: textEditingControllerDescription,
              title: "Description",
              fontSize: 18,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Map note = {
            "title": textEditingControllerTitle.text,
            "content": textEditingControllerDescription.text
          };
          String msg = "";

          if (note["title"] == "" && note["content"] == "") {
            msg = "Cannot create an empty note";
          } else {
            Provider.of<NotesProvider>(context, listen: false).addNote(note);
            msg = "Note Created Successfully ";
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
            ),
          );
          textEditingControllerTitle.text = "";
          textEditingControllerDescription.text = "";
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
