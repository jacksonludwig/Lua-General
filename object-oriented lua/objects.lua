Account = {balance = 0}
function Account.withdraw(value)
    Account.balance = Account.balance - value
end
--> This uses a table and it's values to create what looks like a class and methods.
--> The function withdraw is stored inside the "withdraw" field of the Account table.
Account.withdraw(100.00)
print(Account.balance)
--> This is still static and will not work if the Account variable is removed
--> We want non-static/shared values
function Account.withdraw(self, value)
    self.balance = self.balance - value
end
--> Now we can change the value of a specific object, but we must pass in the object we want to change
local acc1 = Account
Account = nil
acc1.withdraw(acc1, 100.00)
print(acc1.balance)

function Account:withdraw(value)
    self.balance = self.balance - value
end
--> the above function simply uses the colon as syntatic sugar for the "self" value that would be an argument
--> (it is the same as the function above it)


