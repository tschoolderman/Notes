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

### Globbing  


## Step 4: Quote removal  

## Step 5: Redirection  


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