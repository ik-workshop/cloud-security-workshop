#!/bin/bash

[[ -n "${DEBUG:-}" ]] && set -x

IMAGE_NAME=cloudmapper

usage() {
  echo "Usage: for $0"
cat << EOF

Documentation https://github.com/ik-workshop/cloud-security-workshop

Usage: $(basename "$0") <options>
    -h, --help         Display help
    -a, --all          Run all
    -b, --docker-build Build Cloudmapper Docker contaier
    -r, --docker-run
    -v, --versions     Display ruby versions
    -d, --docs         View awailable documentaion
EOF
}

cmds() {
  while :; do
    case "${1:-}" in
        -a|--all)
          execute
          break
          ;;
        -b|--docker-build)
          docker_build
          break
          ;;
        -r|--docker-run)
          docker_run
          break
          ;;
        -h|--help)
          usage
          break
          ;;
        -d|--docs)
          _docs
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

docker_build() {
  cd vendor/cloudmapper/
  docker build -t ${IMAGE_NAME} .
}

docker_run() {

  : "${AWS_ACCESS_KEY_ID}"
  : "${AWS_SECRET_ACCESS_KEY}"
  : "${AWS_DEFAULT_REGION}"
  : "${AWS_SECURITY_TOKEN}"

  docker run -ti --rm \
      -v $PWD/cloudmapper/values:/opt/cloudmapper/values \
      -v $PWD/cloudmapper/account-data:/opt/cloudmapper/account-data \
      -e AWS_ACCESS_KEY_ID \
      -e AWS_SECRET_ACCESS_KEY \
      -e AWS_DEFAULT_REGION \
      -e AWS_SECURITY_TOKEN \
      -p 8080:8000 \
      cloudmapper /bin/bash
}

cmds "$@"
