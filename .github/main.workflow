workflow "build" {
  on = "push"
  resolves = "docker-push"
}

action "docker-build" {
  uses = "actions/docker/cli@master"
  args = "build -t bjornmagnusson/java-test:$GITHUB_SHA ."
}

action "docker-hub-login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = "docker-build"
}

action "docker-push" {
  uses = "actions/docker/cli@master"
  args = "push bjornmagnusson/java-test"
  needs = "docker-hub-login"
}

workflow "on pull request merge, delete the branch" {
  on = "pull_request"
  resolves = ["branch cleanup"]
}

action "branch cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}
