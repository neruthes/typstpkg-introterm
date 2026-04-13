#import "../src/introterm.typ": *



#set text(size: 11pt)
#show: enable-shcmd-context.with(
  result-path: "/RUNME.sh.out",
  prompt: "user:machine$ ",
)



#shcmd_session[
  #shcmd(`date -Is && echo "$(whoami)@$HOSTNAME" && uname -a`)
  #shcmd(`sha1sum /proc/mounts | sha1sum | sha1sum | sha1sum`)
]

#shcmd_session[
  #shcmd(`lsblk`)
  #shcmd(`ping 1.1.1.1 -c 6`)
]

#shcmd_session[
  #shcmd(`export MYNAME="Alice"`)
  #shcmd(`bash -c 'echo "Hello $MYNAME"'`)
]

#shcmd(`echo "I am a session-less command"`)

