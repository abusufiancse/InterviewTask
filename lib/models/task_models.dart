enum TaskStatus {
  NotStarted,
  InProgress,
  InReview,
  Cancelled,
  Complete,
}

class Task {
  final int? id;
  final String title;
  final String description;
  final TaskStatus status;

  Task({
    required this.title,
    required this.description,
    required this.status,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status.toString().split('.').last,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: _convertStringToTaskStatus(map['status']),
    );
  }

  static TaskStatus _convertStringToTaskStatus(String status) {
    return TaskStatus.values
        .firstWhere((e) => e.toString() == 'TaskStatus.$status');
  }
}
