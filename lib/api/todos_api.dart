import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/todo.dart';

part 'todos_api.g.dart';  // Generated file

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class TodosApi {
  factory TodosApi(Dio dio, {String baseUrl}) = _TodosApi;

  @GET("/todos")
  Future<List<Todo>> getAllTodos();
}