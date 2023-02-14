# Bash commands <!-- omit from toc -->  
A short guide to Bash commands, tips, tricks and other helpful information.  
[Bash scripting cheatsheet](https://devhints.io/bash)  
[GFG Bash guide](https://www.geeksforgeeks.org/bash-scripting-introduction-to-bash-and-bash-scripting/amp/)  
[File and File permissions](https://www.javatpoint.com/bash-filesystem-and-file-permissions)  
[Bash script examples](https://www.hostinger.com/tutorials/bash-script-example)  

&nbsp;
## Contents <!-- omit from toc -->
---
- [Common cmdlets](#common-cmdlets)
- [Create your own Bash commands](#create-your-own-bash-commands)
- [Options for cmdlets](#options-for-cmdlets)

## Common cmdlets
---
| Syntax  |    Options     | Description                                                     |
| :-----: | :------------: | --------------------------------------------------------------- |
|  touch  | -a, -m, -r, -d | Create a new file in current directory                          |
|   ls    |     -a, -l     | Show a list of files and folders in the current directory       |
|  echo   |     -e, -n     | Print text to terminal                                          |
|  mkdir  |   -m, -p, -v   | Create directory                                                |
|  grep   |   -i, -c, -n   | search                                                          |
|   man   |   -w, -f, -b   | print manual or get help for a command                          |
|   pwd   |                | Print working directory                                         |
|   cd    |                | Change directory                                                |
|   mv    |     -i, -b     | Move or rename directory                                        |
|  rmdir  |       -p       | Remove directory                                                |
| locate  |   -q, -n, -i   | Locate a specific file or directory                             |
|  less   |   -e, -f, -n   | View the contents of a rext file                                |
| compgen |   -a, -c, -d   | Shows all available commands, aliases and functions             |
|   \>    |                | Redirect stdout                                                 |
|   cat   |       -n       | Read a file, create a file and concatenate files                |
|   \|    |                | Pipe takes stdout of one cmd and passes it as input to another  |
|  head   |       -n       | Read start of a file                                            |
|  tail   |       -n       | Read the end of a file                                          |
|  chmod  |     -f, -v     | Sets the file permissions flag on a file or folder              |
|  exit   |                | Exit out of a directory                                         |
| history |     -c, -d     | list most recent commands                                       |
|  clear  |                | Clear terminal window                                           |
|   cp    |   -r, -i, -b   | Copy files and directories                                      |
|  kill   |       -p       | Terminate stalled processes                                     |
|  sleep  |                | Delay a process for a specified amount of time [suffix s, m, d] |

## Create your own Bash commands
---
Syntax: `alias alias_name = "command_to_run"`
Examples:
Shortened clear command:
```Bash
$ alias c = "clear"
```
Set up a webserver in a folder:
```Bash
$ alias WWW = 'python -m SimpleHTTPServer 8000'
```
For when you need to test a website in different browsers:
```Bash
$ alias ff4 = '/opt/firefox/firefox'
```
```Bash
$ alias ff13 = '/opt/firefox13/firefox'
```
```Bash
$ alias chrome = '/opt/google/chrome/chrome'
```
Make alias of multiple commands (chaining):
```Bash
$ alias alias_name = 'activator && clean && compile && run'
```

## Options for cmdlets
---
|  Abbreviation  |        Name         | Effect                                                                                                                                                   |
| :------------: | :-----------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
|       -B       |   brace expansion   | Enable brace expansion (default setting = on)                                                                                                            |
|       +B       |   brace expansion   | Disable brace expansion                                                                                                                                  |
|       -C       |      noclobber      | Prevent overwriting of files by redirection (may be overridden by > \| )                                                                                 |
|       -D       |       (none)        | List double-quoted strings prefixed by $, but do not execute commands in script                                                                          |
|       -a       |      allexport      | Export all defined variables                                                                                                                             |
|       -b       |       notify        | Notify when jobs running in background terminate (not of much use in a script)                                                                           |
|     -c ...     |       (none)        | Read commands from ...                                                                                                                                   |
|   checkjobs    |                     | Informs user of any open jobs upon shell exit. Introduced in version 4 of Bash, and still "experimental." Usage: shopt -s checkjobs (Caution: may hang!) |
|       -e       |       errexit       | Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)                       |
|       -f       |       noglob        | Filename expansion (globbing) disabled                                                                                                                   |
|    globstar    | globbing star-match | Enables the ** globbing operator (version 4+ of Bash). Usage: shopt -s globstar                                                                          |
|     --help     |        help         | Display a usage message on standard output and exit successfully.                                                                                        |
|       -i       |     interactive     | Script runs in interactive mode                                                                                                                          |
|       -l       |        login        | Make this shell act as if it had been directly invoked by login.                                                                                         |
|       -n       |       noexec        | Read commands in script, but do not execute them (syntax check)                                                                                          |
| -o Option-Name |       (none)        | Invoke the Option-Name option                                                                                                                            |
|    -o posix    |        POSIX        | Change the behavior of Bash, or invoked script, to conform to POSIX standard.                                                                            |
|  -o pipefail   |    pipe failure     | Causes a pipeline to return the exit status of the last command in the pipe that returned a non-zero return value.                                       |
|       -p       |     privileged      | Script runs as "suid" (caution!)                                                                                                                         |
|       -r       |     restricted      | Script runs in restricted mode (see Chapter 22).                                                                                                         |
|       -s       |        stdin        | Read commands from stdin                                                                                                                                 |
|       -t       |       (none)        | Exit after first command                                                                                                                                 |
|       -u       |       nounset       | Attempt to use undefined variable outputs error message, and forces an exit                                                                              |
|       -v       |       verbose       | Print each command to stdout before executing it                                                                                                         |
|       -x       |       xtrace        | Similar to -v, but expands commands                                                                                                                      |
|       -        |       (none)        | End of options flag. All other arguments are positional parameters.                                                                                      |
|       --       |       (none)        | Unset positional parameters. If arguments given (-- arg1 arg2), positional parameters set to arguments.                                                  |
