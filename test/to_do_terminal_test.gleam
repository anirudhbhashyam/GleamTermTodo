import gleeunit
import gleeunit/should

import task.{Task}

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn create_task_test() {
  let task = Task("Test task", task.Pending)
  task.description |> should.equal("Test task")
  task.status |> should.equal(task.Pending)
}
