#!/bin/sh
set -e
readonly MIRROR=https://downloads.apache.org/groovy

dl () {
    local ver=$1
    local file="apache-groovy-binary-${ver}.zip"
    local url="${MIRROR}/${ver}/distribution/${file}.sha256"
    printf "  # %s\n" $url
    printf "  '%s': sha256:%s\n" $ver $(curl -sSL $url)
}

dl ${1:-3.0.9}

