import '../models/todo.dart';
import 'package:dio/dio.dart';

class TodosApi {
  final Dio _dio = Dio();

  TodosApi(Dio dio);
  Future<List<Todo>> getAllTodos() async {
    try {
      const String url = "https://jsonplaceholder.typicode.com/todos";
      var response = await _dio.get(url);

      List<Todo> todos = (response.data as List)
          .map<Todo>((jsonTodo) => Todo.fromJson(jsonTodo))
          .toList();
      return todos;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
      rethrow;
    }
  }
}
