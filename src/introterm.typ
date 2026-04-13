#let __state__shcmd-session_id = state("__state__shcmd-session_id", 0)
#let __state__shcmd_is_in_session = state("__state__shcmd_is_in_session", false)
#let __state__shcmd_arr = state("__state__shcmd_arr", ())

#let __state__shcmd_defaultprompt = state("__state__shcmd_defaultprompt", "")
#let __state__shcmd-sessionprompt = state("__state__shcmd-sessionprompt", "")
#let __state__shcmd_fonts = state("__state__shcmd_fonts", (
  "JetBrains Mono NL",
  "Libertinus Mono",
  "Courier New",
  "Noto Sans Mono",
  "Noto Sans Mono CJK SC",
))
#let __state__shcmd_result-path = state("__state__shcmd_result-path", none)

#let shcmd(cmdlineraw) = context {
  let cmdseq = __state__shcmd_arr.get().len() + 1
  let current_session = __state__shcmd-session_id.get()
  let in_session = __state__shcmd_is_in_session.get()

  // Create an anonymous session ID if we aren't inside an explicit session block
  let active_sid = if in_session {
    current_session
  } else {
    current_session + 1 + __state__shcmd_arr.get().len() // Unique ID for phantom sessions
  }

  let __prompt_styler(it) = text(fill: green.lighten(40%), it)
  let __prompt = __state__shcmd-sessionprompt.get()
  if __prompt == none { __prompt = "" }

  let fake_raw(it) = {
    set text(font: __state__shcmd_fonts.get())
    set par(justify: false)
    it
  }

  block(width: 100%, breakable: false)[
    #fake_raw(
      __prompt_styler(__prompt)
        + cmdlineraw.text.clusters().map(it => if it != "\n" { box(it) } else { linebreak() }).join(),
    )
    #if __state__shcmd_result-path.get() != none {
      let result_txt = read(__state__shcmd_result-path.get())
      let matched_lines_arr = ()
      let __arr = result_txt.split("\n")
      let phase = 0
      for (itr, linetext) in __arr.enumerate() {
        if phase == 1 {
          if linetext.find("4ed98fd09cb843c8adf9c840b34be3be--rowid=" + repr(cmdseq)) == none {
            if linetext != "" { matched_lines_arr.push(linetext) }
          } else { phase = 2 }
        }
        if phase == 0 {
          if linetext.find("4ed98fd09cb843c8adf9c840b34be3be--rowid=" + repr(cmdseq - 1)) != none {
            phase = 1
          }
        }
      }
      if matched_lines_arr.len() > 0 {
        context text(fill: text.fill.transparentize(15%), fake_raw(
          matched_lines_arr.join("\n").clusters().map(it => if it != "\n" { box(it) } else { linebreak() }).join(),
        ))
        v(0.6pt)
      }
    }
  ]

  __state__shcmd_arr.update(it => {
    it.push((cmdlineraw.text, active_sid))
    it
  })
}

#let shcmddump() = context {
  let actions_arr = __state__shcmd_arr.get()
  let __runmesh_stash = (
    ```sh
    #!/bin/bash
    # Ensure a consistent terminal width for tools like neofetch
    export COLUMNS=80
    export LINES=40
    export TERM=xterm

    # Global redirection with ANSI normalization
    exec > >(tee RUNME.sh.out) 2>&1
    ```.text,
    "",
  )

  let last_sid = -1
  for (rowid, (cmdline, sid)) in actions_arr.enumerate() {
    if sid != last_sid {
      if last_sid != -1 { __runmesh_stash.push(")") }
      __runmesh_stash.push("(")
      last_sid = sid
    }

    __runmesh_stash.push(
      "  echo '########4ed98fd09cb843c8adf9c840b34be3be--rowid=" + repr(rowid) + "'",
    )
    __runmesh_stash.push("  " + cmdline)
  }
  if last_sid != -1 { __runmesh_stash.push(")") }

  let __runmesh_stash__str = __runmesh_stash.join("\n")
  pdf.attach("RUNME.sh", bytes(__runmesh_stash__str))
}

#let enable-shcmd-context(result-path: none, prompt: "user:machine$ ", doc) = {
  __state__shcmd_result-path.update(result-path)
  __state__shcmd_defaultprompt.update(prompt)
  doc
  shcmddump()
}

#let shcmd-session(it, prompt: auto) = context {
  let p = if prompt == auto { __state__shcmd_defaultprompt.get() } else { prompt }

  __state__shcmd-session_id.update(it => it + 1)
  __state__shcmd_is_in_session.update(true)
  __state__shcmd-sessionprompt.update(p)

  set text(fill: white)
  set par(leading: 0.62em, spacing: 0.62em)
  block(width: 100%, fill: black.lighten(15%), inset: 4mm, radius: 1mm, it)

  __state__shcmd_is_in_session.update(false)
  __state__shcmd-sessionprompt.update(__state__shcmd_defaultprompt.get())
}

