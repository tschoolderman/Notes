# Powershell commands <!-- omit from toc -->  

## Contents <!-- omit from toc -->
---
- [Common cmdlets](#common-cmdlets)
- [Common aliases](#common-aliases)
- [Basic commands](#basic-commands)
- [Import, Export, Convert](#import-export-convert)
- [Flow Control](#flow-control)
- [Comments, Escape characters](#comments-escape-characters)

## Common cmdlets
---
| Command name      |             Alias             | Description                                                                                                           |
| ----------------- | :---------------------------: | --------------------------------------------------------------------------------------------------------------------- |
| Set-Location      |         cd, chdir, sl         | Sets the current working location to a specified location.                                                            |
| Get-Content       |         cat, gc, type         | Gets the content of the item at the specified location.                                                               |
| Add-Content       |              ac               | Adds content to the specified items, such as adding words to a file.                                                  |
| Set-Content       |              sc               | Writes or replaces the content in an item with new content.                                                           |
| Copy-Item         |         copy, cp, cpi         | Copies an item from one location to another.                                                                          |
| Remove-Item       | del, erase, rd, ri, rm, rmdir | Deletes the specified items.                                                                                          |
| Move-Item         |         mi, move, mv          | Moves an item from one location to another.                                                                           |
| Set-Item          |              si               | Changes the value of an item to the value specified in the command.                                                   |
| New-Item          |              ni               | Creates a new item.                                                                                                   |
| Start-Job         |             sajb              | Starts a Windows PowerShell background job.                                                                           |
| Compare-Object    |         compare, dif          | Compares two sets of objects.                                                                                         |
| Group-Object      |             group             | Groups objects that contain the same value for specified properties.                                                  |
| Invoke-WebRequest |        curl, iwr, wget        | Gets content from a web page on the Internet.                                                                         |
| Measure-Object    |            measure            | Calculates the numeric properties of objects, and the characters, words, and lines in string objects, such as files … |
| Resolve-Path      |             rvpa              | Resolves the wildcard characters in a path, and displays the path contents.                                           |
| Resume-Job        |             rujb              | Restarts a suspended job                                                                                              |
| Set-Variable      |            set, sv            | Sets the value of a variable. Creates the variable if one with the requested name does not exist.                     |
| Show-Command      |             shcm              | Creates Windows PowerShell commands in a graphical command window.                                                    |
| Sort-Object       |             sort              | Sorts objects by property values.                                                                                     |
| Start-Service     |             sasv              | Starts one or more stopped services.                                                                                  |
| Start-Process     |          saps, start          | Starts one or more processes on the local computer.                                                                   |
| Suspend-Job       |             sujb              | Temporarily stops workflow jobs.                                                                                      |
| Wait-Job          |              wjb              | Suppresses the command prompt until one or all of the Windows PowerShell background jobs running in the session are … |
| Where-Object      |           ?, where            | Selects objects from a collection based on their property values.                                                     |
| Write-Output      |          echo, write          | Sends the specified objects to the next command in the pipeline. If the command is the last command in the pipeline,… |
| Open in VSCode    |code \<file-path\>|Opens project in VSCode window|

## Common aliases
---
|     Command     | Description      |
| :-------------: | ---------------- |
|       gcm       | Get-Command      |
|    foreach,%    | Foreach-Object   |
|  dir, ls, gci   | Get_ChildItem    |
|       gi        | Get-Item         |
|    rni, ren     | Rename-Item      |
|       fFt       | Format-Table     |
|       fl        | Format-List      |
|      gcim       | Get-CimInstance  |
| h, history, ghy | Get-History      |
|     ihy, r      | Invoke-History   |
|       gp        | Get-ItemProperty |
|       sp        | Set-ItemProperty |
|     pwd, gl     | Get-Location     |
|       gm        | Get-Member       |
|       sls       | Select-String    |
|  cd, chdir, sl  | Set-Location     |
|   cls, clear    | Clear-Host       |

## Basic commands
---
|    Command    | Description                                   |
| :-----------: | --------------------------------------------- |
|    Cmdlet     | Commands built into shell written in .NET     |
|   Functions   | Commands written in PS language               |
|   Parameter   | Argument to a Cmdlet/Function/Script          |
|     Alias     | Shortcut for a Cmdlet or Function             |
|    Scripts    | Text files with .psl extension                |
| Applications  | Existing windows programs                     |
|   Pipelines   | Pass objects Get-Process word or Stop-Process |
|    Ctrl+C     | interrupt current command                     |
|    Insert     | Toggles between insert/overwrite mode         |
|      F7       | Command history in a window                   |
| Tab/Shift+Tab | Command line completion                       |

## Import, Export, Convert
---
|    Command    |     Command     |
| :-----------: | :-------------: |
| Export-CliXML |  Import-CliXML  |
| ConvertTo-XML | ConvertTo-HTML  |
|  Export-CSV   |   Import-CSV    |
| ConvertTo-CSV | ConvertFrom-CSV |

## Flow Control
---
| Command                                                       |
| ------------------------------------------------------------- |
| If()[] Elseif()[] Else[]                                      |
| While()[]                                                     |
| For($i=0; $i-It 10; $i++)[]                                   |
| Foreach(\$file in dir C:\\)[\$file.name]1..10 \| foreach[\$_] |

## Comments, Escape characters
---
|   Command   | Description       |
| :---------: | ----------------- |
|  #Comment   | Comment           |
| <#comment#> | Multiline comment |
| "`"test`""  | Escape char `     |
|     `t      | Tab               |
|     `n      | New line          |
|      `      | Line continue     |

