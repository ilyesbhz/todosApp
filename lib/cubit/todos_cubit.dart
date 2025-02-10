import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/api/todo_api.dart';
import 'package:todos_app/models/todo.dart';


part 'todos_state.dart';

class TodosCubit extends Cubit<List<Todo>> {
  final TodosApi todosApi;
  TodosCubit({required this.todosApi}) : super([]);

  Future<void> getAllTodos() async {
    try {
      final todos = await todosApi.getAllTodos();
      emit(todos); // Update the state with the fetched todos
    } catch (e) {
      emit([]); // Emit an empty list in case of an error
      print("Failed to fetch todos: $e");
    }
  }
  void toggleTodoCompletion(int id) {
    final updatedTodos = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completed: !todo.completed);  // Use copyWith
      }
      return todo;
    }).toList();

    emit(updatedTodos);
  }
}
