#!/bin/bash
exec > >(tee RUNME.sh.out) 2>&1

(
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=0'
  date -Is && echo "$(whoami)@$HOSTNAME" && uname -a
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=1'
  sha1sum /proc/mounts | sha1sum | sha1sum | sha1sum
)
(
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=2'
  lsblk
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=3'
  ping 1.1.1.1 -c 6
)
(
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=4'
  export MYNAME="Alice"
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=5'
  bash -c 'echo "Hello $MYNAME"'
)
(
  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=6'
  echo "I am a session-less command"
)