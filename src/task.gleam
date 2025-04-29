pub type Status {
  Pending
  InProgress
  Done
}

pub type Task {
  Task(description: String, status: Status)
}

pub fn to_string(task: Task) -> String {
  case task.status {
    Pending -> {
      task.description <> " [Pending]"
    }
    InProgress -> {
      task.description <> " [In Progress]"
    }
    Done -> {
      task.description <> " [Done]"
    }
  }
}
