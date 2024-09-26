import 'package:flutter/material.dart';
import 'package:myapp/providers/notes_provider.dart';
import 'package:myapp/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class UpdateNote extends StatefulWidget {
  final int index;
  final Map note;
  const UpdateNote({super.key, required this.index, required this.note});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
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
  void initState() {
    textEditingControllerTitle.text = widget.note["title"];
    textEditingControllerDescription.text = widget.note["content"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Note",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              fontSize: 20,
            ),
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
            msg = "Cannot update an empty note";
          } else {
            Provider.of<NotesProvider>(context, listen: false)
                .updateNote(widget.index, note);
            msg = "Note Update Successfully ";
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
