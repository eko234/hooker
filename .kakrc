define-command runB %{
  nop %sh{lsof -i tcp:8087| grep janet | awk '{print $2}' | xargs kill -9}
  eval -try-client tools %{kakpipe -S -w -- sh -c "janet main.janet"}
}

define-command prompt-commands %{
  peneira "DO: " %{
printf "ideB
runB"
  } %{
    eval %arg{1}
  }
}

map global user j ': prompt-commands<ret>'
