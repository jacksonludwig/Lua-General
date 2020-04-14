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

SpecialAccount = Account:new() --> starts just as a Account object

s = SpecialAccount:new({limit = 1000.00})
s:deposit(3000.00)

function SpecialAccount:withdraw(value) --> "overwrites" old withdraw: Lua does not look in Account for withdraw because it's found in SpecialAccount
    if value - self.balance >= self:getLimit() then
        error("insufficient funds")
    end
    self.balance = self.balance - value
end

function SpecialAccount:getLimit()
    return self.limit or 0
end

print(s.balance)
s:withdraw(30012)

-----------------------End Child Class-----------------------