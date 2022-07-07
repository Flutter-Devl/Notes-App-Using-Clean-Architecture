
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable  {
  String? noteId;
  String? note;
  String? uid;
  Timestamp? time;

  NoteEntity({this.noteId, this.note, this.uid, this.time});

  @override
  // TODO: implement props
  List<Object?> get props => [
    noteId,
    note,
    uid,
    time,
  ];
}