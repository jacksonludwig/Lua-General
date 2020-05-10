t1 = {}
print(getmetatable(t1))

t2 = {}
setmetatable(t1, t2)
assert(getmetatable(t1) == t2)

-------------------------------------------------------------------------------

-- metatables don't do the usual data storage; they instead only store metamethods
local normal = {

}
local meta = {
    __index = function(tab, key)
        print("Tried to index table for " .. key .. " - doesn't exist")
        return "default value here"
    end
}
setmetatable(normal, meta)
print(normal.x)


------------------------------------------------------------------------
local john = {}
print(john.money)

local bill = { money = 9999999 }
print(bill.money)

local meta = { __index = bill } -- look to bill for values if john doesn't have
setmetatable(john, meta)

print(john.money)

-------------------------------------------------------------------------
Character = {}
Character.prototype = { name = "", strength = 0 } -- Add a key for base fields
Character.metatable = { __index = Character.prototype } -- Add a key for meta

function Character:new(o)
    setmetatable(o, Character.metatable)
    return o
end

local newCharacter = Character:new({ name = "mario", strength = 5 })

print(newCharacter.name, newCharacter.strength)
------------------------------------------------------------------------

--rbx example
local Maid = {__index = {}}

function Maid.new()
    return setmetatable({tasks = {}}, {__index = Maid.__index})
end

function Maid:add(task)
    table.insert(self.tasks, task)
end

function Maid:clean()
    for index=#self.tasks, 1, -1 do
        local task = self.tasks[index]
        local taskType = typeof(task)

        if taskType == "function" then
            task()
        elseif taskType == "Instance" then
            task:Destroy()
        elseif taskType == "RBXScriptConnection" then
            task:Disconnect()
        end
    end
    self.tasks = {}
end

return Maid
