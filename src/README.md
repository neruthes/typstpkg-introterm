This package provides fake terminals for shell commands.

```typ
#show: enable-shcmd-context.with(
  result-path: "/RUNME.sh.out", // Customize file path
  prompt: "user:machine$ ",
)
#shcmd_session(prompt: auto)[
  #shcmd(`date -Is && echo "$(whoami)@$HOSTNAME" && uname -a`)
  #shcmd(`sha1sum /proc/mounts | sha1sum | sha1sum | sha1sum`)
]
```

See attachment for RUNME.sh. Download the script and run to generate RUNME.sh.out.
The stdout and stderr will be mapped to their source commands.