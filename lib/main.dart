import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/api/todo_api.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/pages/todos_page.dart';

void main() {
  final dio = Dio();
  final todosApi = TodosApi(dio);
  runApp(MainApp(todosApi: todosApi));
}

class MainApp extends StatelessWidget {
  final TodosApi todosApi;
  const MainApp({super.key, required this.todosApi});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(todosApi: todosApi)..getAllTodos(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TodosApp',
        
        theme: ThemeData(
        scaffoldBackgroundColor:  Colors.black, 
      ),
      home: const TodosPage(),
      ),
    );
  }
}
