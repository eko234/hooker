# HOOKER

   Hooker is a cli application mainly used to automate deployment
   and handling of applications, it is best used
   for specific projects, exposing an rpc to be used remotely or
   locally (i know, i know...), so if you want to handle different
   projects the recommended way is to spawn multiple servers

### ADVICE!!
  This application is in a very early stage, it might break
  but shouldnt do anything terrible unless you tell it to


## COMMANDS
  -listR (list available scripts in the hookers dir)
  -pidsR (list the pids of processes executed)
  -runR <command> [args...](run a script forwarding rest args to it)
  -killR <pid> (kill a specific process by pid)
 
## USE

  The preferred way of usage is defining a hookers dir in your
  project dir where you should spawn hooker, hooker will expose
  the scripts in that dir as rpc functions so you can handle what
  can be done, you can pass the flag --unsafe to hooker, to be
  able to input whatever command, but this is not recommended,
  the handles for the scripts/commands you fire will be stored
  in a hashtable internally with which you can interact, for
  example you can kill a process calling the default command
  killR <pid>.

  if you call
  `hooker --as client --port 8080 --host localhost --key secretkey -- runR ls -a`
  note thet everything after the command will be used as the arguments for that
  command, in that case runR will run a command, if the flag unsafe is not
  provided hooker will complain in this example, as it will only allow
  to run scripts in the hookers dir

## ROADMAP

- [ ] find a better name, but still "funny"
- [ ] implement a repl?
