import argv

import gleam/int

import gleam/io

import gleam/list

import task.{Task}

fn display_tasks(tasks: List(task.Task)) -> Nil {
  tasks
    |> list.map(task.to_string)
    |> list.index_map(fn(x, i) -> String {"[" <> int.to_string(i) <> "]" <> "  " <> x})
    |> list.each(io.println)
}

fn remove_task(tasks: List(task.Task), task: task.Task) -> List(task.Task) {
  tasks
    |> list.drop_while(
      fn(t) -> Bool {
        t == task
      }
    )
}

pub fn main() -> Nil {
  let t2 = Task("Buy eggs", task.InProgress)
  let tasks = [
    Task("Buy milk", task.Pending),
    t2,
    Task("Buy bread", task.Done),
  ]
  remove_task(tasks, t2)
  display_tasks(tasks)
  case argv.load().arguments {
    ["add", description] -> {
      let task = Task(description, task.Pending)
      let tasks = [task, ..tasks]
      io.println("Added task: " <> description) 
      tasks
        |> list.map(task.to_string)
        |> list.each(io.println)
    }
    ["ls"] -> display_tasks(tasks)
    _ -> {
      io.println("Usage: to_do_terminal add <description>")
    }
  }
}
