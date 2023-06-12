// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class databaseAdapter extends TypeAdapter<database> {
  @override
  final int typeId = 0;

  @override
  database read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return database(
      title: fields[0] as String,
      description: fields[1] as String,
      create_date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, database obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.create_date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is databaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
