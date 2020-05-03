Account = {balance = 0}

function Account:new(object)
    object = object or {}
    setmetatable(object, self)
    self.__index = self
    return object
end

function Account:deposit(value)
    self.balance = self.balance + value
end

function Account:withdraw(value)
    if value > self.balance then error("insufficient funds") end
    self.balance = self.balance - value
end

-----------------------End Parent Class-----------------------

local SpecialAccount = Account:new({limit = 1000}) --> all accounts made from SpecialAccount will have a limit field set initially to 1000
local Test1 = SpecialAccount:new() --> will inherit limit from SpecialAccount
local Test2 = SpecialAccount:new() --> will inherit limit from SpecialAccount
local Test3 = SpecialAccount:new({limit = 5000}) -- overwrite the default value

print(Test1.limit) --> 1000
print(Test2.limit) --> 1000
print(Test3.limit) --> 5000

-----------------------End Child Class-----------------------