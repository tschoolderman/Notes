# Python decorators <!-- omit from toc -->  

## Contents <!-- omit from toc -->  
---
- [Operator overloading](#operator-overloading)
- [Dataclass](#dataclass)
- [Data hiding](#data-hiding)
- [Class methods and constructors](#class-methods-and-constructors)
- [Static methods](#static-methods)
- [Properties](#properties)

## Operator overloading  
---
This means defining operators for custom classes that allow operators such as + and * to be used on them.  
An example magic method is `__add__` for +.  

The `__add__` method allows for the definition of a custom behavior for the + operator in our class.  
As you can see, it adds the corresponding attributes of the objects and returns a new object, containing the result.  
Once it's defined, we can add two objects of the class together.  

```python
class Vector2D:
    def __init__(self, x, y):
        self.x = x
        self.y = y
    def __add__(self, other):
        return Vector2D(self.x + other.x, self.y + other.y)

first = Vector2D(5, 7)
second = Vector2D(3, 9)
result = first + second # Vector2D((5, 7), (3, 9))

print(result.x) # returns 8
>>> def __add__(5, 3) # takes the first from self and other
                      # In the class x is the first argument

print(result.y) # returns 16
>>> def __add__(7, 9) # takes the 2nd from self and other
                      # In the class y is the second argument

```  

More magic methods for common operators:  
`__sub__` for -  
`__mul__` for *  
`__truediv__` for /  
`__floordiv__` for //  
`__mod__` for %  
`__pow__` for **  
`__and__` for &  
`__xor__` for ^  
`__or__` for |  
There are many more magic methods.  

The expression x + y is translated into x.`__add__`(y).
However, if x hasn't implemented `__add__`, and x and y are of different types, then y.`__radd__`(x) is called.
There are equivalent r (reverse) methods for all magic methods just mentioned.

```python
class SpecialString:
    def __init__(self, cont):
        self.cont = cont

    def __truediv__(self, other):
        line = "=" * len(other.cont)
        return "\n".join([self.cont, line, other.cont])

spam = SpecialString("spam")
hello = SpecialString("Hello world!")
print(spam / hello)

# returns:
# spam
# ============
# Hello world!
```  

&nbsp;
## Dataclass  
---
[Python cheatsheet dataclass](https://www.pythoncheatsheet.org/cheatsheet/dataclasses)  
[Realpython dataclasses](https://realpython.com/python-data-classes/)  

```python
from dataclasses import dataclass

# Normal class 
class Number:
    def __init__(self, val):
        self.val = val

@dataclass
class Number:
    val: int

# dataclass with default values
@dataclass
class Product:
    name: str
    count: int = 0
    price: float = 0.0
```  

&nbsp;
## Data hiding  
---
A key part of object-oriented programming is encapsulation, which involves packaging of related variables and functions into a single easy-to-use object -- an instance of a class.  
A related concept is data hiding, which states that implementation details of a class should be hidden, and a clean standard interface be presented for those who want to use the class.  
In other programming languages, this is usually done with private methods and attributes, which block external access to certain methods and attributes in a class.  

The Python philosophy is slightly different. It is often stated as "we are all consenting adults here", meaning that you shouldn't put arbitrary restrictions on accessing parts of a class. Hence, there are no ways of enforcing that a method or attribute be strictly private.  

Weak private methods and attributes have a **single underscore** at the beginning.  
This signals they are private, but can still be used by external code.  

Strong private methods and attributes have **double underscores** at the beginning of their names.  
This causes the name to be mangled and cannot be accessed outside of the class.  
The purpose of this isn't to ensure that they are kept private, but to avoid bugs if there are subclasses that have methods or attributes with the same names.  
Python protects those members by internally changing the name to include the class name.  

```Python
class Spam:
    __egg = 7
    def print_egg(self):
        print(self.__egg)

s = Spam()
s.print_egg()
# returns 7

print(s._Spam__egg)
# return 7

print(s.__egg)
# Traceback (most recent call last):
#   File "file0.py", line 9, in <module>
#     print(s.__egg)
# AttributeError: 'Spam' object has no attribute '__egg'
```  

&nbsp;
## Class methods and constructors  
---
[Further reading on class constructors](https://realpython.com/python-class-constructor/)  
[Multiple constructors](https://realpython.com/python-multiple-constructors/#defining-multiple-class-constructors)  

Class methods are called by a class, which is passed to the `cls` parameter of the method.  
A common use of these are factory methods, which instantiate an instance of a class, using different parameters than those usually passed to the class constructor. Class methods are marked with a classmethod decorator.  

```python
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def calculate_area(self):
        return self.width * self.height

    @classmethod
    def new_square(cls, side_length):
        # cls refers back to the Rectangle class
        # the __init__ method is called, duplicating the single argument
        return cls(side_length, side_length) # makes Rectangle(5, 5)

square = Rectangle.new_square(5)
print(square.calculate_area())
# returns 25
```  

## Static methods  
---
Static methods are methods that don't receive any additional arguments;  
they are identical to normal functions that belong to a class.  
A static method does not need the `self` argument.  

```python
class Pizza:
    def __init__(self, toppings):
        self.toppings = toppings

    @staticmethod
    def validate_topping(topping):
        if topping == "pineapple":
            raise ValueError("No pineapples!")
        else:
            return True

ingredients = ["cheese", "onions", "spam"]
# loop over each ingredient, before it is added to the class
# it runs through the static method to validate ingredients
if all(Pizza.validate_topping(i) for i in ingredients):
    pizza = Pizza(ingredients)
```  
```python
class Shape:
    def __init__(self, w, h):
        self.w = w
        self.h = h

    @staticmethod
    def area(w, h):
        area = w * h
        return area

w = 2
h = 3

print(Shape.area(w, h))
# returns 6
```  

&nbsp;
## Properties  
---
Properties provide a way of customizing access to instance attributes.  
A common use is to make an attribute **read-only**.  

```python
class Pizza:
    def __init__(self, toppings):
        self.toppings = toppings

    @property
    def pineapple_allowed(self):
        return False

pizza = Pizza(["cheese", "tomato"])
print(pizza.pineapple_allowed)  # returns False
pizza.pineapple_allowed = True  # raises an error
```  
```python
class Person:
    def __init__(self, age):
        self.age = int(age)
    
    def is_adult(self):
        if self.age > 18:
            return True
        else
            return False
```  
```python
class Pizza:
    def __init__(self, toppings):
        self.toppings = toppings
        # weak private method
        self._pineapple_allowed = False

    @property
    def pineapple_allowed(self):
        # return the boolean value under __init__
        return self._pineapple_allowed

    # will always run when the Pizza class is called
    @pineapple_allowed.setter
    def pineapple_allowed(self, bool(value)):  # check for bool type
        if value:
            # ask for password when class is called
            password = input("Enter the password: \n")
            if password == "Sw0rdf1sh!":
                self._pineapple_allowed = value
            else:
                # raise error when password isn't correct
                raise ValueError("Alert! Intruder!")

pizza = Pizza(["cheese", "tomato"])  # create object
print(pizza.pineapple_allowed) # False
pizza.pineapple_allowed = True  # change value
print(pizza.pineapple_allowed)  # True
```  
```python
class Player:
    def __init__(self, name, lives):
        self.name = name
        self._lives = lives

    def hit(self):
        self._lives -= 1
    
    #your code goes here
    @property
    def is_alive(self):
        if self._lives > 0:
            return True
        else:
            return False

p = Player("Bob", int(6))
i = 1
while True:
    p.hit()
    print("Hit # " + str(i))
    i += 1
    if p.is_alive == False:  # checks players lives each loop
        print("Game Over")
        break
```