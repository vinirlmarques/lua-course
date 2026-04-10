local Hashtable = {}
Hashtable.__index = Hashtable

function Hashtable:create()
    local hashtable = {}
    hashtable.size = 0
    hashtable.reservedSize = 10
    hashtable.data = {}

    setmetatable(hashtable, Hashtable)

    return hashtable
end

function Hashtable:hash(key)
    if type(key) == "string" then
        local sum = 0
        for i = 1, #key do
            sum = sum + string.byte(key, i)
        end
        return (sum % self.reservedSize) + 1

    elseif type(key) == "number" then
        return (key % self.reservedSize) + 1
    end

    return 1
end

function Hashtable:set(key, value)
    local hashIndex = self:hash(key)
    print("to set key", key, "using hash", hashIndex)

    local array = self.data[hashIndex]

    if not array then
        array = {}
        self.data[hashIndex] = array
    end

    for i = 1, #array do
        if array[i][1] == key then
            array[i][2] = value
            return true
        end
    end

    array[#array + 1] = { key, value }
    self.size = self.size + 1

    return true
end

function Hashtable:get(key)
    local hashIndex = self:hash(key)
    local array = self.data[hashIndex]

    if not array then
        return nil
    end

    for i = 1, #array do
        if array[i][1] == key then
            return array[i][2]
        end
    end

    return nil
end

return Hashtable