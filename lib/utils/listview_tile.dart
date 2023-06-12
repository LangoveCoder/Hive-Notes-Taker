// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, duplicate_ignore, must_be_immutable, camel_case_types, non_constant_identifier_names, prefer_const_constructors
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_project/Models/model.dart';

import '../Pages/editpage.dart';

import 'dart:math';

class listviewTile extends StatefulWidget {
  database Database;
  int index;

  listviewTile({
    Key? key,
    required this.Database,
    required this.index,
  }) : super(key: key);

  @override
  State<listviewTile> createState() => _listviewTileState();
}

class _listviewTileState extends State<listviewTile> {
  final _random = Random();

  Color _generateRandomColor() {
    return Color.fromARGB(
      50,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  Color _generateLighterShade(Color color) {
    final hsvColor = HSVColor.fromColor(color);
    final lighterHsvColor = hsvColor.withValue(0.6 * hsvColor.value);
    return lighterHsvColor.toColor();
  }

  void onClick() {
    showDialog(
        context: context,
        builder: (context) {
          return editPage(
            Database: widget.Database,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Color = _generateRandomColor();

    return Padding(
        padding: const EdgeInsets.all(12),
        child: GestureDetector(
            onTap: () {
              onClick();
            },
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      widget.Database.delete();
                    },
                    borderRadius: BorderRadius.circular(12),
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              child: Expanded(
                flex: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      color: _generateLighterShade(Color),
                      borderRadius: BorderRadius.circular(12)),
                  child: Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Title and description in a single column
                            Expanded(
                              
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.Database.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  //description
                                  Expanded(
                                    child: Text(widget.Database.description,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                          //fontSize: 16)
                                        )),
                                  )
                                ],
                              ),
                            ),

                            //Date

                            Text(
                                DateFormat('dd/MM hh:mm')
                                    .format(widget.Database.create_date)
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w300,
                                  //fontSize: 16)
                                )),
                          ]),
                    ),
                  ),
                ),
              ),
            )));
  }
}
