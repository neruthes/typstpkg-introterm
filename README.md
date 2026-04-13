# typstpkg-introterm

HTML parsing and rendering in Typst.

## Demo

https://pub-714f8d634e8f451d9f2fe91a4debfa23.r2.dev/typstpkg-introterm/5c1e77cec4f7cf9e1d4dc0ee/demo1.pdf


## Usage

```typ
#show: enable-shcmd-context.with(
  result-path: "/RUNME.sh.out",
  prompt: "user:machine$ ",
)
#shcmd_session(prompt: auto)[
  #shcmd(`date -Is && echo "$(whoami)@$HOSTNAME" && `)
  #shcmd(`sha1sum /proc/mounts | sha1sum | sha1sum | sha1sum`)
]
```

See attachment for RUNME.sh. Download the script and run to generate RUNME.sh.out.
The stdout and stderr will be mapped to their source commands.


## Copyright

Copyright (c) 2026 Neruthes.

Published with the GNU GPL 2.0 license.
