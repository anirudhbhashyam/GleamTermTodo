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

fn cli_remove(tasks: List(Task), id: Int) -> Nil {
  display_tasks(tasks)
  let assert Ok(task_to_remove) = tasks
    |> list.filter(fn(t) {t.id == id})
    |> list.first
  io.println("Removing task: " <> task.to_string(task_to_remove))
  let tasks = tasks
    |> list.filter(fn(t) {t.id != id})
  display_tasks(tasks)
}

fn cli_add(tasks: List(Task), description: String) -> Nil {
  display_tasks(tasks)
  let tasks = [Task(list.length(tasks), description, task.Pending), ..tasks]
  display_tasks(tasks)
}

pub fn main() -> Nil {
  let t2 = Task(1, "Buy eggs", task.InProgress)
  let tasks = [
    Task(0, "Buy milk", task.Pending),
    t2,
    Task(2, "Buy bread", task.Done),
  ]
  case argv.load().arguments {
    ["add", description] -> {
      cli_add(tasks, description)
    }
    ["remove", id] -> {
      let assert Ok(id) = int.parse(id)
      cli_remove(tasks, id)
    }
    ["ls"] -> display_tasks(tasks)
    _ -> {
      io.println("Usage: to_do_terminal add <description>")
    }
  }
}