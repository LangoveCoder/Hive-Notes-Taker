// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class database extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late DateTime create_date;

  database(
      {required this.title,
      required this.description,
      required this.create_date});
}
