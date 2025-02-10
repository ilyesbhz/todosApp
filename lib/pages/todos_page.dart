import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/models/todo.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: BlocBuilder<TodosCubit, List<Todo>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text('Completed: ${todo.completed}', style: TextStyle(color: todo.completed ? Colors.green : Colors.red),),
                trailing: Checkbox(
                  value: todo.completed,
                  onChanged: (value) {
                    context.read<TodosCubit>().toggleTodoCompletion(todo.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}