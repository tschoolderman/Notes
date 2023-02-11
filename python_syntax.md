# Memo's for Python syntax <!-- omit from toc -->  
Additional links for info and reading:  
- [Python cheatsheet docs](https://www.pythoncheatsheet.org/)  
- [Python commands in PDF](https://cheatography.com/davechild/cheat-sheets/python/)  
- [The Hitchhiker’s Guide to Python!](https://docs.python-guide.org/)  
- [Python docs](https://docs.python.org/3/)  
- [Python Enhancement Proposals (PEPs)](https://peps.python.org/)  
- [Short Python 3 intro](https://learnxinyminutes.com/docs/python/)  

## Contents <!-- omit from toc -->  
---
- [Operators](#operators)
- [Comprehensions](#comprehensions)
  - [- Basic comprehension](#--basic-comprehension)
  - [- Comprehension with filter](#--comprehension-with-filter)
  - [- Comprehension with calculation](#--comprehension-with-calculation)
  - [- Comprehension with filter and calculation](#--comprehension-with-filter-and-calculation)
- [Switch-case statements](#switch-case-statements)

---
&nbsp;

## Operators  
---
From **highest** to **lowest** precedence:  
| Operators | Operation         | Example       |
| :-------: | ----------------- | ------------- |
|    **     | Exponent          | 2 ** 3 = 8    |
|     %     | Modulus/Remainder | 22 % 8 = 6    |
|    //     | Integer division  | 22 // 8 = 2   |
|     /     | Division          | 22 / 8 = 2.75 |
|     *     | Multiplication    | 3 * 3 = 9     |
|     -     | Subtraction       | 5 - 2 = 3     |
|     +     | Addition          | 2 + 2 = 4     |

&nbsp;

## Comprehensions  
---
### - Basic comprehension  
For each iteration in numbers add to list.
```python 
numbers = [x for x in numbers]
```  
&nbsp;
### - Comprehension with filter  
Add odd number to list. Modulo calculates the remainder after a division.
```python
odd_numbers = [x for x in numbers if x % 2 == 1]
```
&nbsp;
### - Comprehension with calculation  
Multiplies 'x' for each in the variable.
```python
[x * x for x in numbers]
```
&nbsp;
### - Comprehension with filter and calculation  
Multiplies 'x' for each in the variable if the variable is larger than 25.
```python
squares = [x * x for x in numbers if x > 25]
```
&nbsp;

## Switch-case statements  
---
Same as seen in Java. 
Matching single values:   
```python
response_code = 201
match response_code:
     case 200:
         print("OK")
     case 201:
         print("Created")
     case 300:
         print("Multiple Choices")
     case 307:
         print("Temporary Redirect")
     case 404:
         print("404 Not Found")
     case 500:
         print("Internal Server Error")
     case 502:
         print("502 Bad Gateway")

# Created
```
&nbsp;

Matching with the `or` pattern:  
```python
response_code = 502
match response_code:
     case 200 | 201:
         print("OK")
     case 300 | 307:
         print("Redirect")
     case 400 | 401:
         print("Bad Request")
     case 500 | 502:
         print("Internal Server Error")

# Internal Server Error
```
&nbsp;

Matching by the length of an iterable:  
```python
today_responses = [200, 300, 404, 500]
match today_responses:
     case [a]:
             print(f"One response today: {a}")
     case [a, b]:
             print(f"Two responses today: {a} and {b}")
     case [a, b, *rest]:
             print(f"All responses: {a}, {b}, {rest}")

# All responses: 200, 300, [404, 500]
```
&nbsp;

Default value defined by the `_`-symbol:  
```python
response_code = 800
match response_code:
     case 200 | 201:
         print("OK")
     case 300 | 307:
         print("Redirect")
     case 400 | 401:
         print("Bad Request")
     case 500 | 502:
         print("Internal Server Error")
     case _:
         print("Invalid Code")

# Invalid Code
```
&nbsp;

Matching based on variable type:  
```python
response_code = "300"
match response_code:
     case int():
             print('Code is a number')
     case str():
             print('Code is a string')
     case _:
             print('Code is neither a string nor a number')

# Code is a string
```
```python
response_code = 300
match response_code:
     case int():
             if response_code > 99 and response_code < 500:
                 print('Code is a valid number')
     case _:
             print('Code is an invalid number')

# Code is a valid number
```
