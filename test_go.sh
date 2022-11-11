#!/bin/sh

. /etc/profile
[ "$#" -eq 0 ] && echo "Usage: $0 <go file>" && exit 1
which go >/dev/null 2>&1 || { echo "go not found" && exit 1; }

set -eux

BASE=$(basename "$1" .go)
SRC="$BASE.go"
TARGET='mips64le mipsle mips64 mips'

[ -f "$BASE.go" ] || { echo "File not found: $BASE.go" && exit 1; }

go env
lscpu
uname -a
#cat /proc/sys/fs/binfmt_misc/status
#find /proc/sys/fs/binfmt_misc -name "*mips*"

cat "$SRC"

code=0
for arch in $TARGET; do
  GOARCH="$arch" go build -o "$BASE.$arch" "$SRC"
  file "$BASE.$arch"
  ./"$BASE.$arch" || code=$?
  rm -f "$BASE.$arch"
done

exit $code
