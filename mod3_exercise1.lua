local sampleNames = { "Maria", "Lucia", "Arthur", "Boris", "Newton" }
local testN = 10000
local users = {}

function binarySearch(lowerName)
  local inf = 1
  local sup = #users
  while inf <= sup do
    local meio = math.floor((inf + sup) / 2)
    if lowerName < users[meio].name then
      sup = meio - 1
    else
      inf = meio + 1
    end
  end
  return inf
end

function registerUser(name)
  local lowerName = string.lower(name)
  local pos = binarySearch(lowerName)                       
  table.insert(users, pos, { id = #users, name = lowerName })
end

function registerUsers(names)
  for _,name in ipairs(names) do
    registerUser(name)
  end
end

function main()
  local names = {}
  local n = #sampleNames
  for i=1,testN do
    names[i] = sampleNames[((i-1) % n)+1]  .. i
  end
  
  registerUser('Fulano')
  registerUsers(names)
  registerUser('Beltrano')
  print('Users registered: ', #users)
end

main()
