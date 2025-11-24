import "dart:core";

class Task {
  // public fields
  int id;
  String title;
  String? description;
  bool isComplete = false;

  // constructors
  Task({required this.id, required this.title, this.description});

  // methods
  void information() {
    print("Title: $title");
  }
}

class TaskManager {
  // private fields
  final List<Task> _tasks = [];
  int _taskCounter = 0;

  // constructors
  TaskManager(String title, String? description) {
    add(title, description);
  }

  // methods
  void add(String title, String? description) {
    Task? foundTask = search(title);
    if(foundTask == null) {
      _tasks.add(Task(
        id: _taskCounter,
        title: title,
        description: description ?? "No Description"
      ));
      _taskCounter += 1;
    } else {
      print("Can't add. The title is used");
    }
  }
  Task? search(String title) {
    try {
      Task? searchedTask = _tasks.firstWhere(
        (task) => task.title == title, 
        orElse: () => throw Exception("Title not found"),
      );
      searchedTask.information();
      return searchedTask;
    } catch(e) {
      return null;
    }
  }
  void edit(String title, String? description) {
    Task? searchedTask = search(title);
    if(searchedTask != null) {
      searchedTask.description = description ?? searchedTask.description;
      searchedTask.isComplete = true;
    }
  }
  void remove(String title) {
    Task? foundTask = search(title);
    if(foundTask != null) {
      _tasks.remove(foundTask);
    }
  }
}

void main() {
  var tasks = TaskManager("This is title", null);
  Task? foundTask = tasks.search("This is title");
  if(foundTask != null) {
    foundTask.description = "Here, this is description";
  }

  tasks.add("title 2", "description 2");
  tasks.add("title 2", "description 3");
  tasks.add("title 3", "description 4");

  tasks.remove("This is title");
  Task? foundTask2 = tasks.search("This is title");
  if(foundTask2 != null) {
    print(foundTask2.title);
    print(foundTask2.description);
    print(foundTask2.isComplete);
  }

  tasks.edit("title 2", null);
  foundTask2 = tasks.search("title 2");
  if(foundTask2 != null) {
    print(foundTask2.title);
    print(foundTask2.description);
    print(foundTask2.isComplete);
  }
}