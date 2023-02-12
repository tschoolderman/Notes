# Python virtual environments <!-- omit from toc -->  

[python docs on venv](https://docs.python.org/3/library/venv.html)  
[Real Python venv](https://realpython.com/python-virtual-environments-a-primer/)  

## Contents <!-- omit from toc -->  
---
- [Creating venv](#creating-venv)  
- [pip](#pip)  

&nbsp;
## Creating venv  
---
A virtual environment can be creating by the code below.  
In VSCode a prompt will be shown to use the environment as a workspace.  
Press 'yes' on the prompt. The `Black` formatter set-up for the user on VSCode should work in the `venv`.  

```python
$ py -m venv venv --prompt PROMPT
$ python <command> <path/to/file> <change prompt of venv in terminal>
# If already in right directory 'venv' will suffice
# When no prompt is given, default prompt is venv
```  
An example of a venv with custom prompt:  
```python
$ py -m venv venv --prompt AoC
```  
```powershell
(AoC) PS $>
```  

&nbsp;
## pip  
---
Using `pip` for environments and general use.  
Installing dependencies from `requirements.txt`.  
```powershell
$ pip install -r requirements.txt
```  

Using `pip` to create a `requirements.txt` file.  
```powershell
$ pip freeze > requirements.txt
```
