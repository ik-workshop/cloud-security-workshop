#!/bin/bash

[[ -n "${DEBUG:-}" ]] && set -x

usage() {
  echo "Usage: for $0"
cat << EOF

Documentation https://github.com/nccgroup/ScoutSuite

Usage: $(basename "$0") <options>
    -u, --usage        Display usage
    -h, --help         Display help
    -a, --all          Run all
    -i, --install      Install ScoutSuite
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
        -i|--install)
          _install
          break
          ;;
        -r|--run)
          _run
          break
          ;;
        -u|--usage)
          usage
          break
          ;;
        -h|--help)
          _help
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

_install() {
  pip install scoutsuite
}

_help() {
  scout --help
}

_run() {
  scout aws --report-dir scout
}

cmds "$@"
