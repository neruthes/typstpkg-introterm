#import "../src/introterm.typ": *



#set text(size: 11pt)
#show: enable-shcmd-context.with(
  result-path: "/RUNME.sh.out",
  prompt: "user:machine$ ",
)


```typ
#show: enable-shcmd-context.with(
  result-path: "/RUNME.sh.out",
  prompt: "user:machine$ ",
)
#shcmd-session[
  #shcmd(`date -Is && echo "$(whoami)@$HOSTNAME" && uname -a`)
  #shcmd(`sha1sum /proc/mounts | sha1sum | sha1sum | sha1sum`)
]
#shcmd-session[
  #shcmd(`ping 1.1.1.1 -c 6`)
]
#shcmd-session[
  #shcmd(`export MYNAME="Alice"`)
  #shcmd(`bash -c 'echo "Hello $MYNAME"'`)
]
```

#shcmd-session[
  #shcmd(`date -Is && echo "$(whoami)@$HOSTNAME" && uname -a`)
  #shcmd(`sha1sum /proc/mounts | sha1sum | sha1sum | sha1sum`)
]
#shcmd-session[
  #shcmd(`ping 1.1.1.1 -c 6`)
]
#shcmd-session[
  #shcmd(`export MYNAME="Alice"`)
  #shcmd(`bash -c 'echo "Hello $MYNAME"'`)
]


