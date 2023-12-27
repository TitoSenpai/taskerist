import 'package:flutter/material.dart';
import '../db/task_database.dart';
import '../model/task.dart';
import '../page/edit_task_page.dart';
import '../page/task_detail_page.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}
class _TaskPageState extends State<TaskPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Today's Task"),
    const Tab(text: 'Report'),
  ];
  late List<Task> tasks = [];
  bool isLoading = false;
  String selectedPage = '';


  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: myTabs.length);
    refreshTask();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future refreshTask() async {
    setState(() => isLoading = true);

    tasks = await TaskDatabase.instance.readAllTask();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Task Tools',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          actions: const [Icon(Icons.search), SizedBox(width: 12)],
        bottom: TabBar(controller: _tabController,
        tabs: myTabs,
        ),

        ),


        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Task Tools',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Add Task'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Messages';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Profile';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  setState(() {
                    selectedPage = 'Settings';
                  });
                },
              ),
            ],
          ),
        ),

    body: TabBarView(
      controller: _tabController,
      children: <Widget>[
        isLoading
            ? const CircularProgressIndicator()
            : tasks.isEmpty
            ? const Text(
          'No Task',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
            : buildNotes2(),
        const Center(child: Text('Tab 2')),
      ],
    ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditTaskPage()),
            );

            refreshTask();
          },
        ),
      );

  Widget buildNotes2() => ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return task.id == null
              ? Container()
              : Card(
                  child: ListTile(
                    title: Text(task.taskName),
                    subtitle: Text(task.description),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TaskDetailPage(taskId: task.id!),
                      ));

                      refreshTask();
                    },
                  ),
                );
        },
      );
}
