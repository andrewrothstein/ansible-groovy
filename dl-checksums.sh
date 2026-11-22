#!/bin/sh
set -e
readonly MIRROR=https://downloads.apache.org/groovy

dl () {
    local ver=$1
    local file="apache-groovy-binary-${ver}.zip"
    local url="${MIRROR}/${ver}/distribution/${file}.sha256"
    local sum
    sum=$(curl -fsSL --proto '=https' --tlsv1.2 "$url" | awk '{print $1}' | tr -d '\r')
    if ! printf '%s' "$sum" | grep -Eq '^[0-9a-f]{64}$'
    then
        echo "bad or missing checksum from $url: '$sum'" >&2
        exit 1
    fi
    printf "  # %s\n" "$url"
    printf "  '%s': sha256:%s\n" "$ver" "$sum"
}

for v in "${@:-6.0.0}"; do
    dl "$v"
done
