import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/api/todo_api.dart';

import '../models/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosApi todosApi;
  TodosBloc({required this.todosApi}) : super(LoadingState()) {
    on<TodosEvent>((event, emit) async {
      if (event is GetAllTodosEvent) {
        //loading state
        emit(LoadingState());
        try {
          final todos = await todosApi.getAllTodos();
          emit(LoadedState(todos));
        } catch (e) {
          emit(ErrorState("something went wrong"));
        }
        //call api
        //loaded or error
      }
    });
  }
}
