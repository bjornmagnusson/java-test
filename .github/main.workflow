workflow "build" {
  on = "push"
  resolves = "docker-push"
}

action "docker-build" {
  uses = "actions/docker/cli@master"
  args = "build -t bjornmagnusson/java-test ."
}

action "docker-hub-login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME","DOCKER_PASSWORD"]
  needs = "docker-build"
}

action "docker-push" {
  uses = "actions/docker/cli@master"
  args = "push bjornmagnusson/java-test"
  needs = "docker-hub-login"
}
