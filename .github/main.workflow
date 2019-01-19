workflow "build" {
  on = "push"
  resolves = "docker-push"
}

action "docker-build" {
  uses = "actions/docker/cli@master"
  args = "build -t bjornmagnusson/java-test"
}

action "docker-push" {
  uses = "actions/docker/cli@master"
  args = "push bjornmagnusson/java-test"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}
