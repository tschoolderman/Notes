# Scripting with Bash  <!-- omit from toc -->

## Contents <!-- omit from toc -->
- [Bash Basics](#bash-basics)
  - [General structure of a script](#general-structure-of-a-script)
  - [File permissions](#file-permissions)
  - [Accessibility of the scripts](#accessibility-of-the-scripts)
- [Bash Variables](#bash-variables)
  - [Variables and shell expansions](#variables-and-shell-expansions)
    - [Variables](#variables)
    - [Parameter expansions](#parameter-expansions)
    - [Command substitution](#command-substitution)
    - [Arithmetic expansion](#arithmetic-expansion)
    - [The bc command](#the-bc-command)
  - [Tilde expansion](#tilde-expansion)
  - [Brace expansion](#brace-expansion)
- [Bash commandline](#bash-commandline)
  - [Step 1: Tokenisation](#step-1-tokenisation)
  - [Step 2: Command identification](#step-2-command-identification)
  - [Step 3: Expansions](#step-3-expansions)
    - [Word splitting](#word-splitting)
    - [Globbing](#globbing)
  - [Step 4: Quote removal](#step-4-quote-removal)
  - [Step 5: Redirection](#step-5-redirection)
  - [Quoting](#quoting)
    - [Examples of how Bash handles commands](#examples-of-how-bash-handles-commands)
- [Requesting user input](#requesting-user-input)
  - [Positional parameters](#positional-parameters)
  - [Special parameters](#special-parameters)
  - [The read command](#the-read-command)
  - [The select command](#the-select-command)
- [Logic](#logic)
  - [Lists and list operators](#lists-and-list-operators)
  - [Test commands and conditional operators](#test-commands-and-conditional-operators)
  - [If statements](#if-statements)
    - [If statements - combining conditions](#if-statements---combining-conditions)
    - [Case statements](#case-statements)
- [Processing options and reading files](#processing-options-and-reading-files)
  - [While loops](#while-loops)
    - [Getopts](#getopts)
      - [Option arguments](#option-arguments)
  - [Read-while loops](#read-while-loops)
- [Arrays and For loops](#arrays-and-for-loops)
  - [Indexed array](#indexed-array)
  - [Expaning an array](#expaning-an-array)
  - [Modifying an array](#modifying-an-array)
  - [The readarray command](#the-readarray-command)
  - [For loops](#for-loops)
- [Debugging scripts](#debugging-scripts)
  - [Shellcheck](#shellcheck)
  - [Common errors](#common-errors)
  - [Getting help](#getting-help)
- [Scheduling and Automation](#scheduling-and-automation)
  - [The "at" command](#the-at-command)
    - [Limitations of at](#limitations-of-at)
  - [Using Cron to schedule](#using-cron-to-schedule)
    - [Limitations of cron](#limitations-of-cron)
  - [Cron tips](#cron-tips)
  - [Cron directories](#cron-directories)
  - [Anacron](#anacron)
    - [Limitations of Anacron](#limitations-of-anacron)
- [Working with remote servers](#working-with-remote-servers)

# Bash Basics  
## General structure of a script  
A Bash file starts with the Shebang line, which tells it with what program the file should be executed.  
In the case of Bash it will always be `#!/bin/bash`.  

Exit statements of the file range from 0 to 255. An exit code of 0 is good, the rest is bad.  
[Official guide to exit codes](https://tldp.org/LDP/abs/html/exitcodes.html)  

```Bash
#!/bin/bash

# Author: John Doe
# Created: 7th July 2020
# Last Modified: 7th July 2020

# Description:
# Creates a backup in ~/bash_course folder of all files in the home directory

# Usage:
# backup_script
```  

## File permissions  
Linux is a strict OS. Not everyone can do just anything.  
To change permissions in Linux the command `chmod` needs to be used on the file.  

drwxrwxrwx - file permissions  
d - is it a directory?  
r - read permissions  
w - write permissions  
x - execute permissions  

The first pair of 3 characters if for the file owner. The next 3 are for the group the owner is in and the last 3 characters means everyone else.  

`chmod <octal code> <file>` a [chmod calculator](https://chmod-calculator.com/) can be used for the octal code.  

## Accessibility of the scripts  
A folder for the scripts can also be added to PATH:  

- Edit your ~/.profile file to add a custom folder to your PATH  
`export PATH="$PATH:/path/to/script_directory`  
- Reload the ~/.profile file  
`$ source ~/.profile`  
- Add your scripts to the new folder and run like normal commands!  
`$ mv my_script script_directory`  
You can now run your scripts like regular commands!  
`$ my_script`  

*Note: Scripts must have execute permissions to run.*  

# Bash Variables  
## Variables and shell expansions  
There are 3 types of parameters:  
- Variables  
- Positional parameters  
- Special parameters  

### Variables  
There are "user-defined"-variables and "shell"-variables (Bourne shell and Bash shell).  
Setting the value of a variable: `name=value`.  
- No spaces, otherwise Linux thinks it is a command.  
- User-defined variables should be all lowercase (best-practice).  
  
Common shell variables  
| Command  | Usage                                                                 |
| -------- | --------------------------------------------------------------------- |
| HOME     | Absolute path to the current user's home directory                    |
| PATH     | List of directories that the shell should search for executable files |
| USER     | The current user's username                                           |
| HOSTNAME | The name of the current machine                                       |
| HOSTTYPE | The current machine's CPU architecture                                |
| PS1      | The terminal prompt string                                            |

[List of Bourne shell variable(10)](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Variables.html#Bourne-Shell-Variables)  
[List of Bash variables](https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#Bash-Variables)  

### Parameter expansions  
Parameter expansion is used to retrieve the value stored in a parameter.  
Simple syntax: `$parameter`  
Advanced syntax: `${parameter}`  

Parameter expansion tricks  
| Command                        | Effect                                                                  |
| ------------------------------ | ----------------------------------------------------------------------- |
| ${parameter^}                  | Convert the first character of the parameter to uppercase               |
| ${parameter^^}                 | Convert all characters of the parameter to uppercase                    |
| ${parameter,}                  | Convert the first character of the parameter to lowercase               |
| ${parameter,,}                 | Convert all characters of the parameter to lowercase                    |
| ${#parameter}                  | Display how many characters the variable’s value contains (a count)     |
| ${parameter : offset : length} | Slice the parameter starting at number defined by “offset” and “length” |
[More expansion tricks](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)  

### Command substitution  
Command Substitution is used to directly reference the result of a command.  
Which is usually a user defined variable.  
Syntax: 
`command=pwd`  
`$(command)`  

### Arithmetic expansion  
Arithmetic Expansion is used to perform mathematical calculations in your scripts.  
Syntax: `$(( expresion ))` like `$(( 4+4 ))`  

Operators are similar to other languages  
| OPERATOR    | MEANING                              | COMMENTS                                              |
| ----------- | ------------------------------------ | ----------------------------------------------------- |
| ( )         | Parentheses                          | Given the highest precedence and is always run first. |
| **          | Exponentiation                       |                                                       |
| *, /, and % | Multiplication, Division, and Modulo | These have the same precedence.                       |
| + and -     | Addition and substraction            | These have the same precedence                        |
*Note: Same precedence -> left gets performed first*  

### The bc command  
To handle decimals in calculations, you need to use the bc command.  
bc means "basic calculator" and is a program in Linux.  

To use it in a script:  
Using the bc command: `echo “expression” | bc`  
Using the scale variable to control the number decimal places shown: `echo “scale=value; expression” | bc`  
Example: `echo "scale=2; 5/2" | bc` returns 2.50  

## Tilde expansion  
echo ~ -> /home/<user>  

To use it for another user in a script: `~colleague` to get their home directory
If user does not exist the tilde expansion returns the literal text: `~abcd`  

[info on tilde expansion](https://www.gnu.org/software/bash/manual/bash.html#Tilde-Expansion)  

To get previous directory you were in $OLDPWD.  
Shortcut for PWD: ~+  
Shortcut for OLDPWD: ~-  

In a script you can use `cd ~-` to switch back and forth between 2 directories.  

## Brace expansion  
Lists as {}, 2 types range lists and string lists.  
String list: no specific order. Any random string  
Range list: specific order. Logically  
*Note: no spaces are used in lists*  

`echo {1,2,3,4,5,6,7,8,9,10}` = `echo {1..10}`  
`echo {10..1}` = reverse list  
`echo {a..z}` = alphabet from a to z  
`echo {1..1000..3}` = gives number to 1 to 1000 in steps of 3  

`mkdir month{01..12}` = gives same number of digits with numbers 01, 02, etc  
`touch month{01..12}/day{01..31}.txt` creates txt files within each folder 31 for each day  

# Bash commandline  
## Step 1: Tokenisation  
During tokenisation, bash reads the command line for unquoted metacharacters,  
and uses them to divide the command line into words and operators.  

Metacharacters: `Space`, `Tab`, `Newline`, `|`, `&`, `;`, `(`, `)`, `<` and `>`. 
These characters are like punctuation.  

Two types of operators:
Control operators `Newline | || & && ; ;; ;& ;;& ( )` and redirection operators `< > << >> <& >& >| <<- <>`.  
They only matter if they are unquoted.


What are words?  
Words are tokens that do not contain any unquoted metacharacters.  

## Step 2: Command identification  
Simple commands: bunch of individual words and each simple command is terminated by a control operator  
Compound commands: provides bash with its programming constructs, such as if statements and loops  

## Step 3: Expansions  
There are 4 stages of shell expansions and are executed in the order listed:  
- Brace expansion  
- Parameter, arithmetic, command and tilde expansion  
- Word splitting  
- Globbing  

`echo $name has {1..3} apples and $(( 5+2 )) oranges` - the brace expansion will be executed first  
If the expansion have the same precedence they will execute from left to right.  

`echo $name{1..3}.txt` will result in `.txt .txt .txt`, because the $name parameter is unknown when {1..3} is executed.  

### Word splitting  
A process the shell performs to split the result of somke unquoted expansions into seperate words.  
Only performed on the results of unquoted: parameter expansions, command substitutions and arithmetic expansions.  
Works very similar to tokenization. The character used to split words are governed by the IFS (Internal Field Separator).  
Space, tab and new line are in IFS. To view the IFS use: `echo "${IFS@Q}"`  

Example:
```Bash
numbers="1 2 3 4 5"
touch $numbers
```  
This will create 5 different files.  

Example:
```Bash
numbers="1 2 3 4 5"
touch "$numbers"
```  
This will create 1 file named '1 2 3 4 5'  

You can change the IFS command with: `IFS=","`, but this overwrites the default values  
Except when used inside a script. If changed inside a script it will only affect the script.  

### Globbing  
Globbing is used as a shortcut for listing the files thhat a command should operate on.  
Is only performed on words not operators.  
Special pattern characters: `*`, `?`, `[`  

`ls *` - means all files  
`ls *.txt` - all the .txt files  
`ls file*.txt` - file<anything>.txt  

? = for 1 character and it *has* to be there, unlike the *  
`ls file?.txt` - matches anything with file<char>.txt (specific in length)  
`ls file???.txt` - matches anything with file<3chars>.txt  

[] = only matches characters you put in it (exact match)  
`ls file[ab].txt` - matches filea.txt and fileb.txt (occupies 1 character)  
`ls file[abc][abc][abc].txt` - matches file<3chars>.txt (only a, b or c)  
`ls file[a-g].txt` - match for a range  
`ls file[0-9].txt` - same for numbers  
*Note: Linux is case sensitive.*  
*Note: globbing only works in CWD, but you can give the path in the command*  

## Step 4: Quote removal  
There are 3 types of quotes: `\`, `'` and `"`  
During quote removal, the shell removes all unquoted backslashes,  
single and double quote characters that did not result from a shell expansion.  

## Step 5: Redirection  
Data streams, each stream can only be connected to 1 place at a time:  
Stream 0 = stdin, a way to provide input into a command  
Stream 1 = stdout, contains data that is produced after succesful command execution  
Stream 2 = stderr, contains all error messages and statuses  

Example:  
`cat < hello.txt` redirection stdin from file to stdout (terminal)  
`echo "some output" > output.txt` redirection from stind to stdout(file)  
`cd /root 2> error.txt` redirect stderr to a file, very specific for stderr  
`cd /root &> /dev/null` redirects both stdout and stderr to "bin bucket" gets immediatly deleted  
`>` overwrites the file  
`>>` appends to the file  

## Quoting  
Quoting methods: backslash, single quotes and double quotes.  
Quoting is about: Removing Special Meanings from characters.  

- Backslash: Remove special meaning from the next character  
- Single quotes: remove special meanign from all characters inside  
- Double quotes: remove special meaning from all except dollar signs and backticks  
  
Escaping:  
`echo john \& jane`  
`filepath=C:\\User\\user\\Documents` or `filepath='C:\User\user\Documents'`  
`filepath="C:\User\$USER\Documents"`

### Examples of how Bash handles commands  
- Problem 1  
`echo "The number $(( 5-2 ))" > number.txt`  
`echo "The number 3" > number.txt`  
`echo The number 3 > number.txt`  
`echo The number 3` stdout -> number.txt  

- Problem 2  
`ls /etc | grep net > net.txt`  
2 command and 1 redirection  
`ls /etc` | `grep net` stdout -> net.txt  

- Problem 3  
```Bash
#/bin/bash
IFS=,
folder=people
name=john,jane,abhishek
```  
`mkdir $folder && cd $folder && touch $name`  
3 commands  
`mkdir people && cd people && touch john,jane,abhishek`  
word splitting due to IFS=,  
`mkdir people && cd people && touch john jane abhishek`  
New dir, with 3 files named john, jane and abhisek  

- Problem 4  
`touch "Daily Report $(date +"%a %d %h %y")"`  
`touch "Daily Report 10 Aug 2023"`  
No further quote removal  

# Requesting user input  
## Positional parameters  
The shell assigns numbers called positional parameters to  
each command-line argument that is entered. ($1, $2, $3…)  

A script.sh:  
```Bash
#!/bin/bash
echo "My name is $1"
echo "My home dir is $2"
echo "My fav colour is $3"
echo "The 10th argument is ${10}"
```  
Command: `script.sh john $HOME red 4 5 6 7 8 9 string`  
Result:  
My name is john  
My home dir is /home/john  
My fav colour is red  
The 10th argument is string  

Example:  
```Bash
#!/bin/bash

# Author: John Doe
# Created: 7th July 2020
# Last Modified: 7th July 2020

# Description:
# Use positional arguments from 1 to 10 where the first argument is the operator
# If no argument is given, the default will be 0

# Usage:
# argument_calc.sh

echo "$(( ${2:-0} $1 ${3:-0} $1 ${4:-0} $1 ${5:-0} $1 ${6:-0} $1 ${7:-0} $1 ${8:-0} $1 ${9:-0} $1 ${10:-0} ))"
```  
\${2:-0} = if the second arguments has no argument, it will default to 0.  

## Special parameters  
[Special parameters](https://www.gnu.org/software/bash/manual/bash.html#Special-Parameters) are like regular parameters,  
but are created for us by the shell, and are unmodifiable.  
Value of a special parameter is calculated for us based on our current script.  
When i doubt, quote it out.  

| Param   | Description                                                                                                 | Command line                      | Param value for commandline |
| ------- | ----------------------------------------------------------------------------------------------------------- | --------------------------------- | --------------------------- |
| \$\#    | Stores the number of command line arguments provided to the script                                          | example.sh 1 2 3                  | 3                           |
| \$0     | Stores the scripts name                                                                                     | test.sh 1 2 3                     | test.sh                     |
| \$@     | Expands to each pos. param. as its own word with subsequent wordsplitting                                   | example.sh "daily reports"        | daily reports (2 words)     |
| \"\$@\" | Same as the other, but without wordsplitting                                                                | example.sh "daily reports"        | daily reports (1 words)     |
| \$*     | Exactly the same as \$@                                                                                     |                                   |                             |
| \"\$*\" | Expands to all pos. param. as one word separated by the first letter of the IFS var, without word splitting | IFS=,  example.sh "daily reports" | daily,reports (1 word)      |
| \$?     | Gives the exit code returned by the most recent command                                                     | echo "hello"                      | echo \$?                    | 0 |

A script with `echo $@`:  
`./script.sh 1 2 3 4 5 6` -> `1 2 3 4 5 6`  
`./script.sh "daily feedback" "monthly report"` -> `daily feedback monthly report`  

A script with `echo "$@"`:  
`./script.sh "daily feedback" "monthly report"` -> `'daily feedback' 'monthly report'`  

A script with `echo "$*"`: (can change how values are separated for e.g.: csv)  
`./script.sh 1 2 3 4 5 6` -> `1,2,3,4,5,6`  

## The read command  
User input is stored in the `$REPLY` command which can be used in a script.  
`read input1 input2` to store multiply values  
`echo $input1 $input2`  

Example:  
```Bash
#!/bin/bash

read -t 5 -p "Input your name: " name
read -t 5 -p "Input your age: " age
read -t 5 -p "Input your city: " city
echo "My name is $name"
echo "My age is $age"
echo "I live in $city"
```  
-p = show a prompt to the screen  
-t = set a timer in seconds for the script to continue running if no input is given  
-s = to prevent input from showing to the terminal  


## The select command  
User input is stored in the $RESPONSE command, but can be given custom variable names.  
Just like the read command.  

Basic syntax:  
```Bash
#!/bin/bash
PS3="What day of the week is it? "
select day in mon tue wed thu fri sat sun;
do
echo "The day of the week is $day"
break
done
```
This is a select list for day in the list provided.  
Without the break command the loop will not end and the user has to manually end the loop.  

PS3 (prompt string for select command)  
You can change the string to ask a question for the input.  

# Logic  
## Lists and list operators  
Use `;`, `&`, `&&`, `||` to create chained lists of commands.  
In Bash a list is when you put one or more commands on a given line.  

| Operator | Example                | Meaning                                                                                                                           |
| -------- | ---------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| &        | command1 & command2    | Sends command1 into a subshell to run “asynchronously” in the background, and continues to process command2 in the current shell. |
| ;        | command1 ; command2    | Runs command1 and command2, i.e. one after the other. The shell will wait for command1 to complete before starting command2.      |
| &&       | command1 && command2   | The “and” operator. The shell will only run command2 if command1 is successful (i.e. returns an exit code of 0).                  |
| \|\|     | command1 \|\| command2 | The “or” operator. The shell will only run command2 if command1 is unsuccessful (i.e. returns a non-zero exit code).              |

## Test commands and conditional operators  
A test command is: “a command that can be used in bash to compare different pieces of information”.  
Syntax: [ expression ]  
The spaces within the square brackets is important for the syntax.  

| OPERATOR | EXAMPLE              | MEANING                                                                                      |
| -------- | -------------------- | -------------------------------------------------------------------------------------------- |
| -eq      | [ 2 -eq 2 ]          | Successful if the two numbers are equal                                                      |
| -ne      | [ 2 -ne 2 ]          | Successful if the two numbers are not equal                                                  |
| =        | [ $a = $b ]          | Successful if the two strings are equal                                                      |
| !=       | [ $a != $b ]         | Successful if the two strings are not equal                                                  |
| -z       | [ -z $c ]            | Successful if a string is empty                                                              |
| -n       | [ -n $c ]            | Successful if a string is not empty                                                          |
| -e       | [ -e /path/to/file ] | Successful if a file system entry /path/to/file exists                                       |
| -f       | [ -f /path/to/file ] | Successful if a file system entry /path/to/file exists and is a regular file                 |
| -d       | [ -d /path/to/file ] | Successful if a file system entry /path/to/file exists and is a directory                    |
| -x       | [ -x /path/to/file ] | Successful if a file system entry /path/to/file exists and is executable by the current user |

## If statements  
Start and stop with `if` and `fi`.  
Check the exit status of a command and only runs the command if a certain condition is true.  

```Bash
if test1; then
Commands... # only run if test1 passes
elif test2; then
Commands... # only run if test1 fails and test2 passes
elif testN; then
Commands... # only run if all previous tests fail, but testN passes
else
Commands... # only run if all tests fail
fi
```  

Example script:  
```Bash
#!/bin/bash
read -p "Please enter a number" number
if [ $number -gt 0 ]; then
    echo "Your number is greater than 0"
elif [ $number -lt 0 ]; then
    echo "Your number is less than 0"
else
    echo "Your number is 0!"
fi
```  

### If statements - combining conditions  
It is possible to chain together multiple test commands using list operators to create more powerful conditions.  

Examples:  
```Bash
#!/bin/bash
a=$(cat file1.txt) # "a" equals contents of file1.txt
b=$(cat file2.txt) # "b" equals contents of file2.txt
c=$(cat file3.txt) # "c" equals contents of file3.txt
if [ "$a" = "$b" ] && [ "$a" = "$c" ]; then
rm file2.txt file3.txt
else
echo "File1.txt did not match both files"
fi
```  
```Bash
#!/bin/bash
a=$(cat file1.txt) # "a" equals contents of file1.txt
b=$(cat file2.txt) # "b" equals contents of file2.txt
c=$(cat file3.txt) # "c" equals contents of file3.txt
if [ "$a" = "$b" ] || [ "$a" = "$c" ]; then
rm file2.txt file3.txt
else
echo "File1.txt did not match either file"
fi
```  

### Case statements  
Case statements provide us with an elegant way to implement branching logic,  
and are often more convenient than creating multiple “elif” statements.  

The tradeoff, however, is that case statements can only work with 1 variable.  
Case statements start and end using the reserved words “case” and “esac”.  

Examples:  
```Bash
case "$variable" in # don't forget the $ and the double quotes!
  pattern1)
    Commands ...
    ;;
  pattern2)
    Commands ...
    ;;
  patternN)
    Commands ...
    ;;
*)
  Commands ... # run these if no other pattern matches
  ;;
esac
```  
```Bash
#!/bin/bash
read -p "Please enter a number: " number
case "$number" in
    "") echo "You didn't enter anything!"
    [0-9]) echo "you have entered a single digit number";;
    [0-9][0-9]) echo "you have entered a two digit number";;
    [0-9][0-9][0-9]) echo "you have entered a three digit number";;
    *) echo "you have entered a number that is more than three digits";;
esac
```  

# Processing options and reading files  
## While loops  
While loops run a set of commands *while* a certain condition is true, hence their name.  

While loops will continue to run until either:  
- The condition command that they’re provided with becomes false (i.e. returns a non-zero exit code).  
- The loop is interrupted.  

Syntax:  
```Bash
while condition; do
  commands...
done
```  

Example:  
```Bash
#!/bin/bash
read -p "Enter your number: " num
while [ "$num" -gt 10 ]; do
  echo "$num"
  num=$(( "$num" - 1 ))
done
```  

### Getopts  
Use `getopts` to process command line options.  
The getopts command enables bash to get the the options provided to the script on the command line.  
However, getopts does not get all the options at once;  
it only gets the very next option on the command line each time it is run.  
Therefore, the getopts command is often used as part of a while loop, to ensure that all command line options are processed.  

Syntax: `getopts "optstring" variable`  
Any single letter we place in the optstring is considered as its own option.  
Getopts can only process one-letter options (long-form options such as --all are not supported.)  

#### Option arguments  
Sometimes, options can accept arguments of their own.  
For example, let’s say we had the command:  
`ourscript -A 10`

In order to allow the -A option to accept an argument, such as “10”,  
we would need to place a colon (:) after the letter “A” in the optstring, like so
`getopts "A:b" variable`  

Whatever argument that is provided with an option is stored in the `$OPTARG` shell variable.
So, if we ran the command ourscript -A 10, the `$OPTARG`  
variable would store the value of 10 when the getopts command processed the -A option.  

The getopts command is often used in conjunction with a while loop so that we ensure that each option on the command line gets processed.  
In order to allow the script to perform different actions based on the options that are provided,  
we often also put a case statement inside the while loop, with one case for each option.  

Basic syntax for the getopts command with while loop and case statement:  
```Bash
while getopts "A:b" variable; do
    case "$variable" in
        A) commands;;
        b) commands;;
        \?) commands;;
    esac
done
```  

When an unexpected option is provided to the getopts command, it stores a literal question mark inside the variable.  
Therefore, it is good practice to create a `\?` case to respond to any invalid options.  
The backslash ensures that the ? is interpreted literally, and not as a special globbing pattern character.  

Example script:  
```Bash
#!/bin/bash
while getopts "c:f:" opt; do
    case "$opt" in
        c) # convert from celsius to farenheit
            result=$(echo "scale=2; ($OPTARG * (9 / 5)) + 32" | bc);;
        f) # convert from fahrenheit to celsius
            result=$(echo "scale=2; ($OPTARG - 32) * (5/9)" | bc);;
        \?)
            echo "Invalid option provided";;
    esac
    echo "$result"
done
```  

Example of a timer script:  
```Bash
#!/bin/bash

# Author
# Date created
# Last modified

# Description

# Usage

total_seconds=""

while getopts "m:s:" opt; do
        case "$opt" in
                m) total_seconds=$(( $total_seconds + $OPTARG * 60 )) ;;
                s) total_seconds=$(( $total_seconds + $OPTARG )) ;;
                \?) ;;
        esac
done

while [ "$total_seconds" -gt 0 ]; do
        echo "Seconds remaining: " $total_seconds
        total_seconds=$(( $total_seconds - 1))
        sleep 1s
done

echo "Time's up!"
```

## Read-while loops  
Read-while loops are simply while loops that use the read command as their test command.  
They are used to read lines of output one by one, and do something for each line.  
A read-while loop can be used to iterate over the contents of files, or over the output of a command (or pipeline).  

Basics:  
```Bash
while read line; do
  commands...
done < file
```  
```Bash
#!/bin/bash
while read line; do
    echo "$line"
done < file1.txt
```  

It is possible in Linux to iterate over a process like you would a file,  
thus reading the output of the command.  

This is achieved using a technique known as process substitution.  
Process substitution simply allows us to treat the output of a command (or commands) as a file.  
```Bash
#!/bin/bash
while read line; do
    echo "$line"
done < <(ls $HOME)
```  
```Bash
while read line; do
commands...
done < <(command) # or <(cmd1 | cmd2 | ... | cmdN)
```  

# Arrays and For loops  
## Indexed array  
The most common type of array in Bash.  
Syntax: `array=(element1 element2 element3 ... elementN)`  
Example: `numbers=(1 2 3 4)`  

## Expaning an array  
| Expansion                                      | Description                                                                                                                                                                                             | Result    |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| ${array}                                       | Gives the first element of an array                                                                                                                                                                     | 1         |
| ${array[@]}                                    | Expands to all the elements of an array                                                                                                                                                                 | 1 2 3 4 5 |
| ${!array[@]}                                   | Expands to all the index numbers of all the elements of an array                                                                                                                                        | 0 1 2 3 4 |
| ${array[@]:offset} E.g. ${array[@]:2}          | Starts at the index specified by offset rather than at index 0, and then continue until the end of array[@]. So, in this xample, we would start at index 2, which is the number 3.                      | 3 4 5     |
| ${array[@]: -2}                                | We can also provide negative offsets. In this example, we will start two elements from the end, which is the number 4. Note: You must have a space after the “:” and before the “-”.                    | 4 5       |
| ${array[@]:offset:length} E.g. ${array[@]:2:2} | Skips the first offset elements, and continues until the whole length of the array is length. So, in this example, we would skip the first 2 elements, and continue until we had a total of 2 elements. | 3 4       |
| ${array[@]@Q}                                  | Views full elements of the array including `\n`                                                                                                                                                         |

## Modifying an array  
| Operation      | Description                                                                                                                                                                                     | Result                          |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| array+=(6)     | Appends 6 to the end of array                                                                                                                                                                   | array becomes (1 2 3 4 5 6)     |
| array+=(a b c) | Appends (a b c) to the end of array                                                                                                                                                             | array becomes (1 2 3 4 5 a b c) |
| unset array[2] | Removes the specified element from the array. In this example the element at index 2 will be removed Note: Index numbers do not update automatically, so this will create a gap in the indexes! | array becomes (1 2 4 5)         |
| array[0]=100   | Changes the value of a specific element of the array. In this example the element with index 0 will become 100                                                                                  | array becomes (100 2 3 4 5)     |

## The readarray command  
The readarray command converts what it reads on its standard input stream into an array.  

Create an array from file: `readarray -t arrayname < file`  
Example: `readarray -t days < days.txt`  

Creating an array from the output of a command:  
Syntax: `readarray -t arrayname < <(command)`  
Example: `readarray -t files < <(ls ~/Documents)`  

**A NOTE ABOUT NEWLINE CHARACTERS**
By default, when the readarray command reads a file (or process substitution),  
it will save each entire line as a new array element,  
including the invisible newline character at the end of the line.  
Storing new lines characters can cause issues when it comes to formatting, so it is best to remove them.  
Therefore, it is suggested that you always use the readarray command’s `-t` option unless you have a strong reason otherwise.  
This will prevent any newline characters from being stored in your array values, and help prevent issues down the road.  

## For loops  
A for loop iterates over list of words or elements and performs a set of commands "for" each element.  

Example without array:  
```Bash
for <variable> in value1 value2 value3; do
    commands...
done
```  
```Bash
#!/bin/bash

for element in first second third; do
    echo "This is $element"
done
```  

Example with array:  
```Bash
for element in "${array[@]}"; do
    commands...
done
```  
```Bash
#!/bin/bash

readarray -t files < file_list.txt

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "$file already exists"
    else
        touch "$file"
        echo "$file was created"
    fi
done
```  

Example:  
```Bash
#!/bin/bash

# Description
# Gets the headers of the urls in the txt file
# and puts it into the text files with the name between the 'www' and 'com'

readarray -t file < urls.txt

for url in "${file[@]}"; do
        result=$(echo "$url" | cut -d '.' -f 2)
        touch "$result"
        curl --head "$url" > "$result".txt
done
```  

# Debugging scripts  
## Shellcheck  
[shellcheck on web](https://www.shellcheck.net/)  
[For VSCode](https://github.com/vscode-shellcheck/vscode-shellcheck)  
Use a shellcheck to identify errors for your scripts.  

## Common errors  
Syntax errors; can be prevented with shellcheck.  

| Error                     | What it means                                                       | How to fix it                                                                       |
| ------------------------- | ------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| No Such File or Directory | The file or directory that you are trying to access does not exist. | 1) Check that you didn’t mistype the file path 2) Check that Word splitting has not |
interfered with how a file path is being interpreted (did you wrap everything in double quotes?) 3) Check that the files/folders you want to work with actually exist.
File Exists| You are trying to create a file/directory that already exists|Modify the script's logic to check whether the file you want to create already exists before you run the command to create it. e.g: `[ -e <my file/directory> ] || create it`
Permission Denied| You do not have the required permissions to do what you are trying to do|Put the word sudo before the script name when you run it
Operation Not Permitted|You are trying to do something on the system that regular users are not allowed to do|Put the word sudo before the script name when you run it
Command not found|You are trying to run a program that the shell could not find on its path|1) Check for typo in the command name 2) Ensure that the program you are trying to run is on your system’s PATH 3) Ensure that the program you are trying to run has execution permissions 4) Install any required packages|  

## Getting help  
The `man`, `help` and `info` commands.  
How to identify if a command is internal or external: `type -a <cmd>`  
`type -a cd` - "cd is a shell builtin"  
`type -a ls` - "ls is aliased to 'ls --color=auto' ls is /usr/bin/ls ls is /bin/ls"  

Use the `help` command for internal commands.  
Use the `man` or `info` commands for external.  

Get the description of a command use `-d`: `help -d cd`  
Get the usage info of a command use `-s`: `help -s cd`  

Search all manpages with: `man -k <keyword>`
You can search with multiple keywords when wrapped in double quotes.  
With `man -K partition` you can search per page instead of a list with small k.  
You can search any manpage by typing: `/<keyword>`. This will highlight the keywords in the manpage.  

To get more info use the `info <cmd>`. This shows a page with more info and links to other sections.  

# Scheduling and Automation  
## The "at" command  
Install with: `apt install at`  
Check status with: `service atd status`  

The atd-service runs in the background as a daemon service.  
Example: `at 9:30am` run a script at 9:30am, this will open a prompt.  
*Note: this will use /bin/sh by default not bash*  
To end the prompt press Ctrl+D.  
This will give a prompt `job <id> <datetime>` of when the script will run.  

With `at -l` you will get a list of scheduled jobs.  
Remove job with: `at -r <id>`.  

Using `at` in a script:
```Bash
#!/bin/bash

mkdir at_dir
touch at_dir/file{1..100}.txt
```
Enable the file in `at` with: `at 10:00am -f <scriptname>`  

`at 9am Monday -f <script>` the time MUST come before the day!  
Other possible commands:  
`at 9am 12/23/2023`  
`at 9am 23.12.2023`  
`at 9am tomorrow -f <script>`  
`at 9am next week -f <script>`  
With a timer:  
`at now + 5 minutes`  
`at now + 2 days`  

### Limitations of at  
- The `at` command will only execute job if your PC is on, thus suitable for servers  
- No way to set up recurring jobs, `at` schedules for a one-time execute  

## Using Cron to schedule  
Each user has a crontab that contains the jobs that they want to run from their user account.  
Check status with `service cron status`  
Edit the crontab (cron table): `crontab -e`  
With the `-e` command changes are immediatly picked up by cron (service restart).  
When editing the crontab use spaces to seperate the columns. Crontab does not care for how much white space.  

The crontab is build op with rows (a job) and 6 columns:  
m = minutes  
h = hour  
dom = days of the month  
mon = month  
dow = days of the week  
command = command or path to script  

Shortcuts:  
| Character | Example        | Meaning                                                                               |
| --------- | -------------- | ------------------------------------------------------------------------------------- |
| *         |                | A * means all possible entries                                                        |
| ,         | 1,5,8          | Enter the values 1, 5 and 8 into the current column                                   |
| -         | 1-8 or MON-WED | Enter the values 1 through 8 into column or enters the values MON,TUE,WED into column |

Useful tool: https://crontab.guru/  

Systemwide crontab: `sudo nano /etc/crontab`  
This opens a crontab with a new column to specify as which user you want to run as.  
Don't forget to restart the cron service: `sudo service cron restart`  

### Limitations of cron  
- The `cron` command will only execute job if your PC is on, thus suitable for servers  


## Cron tips  
**Tip 1:** If the day-of-month or day-of-week part starts with a *, they form an intersection.  
Otherwise they form a union. * * 3 * 1 runs on the 3rd day of the month and on Monday (union),  
whereas * * */2 * 1 runs on every second day of the month only if it's also a Monday (intersection).  
The manpage is incorrect about this detail.  

**Tip 2:** Run your servers including the cron process in UTC timezone.  

**Tip 3:** Some cron implementations allow to specify years and seconds.  
However, cron is not the best tool if you need to operate at those levels, which is also why crontab.guru doesn't support them.  

**Tip 4:** Don't use @reboot because it has too many issues.  

**Tip 5:** More difficult schedules can be realized by combining multiple cron expressions.  
For example, if you need to run X every 90 minutes, create one crontab entry that runs X every 3 hours on the hour (0 */3 * * *),  
and a second crontab entry that runs X every 3 hours with an offset (30 1/3 * * *).  

**Tip 6:** Another alternative for complicated schedules is Mcron.  

## Cron directories  
Cron directories are folders on your system where you can place scripts to run at a particular frequency.  

Preconfigured dirs:  
- /etc/cron.hourly    Scripts in this folder will run once per hour  
- /etc/cron.daily     Scripts in this folder will run once per day  
- /etc/cron.weekly    Scripts in this folder will run once per week  
- /etc/cron.monthly   Scripts in this folder will run once per month  
  
These files are configured in the `/etc/crontab`.  
When you move script files into a crondirectory, remove the .sh extension.  

Creating personalized crondirectories:  
create a dir in your desired location named: e.g. `~/cron.daily.2am`  
With `crontab -e` enter the new row: `0 2 * * * run-parts ~/cron.daily.2am --report`  
Use the `run-parts` to make it run automatically in your useraccount.  

## Anacron  
The advantage of anacron is that it has the ability to monitor if a cron job has been run or not,  
and if not, then run it when this lapse is discovered.  

By default, there is only one anacrontab on a system by default.  
Anacron’s crontab is located at /etc/anacrontab.  
In the anacrontab you can set the shell variable to be /bin/bash.  


Anacrontab:  
| Column         | Meaning                                                                                                                     |
| -------------- | --------------------------------------------------------------------------------------------------------------------------- |
| period         | How many days between each time your command is run. E.g putting a “1” here would make the command run every day            |
| delay          | The delay in minutes from when anacron starts to when this command is run                                                   |
| job-identifier | The name given to the command in the anacron logs. The job identifier can contain any characters except blanks and slashes. |
| command        | The command you want to run, or path to your script.                                                                        |

Job-identifiers are saved in the `ls /var/spool/anacron` here it will check for the time it is last run succesfully.  
If it is further away than the specified time, it will run the command.  

### Limitations of Anacron  
- Unlike cron, you cannot run anacron jobs any more frequently than daily.  
- Anacron will only recover 1 missed job!  

# Working with remote servers  
Copy files to a remote server.  
`scp <source> <target>`  
`scp ~/script.sh root@<ip>:~/` - copy script from local pc to home dir of target.  
The other way works just the same.  
