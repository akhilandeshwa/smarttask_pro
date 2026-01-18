import 'package:flutter/material.dart';

void main() => runApp(SmartTaskProApp());

class SmartTaskProApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartTask Pro',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      home: TaskScreen(),
    );
  }
}

class Task {
  String id;
  String title;
  bool isCompleted;
  String category;
  
  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.category,
  });
}

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(id: '1', title: 'Learn Flutter State Management', category: 'Study'),
    Task(id: '2', title: 'Practice Typing Speed', category: 'Daily', isCompleted: true),
    Task(id: '3', title: 'Build Portfolio App', category: 'Project'),
  ];
  
  final TextEditingController _controller = TextEditingController();
  String selectedCategory = 'Personal';

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          id: DateTime.now().toString(),
          title: _controller.text,
          category: selectedCategory,
        ));
        _controller.clear();
      });
    }
  }

  void _toggleTask(String id) {
    setState(() {
      final taskIndex = tasks.indexWhere((task) => task.id == id);
      tasks[taskIndex].isCompleted = !tasks[taskIndex].isCompleted;
    });
  }

  void _deleteTask(String id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  List<Task> get _completedTasks => tasks.where((t) => t.isCompleted).toList();
  List<Task> get _pendingTasks => tasks.where((t) => !t.isCompleted).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('SmartTask Pro', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          Chip(
            label: Text('${tasks.length}', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.orange,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Stats Cards
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatCard('Pending', '${_pendingTasks.length}', Colors.orange),
                SizedBox(width: 12),
                _buildStatCard('Done', '${_completedTasks.length}', Colors.green),
              ],
            ),
          ),
          
          // Add Task Form
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              children: [
                // NEW - Replace with this:
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      SizedBox(
        width: 200, // Fixed width for smaller screens
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'What needs to be done?',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(Icons.add, color: Colors.teal),
          ),
          onSubmitted: (_) => _addTask(),
        ),
      ),
      SizedBox(width: 12),
      ElevatedButton(
        onPressed: _addTask,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    ],
  ),
),

                SizedBox(height: 12),
               // NEW:
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: ['Personal', 'Work', 'Study', 'Daily']
        .map((cat) => Padding(
                padding: EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: selectedCategory == cat,
                  onSelected: (selected) => setState(() {
                    selectedCategory = cat;
                  }),
                  selectedColor: Colors.teal[100],
                ),
              ))
        .toList(),
  ),
),

              ],
            ),
          ),

          // Tasks List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (_) => _deleteTask(task.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) => _toggleTask(task.id),
                        activeColor: Colors.teal,
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.w500,
                        ),
                      ),
                      subtitle: Chip(
                        label: Text(task.category),
                        backgroundColor: _getCategoryColor(task.category),
                      ),
                      trailing: task.isCompleted
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Work': return Colors.blue;
      case 'Study': return Colors.purple;
      case 'Daily': return Colors.orange;
      default: return Colors.teal;
    }
  }
}
