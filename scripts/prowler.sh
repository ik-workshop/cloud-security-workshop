#!/bin/bash

[[ -n "${DEBUG:-}" ]] && set -x

IMAGE_NAME=cloudmapper

usage() {
  echo "Usage: for $0"
cat << EOF

Documentation https://github.com/toniblyx/prowler

Usage: $(basename "$0") <options>
    -h, --help         Display help
    -r, --docker-run
EOF
}

cmds() {
  while :; do
    case "${1:-}" in
        -r|--docker-run)
          docker_run
          break
          ;;
        -h|--help)
          usage
          break
          ;;
        *)
          usage
          break
          ;;
    esac
    shift
  done
}

docker_run() {

  : "${AWS_ACCESS_KEY_ID}"
  : "${AWS_SECRET_ACCESS_KEY}"
  : "${AWS_DEFAULT_REGION}"
  : "${AWS_SECURITY_TOKEN}"

  docker run -ti --rm --name prowler \
    --env AWS_ACCESS_KEY_ID \
    --env AWS_SECRET_ACCESS_KEY \
    --env AWS_SESSION_TOKEN \
    -e AWS_DEFAULT_REGION \
    toniblyx/prowler:latest  "-r ${AWS_DEFAULT_REGION}"
}

cmds "$@"
