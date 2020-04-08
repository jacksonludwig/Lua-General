--https://learnxinyminutes.com/docs/lua/ IFFY SUMMARY
--https://www.lua.org/pil/1.2.html VARIABLE INTRO/HOW TO DELETE GLOBALS
--https://www.lua.org/pil/2.html TYPES/VARIABLES
--https://www.lua.org/pil/2.4.html CHANGING STRINGS
--https://www.lua.org/pil/4.1.html ASSIGNMENT
--https://www.lua.org/pil/4.2.html LOCAL VARS AND BLOCKS
--https://www.lua.org/pil/4.3.html LOOPS
--https://www.lua.org/pil/2.5.html TABLES
--https://www.lua.org/pil/3.6.html TABLE CONSTRUCTORS
--https://www.lua.org/pil/2.6.html FUNCTIONS

s = io.read("*n") -- read a number
s = io.read("*l") -- read a line (default when no parameter is given)
s = io.read("*a") -- read the complete stdin
s = io.read(7) -- read 7 characters from stdin
x, y = io.read(7, 12) -- read 7 and 12 characters from stdin and assign them to x and y
a, b = io.read("*n", "*n") -- read two numbers and assign them to a and b

num = 42

a_string = "single quotes or double make immutable strings... only one liners"

big_string = [[ double brackets start and 
weirdly end multi line strings...]]

empty = nil -- garbage collection... and null pointers

while num < 50 do
    num = num + 1 -- no += or similar shorthand
    print(num)
end

if num > 40 then
    print("over 40")
elseif a_string == big_string then
    io.write("not over 40\n") -- can be used for files, etc. and does not add new lines or tabs
else
    thisIsGlobal = 5

    local thisIsLocal = io.read() -- TRY TO DO THIS WHENEVER POSSIBLE, FASTER, SAFER

    print("String concatenation uses two dots " .. thisIsLocal)
end

thisIsActuallyNotAnError = unknownVariable -- this is nil, not an error

aBool = false

if not aBool then
    print("This was false")
end

-- and/or short circuited, so:
-- the following is like a ? b : c in other languages
ans = aBool and "yes" or "no" --> no

print()

num2 = 0
-- beginning value, end value, step value (not needed if 1)
for i = 0, 99, 1 do
    num2 = num2 + 1
end
print("For loop number is now: " .. num2)

-- do while loop thing
repeat
    print("This is kind of like a do while")
    num = num - 1
    print(num)
until num == 0

function fib(n)
    if n < 2 then
        return 1
    end
    return fib(n - 2) + fib(n - 1)
end

-- returns a function remembering x's value
function adder(x)
    return function(y)
        return x + y
    end
end
-- the following are the same:
function f(x)
    return x * x
end
f = function(x)
    return x * x
end

x, y, z = 1, 2, 3, 4 -- 4 thrown out

function giveMeAList(a, b, c) -- NOT REALLY A LIST: it returns multiple values!
    print(a, b, c) -- tabs between each value
    return 4, 8, 15, 16, 23, 42
end
x, y = giveMeAList("jackson") -- missing arguments are printed as nil values
print(x, y) -- extra returns are discarded

-- the following are the same:
local function g(x)
    return math.sin(x)
end
local g
g = function(x)
    return math.sin(x)
end

g = g(5)
print(g)

-- TABLES*
-- can be used as many structures, e.g. arrays if we use integers as indexes
-- using tables as dictionaries/maps
-- string keys by default
aTable = {key1 = "value1", key2 = false}

-- js-like dot notation (works for strings)
print(aTable.key1)
aTable.newKey = "newValue" -- new key-value pair
aTable.key2 = nil --remove key from the table (key 2 in this case)
print(aTable.newKey)

a = {} -- empty table
-- create 1000 new entries
for i = 1, 1000 do
    a[i] = i * 2
end
print(a[9]) --> 18
a["x"] = 10
print(a["x"]) --> 10
print(a["y"]) --> nil

-- to clarify:
--a["x"] and a.x ARE THE SAME
print(a["x"])
print(a.x)

--Table iteration:
for key, val in pairs(aTable) do
    print(key, val)
end

function h(x)
    print(x.key1)
end
h({key1 = "Table Declaration in Function call"})

-- _G IS SPECIAL TABLE OF ALL GLOBALS
print(_G["_G"] == _G)

--tables as lists and arrays:
-- List literals implicitly set up int keys:
list = {"Im a string", 2.0, false, "c"}
for i = 1, #list do -- "#" means "size" --> #list means "get me the size of list"
    print(list[i]) -- INDEX START AT ONE
end
-- THIS IS STILL JUST A TABLE:
for key, val in pairs(list) do
    print(key, val)
end

--metatables and C++ like operation overloading
fraction1 = {num = 1, denom = 2} --> this can be used, for example, to represent 1/2
fraction2 = {num = 2, denom = 3}

-- WE CANT CURRENTLY ADD FRACTION1 AND FRACTION2, SO:
metafraction = {}
function metafraction.__add(f1, f2)
    sum = {}
    sum.denom = f1.denom * f2.denom
    sum.num = f1.num * f2.denom + f2.num * f1.denom
    return sum
end

setmetatable(fraction1, metafraction)
setmetatable(fraction2, metafraction)
sum = fraction1 + fraction2
print(sum.num .. " / " .. sum.denom)
