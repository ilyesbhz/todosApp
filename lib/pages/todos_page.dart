import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/cubit/todos_cubit.dart';
import 'package:todos_app/models/todo.dart';
import 'package:todos_app/pages/done_page.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  String selectedFilter = "InQueue";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(18, 18, 18, 1),
        title: const Center(
          child: Text(
            'Index',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF363636),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 6),
                      Text(
                        selectedFilter,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.white,
                        ),
                        color: const Color(0xFF363636),
                        onSelected: (value) {
                          setState(() {
                            selectedFilter = value;
                          });
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                              value: "InQueue",
                              child: Text(
                                "In Queue",
                                style: TextStyle(color: Colors.white),
                              )),
                          PopupMenuItem(
                              value: "Completed",
                              child: Text(
                                "Completed",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodosCubit, List<Todo>>(
              builder: (context, todos) {
                if (todos.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<Todo> filteredTodos = todos.where((todo) {
                  bool matchesFilter = selectedFilter == "InQueue"
                      ? !todo.completed
                      : selectedFilter == "Completed"
                          ? todo.completed
                          : true;
                  bool matchesSearch =
                      todo.title.toLowerCase().contains(searchQuery);
                  return matchesFilter && matchesSearch;
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
                          return TaskItem(todo);
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
                  Icon(Icons.home, color: Colors.blue),
                  Text("Index",
                      style: TextStyle(fontSize: 10, color: Colors.blue)),
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
                  Icon(Icons.task, color: Colors.white),
                  Text("Tasks Done",
                      style: TextStyle(fontSize: 10, color: Colors.white)),
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
                leading: GestureDetector(
                  onTap: () {
                    context.read<TodosCubit>().toggleTodoCompletion(todo.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DonePage(latestCompletedTaskId: todo.id)),
                    );
                  },
                  child: Icon(
                    todo.completed ? Icons.check_circle : Icons.circle_outlined,
                    color: todo.completed ? Colors.green : Colors.white70,
                  ),
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    decoration:
                        todo.completed ? TextDecoration.lineThrough : null,
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
          Positioned(
            bottom: 12,
            right: 16,
            child: Wrap(
              spacing: 8,
              children: [
                _buildLabel(Icons.category, "Category", Colors.blue),
                _buildLabel(Icons.flag, "Priority", Colors.grey[850]!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
