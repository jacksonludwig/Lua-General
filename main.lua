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

    local thisIsLocal = io.read()

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
-- beginning value, end value, step value
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

x, y, z = 1, 2, 3, 4 -- 4 thrown out

function giveMeAList(a, b, c)
    print(a, b, c) -- tabs between each value
    return 4, 8, 15, 16, 23, 42
end
x, y = giveMeAList("jackson")
print(x, y) -- extra returns are discarded
