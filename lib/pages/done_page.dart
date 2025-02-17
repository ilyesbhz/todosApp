import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/models/todo.dart';
import 'package:todos_app/pages/todos_page.dart';

class DonePage extends StatefulWidget {
  final int? latestCompletedTaskId;
  const DonePage({super.key, this.latestCompletedTaskId});

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  String searchQuery = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(18, 18, 18, 1),
        title: const Center(
          child: Text(
            'Tasks Done',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/6020066?v=4'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: "Search for your task...",
                hintStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFF363636),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TodosCubit, List<Todo>>(
              builder: (context, todos) {
                if (todos.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Todo> completedTodos =
                    todos.where((todo) => todo.completed).toList();

                Todo? latestCompletedTask = completedTodos.isNotEmpty
                    ? completedTodos.firstWhere(
                        (todo) => todo.id == widget.latestCompletedTaskId,
                        orElse: () => completedTodos.first,
                      )
                    : null;

                List<Todo> filteredTodos = completedTodos.where((todo) {
                  return todo.title.toLowerCase().contains(searchQuery);
                }).toList();

                return filteredTodos.isEmpty
                    ? const Center(
                        child: Text(
                          "No tasks found.",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTodos.length,
                        itemBuilder: (context, index) {
                          final todo = filteredTodos[index];

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: todo.id == widget.latestCompletedTaskId
                                  ? Colors.blue.withOpacity(0.3)
                                  : Colors.transparent,
                              border: todo.id == widget.latestCompletedTaskId
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : null,
                            ),
                            child: TaskItem(todo),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF363636),
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TodosPage()),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, color:Colors.white),
                  Text("Index",
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
            
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonePage()),
                );
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.task, color:  Colors.blue),
                  Text("Tasks Done",
                      style: TextStyle(fontSize: 10, color:  Colors.blue)),
                ],
              ),
            ),
            const SizedBox(width: 40),
            TextButton(
              onPressed: () {},
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time, color: Colors.white),
                  Text("Focus",
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, color: Colors.white),
                  Text("Profile",
                      style: TextStyle(fontSize: 10, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}

class TaskItem extends StatelessWidget {
  final Todo todo;
  const TaskItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Card(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28, right: 8),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                title: Text(
                  todo.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                subtitle: Text(
                  "Completed: ${todo.completed}",
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
