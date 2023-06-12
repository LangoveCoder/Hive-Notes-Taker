// ignore_for_file: must_be_immutable, camel_case_types, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../Models/model.dart';

class editPage extends StatefulWidget {
  editPage({this.Database, Key? key}) : super(key: key);
  database? Database;
  @override
  State<editPage> createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController title_text = TextEditingController(
        text: widget.Database == null ? null : widget.Database!.title);
    TextEditingController desc_text = TextEditingController(
        text: widget.Database == null ? null : widget.Database!.description);

    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Container(
        height: 308,
        child: Column(
          children: [
            Text(
              widget.Database == null ? "Add New Note" : "Update your Note",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoTextField(
              controller: title_text,
              placeholder: 'Title',
            ),
            SizedBox(
              height: 10,
            ),
            CupertinoTextField(
              controller: desc_text,
              placeholder: 'Details',
              maxLines: 9,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              height: 35,
              child: MaterialButton(
                onPressed: () async {
                  var newnote = database(
                      title: title_text.text,
                      description: desc_text.text,
                      create_date: DateTime.now());
                  Box<database> notebox = Hive.box<database>('Database');
                  if (widget.Database != null) {
                    widget.Database!.title = newnote.title;
                    widget.Database!.description = newnote.description;
                    widget.Database!.create_date = newnote.create_date;
                    widget.Database!.save();
                    title_text.clear();
                    desc_text.clear();
                    Navigator.of(context).pop();
                  } else {
                    await notebox.add(newnote);
                    title_text.clear();
                    desc_text.clear();
                    Navigator.of(context).pop();
                  }
                },
                child: Center(
                    child: Text(widget.Database == null ? "Save" : "Update",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
