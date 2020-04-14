a = {} -- Object a
b = {} -- Object b
setmetatable(a, {__index = b}) -- this makes "b" a prototype for "a"
--> Now a looks up in b for any operation that it doesn't have.
--> This uses prototypes to implement inheritance


Account = {balance = 0}

function Account:new(object)
    object = object or {} -- create object if user does not provide one
    setmetatable(object, self)
    self.__index = self
    return object
end

function Account:withdraw(value)
    self.balance = self.balance - value
end

function Account:deposit(value)
    self.balance = self.balance + value
end

acc1 = Account:new({balance = 50}) --> Now, acc1's metatable is Account
acc2 = Account:new({balance = 20}) --> Account's other "methods" are used if the desired method is not found in the object (e.g. withdraw)
print(acc1.balance)
print(acc2.balance)
acc1:withdraw(25) -- Remember, acc1:withdraw(25) is the same as acc1.withdraw(acc1, 25)
print(acc1.balance)
print(acc2.balance)

--> This is now what's happening when a method is called on an Account object:
getmetatable(acc1).__index.deposit(a, 100)
Account.deposit(acc1, 100)
--> The above two statements are equal

acc3 = Account:new()
print(b.balance)
--> This prints "0" because objects inherit fields and methods. No default value was given so it gets Account's.