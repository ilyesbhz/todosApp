import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';  // Generated file
part 'todo.g.dart';  // Generated file for JSON serialization

@freezed
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required String title,
    required bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}