import argv

import gleam/int

import gleam/io

import gleam/list

import task.{Task, type Task}

fn display_tasks(tasks: List(Task)) -> Nil {
  tasks
    |> list.map(fn(x) -> String {"[" <> int.to_string(x.id) <> "]" <> "  " <> task.to_string(x)})
    |> list.each(io.println)
}

pub fn cli_remove(tasks: List(Task), id: Int) -> List(Task) {
  let assert Ok(task_to_remove) = tasks
    |> list.filter(fn(t) {t.id == id})
    |> list.first
  tasks
    |> list.filter(fn(t) {t != task_to_remove})
}

pub fn cli_add(tasks: List(Task), description: String, status: String) -> List(Task) {
  let st = case status {
    "pending" -> task.Pending
    "in_progress" -> task.InProgress
    "done" -> task.Done
    _ -> task.Pending
  }
  let task_to_add = Task(list.length(tasks), description, st)
  tasks |> list.append([task_to_add])
}

pub fn main() -> Nil {
  let t2 = Task(1, "Buy eggs", task.InProgress)
  let tasks = [
    Task(0, "Buy milk", task.Pending),
    t2,
    Task(2, "Buy bread", task.Done),
  ]
  let tasks = case argv.load().arguments {
    ["add", description, status] -> {
      cli_add(tasks, description, status)
    }
    ["remove", id] -> {
      let assert Ok(id) = int.parse(id)
      cli_remove(tasks, id)
    }
    ["ls"] -> {
      io.println("Listing tasks...")
      tasks
    }
    _ -> {
      io.println("Usage: to_do_terminal add <description>")
      tasks
    }
  }
  display_tasks(tasks)
}