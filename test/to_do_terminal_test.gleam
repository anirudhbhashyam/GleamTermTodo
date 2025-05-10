import gleeunit
import gleeunit/should

import task.{Task}
import to_do_terminal.{cli_add, cli_remove}

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn create_task_test() {
  let task = Task(0, "Test task", task.Pending)
  task.description |> should.equal("Test task")
  task.status |> should.equal(task.Pending)
}

pub fn cli_add_task_test() {
  let tasks = []
  let tasks = cli_add(tasks, "Test task", "pending")
  tasks |> should.equal([Task(0, "Test task", task.Pending)])
}

pub fn cli_remove_task_test() {
  let tasks = []
  let tasks = cli_add(tasks, "Test task", "done")
  let tasks = cli_remove(tasks, 0)
  tasks |> should.equal([])
}
  
 