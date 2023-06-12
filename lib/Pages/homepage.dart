// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, sort_child_properties_last, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/Models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/Pages/editpage.dart';
import 'package:hive_project/utils/gridview_tile.dart';
import 'package:hive_project/utils/listview_tile.dart';

import '../Models/model.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
//function to handle the dialoguebox
  void onClick() {
    showDialog(
        context: context,
        builder: (context) {
          return editPage();
        });
  }

// sorting function
  bool isGridView = true;
  bool _sortByDate = true;
  void sortNotes() {
    setState(() {
      if (_sortByDate) {
        // Sort by date in descending order (most recent first)
        Hive.box<database>('Database').values.toList()
          ..sort((a, b) => b.create_date.compareTo(a.create_date));
      } else {
        // Sort by title in alphabetical order
        Hive.box<database>('Database').values.toList()
          ..sort((a, b) => a.title.compareTo(b.title));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notely',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[300],
      ),

      // body
      body: ValueListenableBuilder<Box<database>>(
          valueListenable: Hive.box<database>('Database').listenable(),
          builder: (context, box, _) {
            return isGridView
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: box.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      database currentitem = box.getAt(index)!;
                      return gridviewTile(
                        Database: currentitem,
                        index: index,
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (BuildContext context, int index) {
                      database currentitem = box.getAt(index)!;
                      return listviewTile(
                        Database: currentitem,
                        index: index,
                      );
                    });
          }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        onPressed: () {
          onClick();
        },
        child: Icon(
          Icons.note,
        ),
        elevation: 0.0,
      ),
      // bottom navigation bar

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sort),
            label: _sortByDate ? 'Sort by Title' : 'Sort by Date',
          ),
          BottomNavigationBarItem(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            label: isGridView ? 'List View' : 'Grid View',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            // Handle sort button press
            setState(() {
              _sortByDate = !_sortByDate;
            });
            sortNotes();
          } else if (index == 1) {
            // Toggle view mode
            setState(() {
              isGridView = !isGridView;
            });
          }
        },
      ),
    );
  }
}
