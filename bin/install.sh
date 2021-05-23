#!/bin/bash

[[ -n "${DEBUG:-}" ]] && set -x

usage() {
  echo "Usage: for $0"
cat << EOF

Documentation https://github.com/ik-workshop/cloud-security-workshop

Usage: $(basename "$0") <options>
    -h, --help       Display help
    -a, --all          Run all
    -c, --cloud-mapper Install cloud mapper
    -v, --versions   Display ruby versions
    -d, --docs       View awailable documentaion
EOF
}

cmds() {
  while :; do
    case "${1:-}" in
        -a|--all)
          execute
          break
          ;;
        -c|--cloud-mapper)
          cloud_mapper
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

function _docs() {
  declare -a docs=(
    "https://github.com/duo-labs/cloudmapper"
    "https://github.com/anishathalye/dotbot"
  )
  for el in "${docs[@]}" ; do
    KEY="${el%%}"
    printf "doc > %s\n" "${KEY}"
  done
}

cloud_mapper() {
  # shellcheck disable=SC2034
  brew install autoconf automake libtool jq awscli python3
  cd vendor/cloudmapper/
  python3 -m venv ./venv && source venv/bin/activate
  pip install -r requirements.txt
}

cmds "$@"
