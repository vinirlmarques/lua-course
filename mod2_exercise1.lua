local function setupRootElement()
  local root = {}
  root.id = 'rootElement'
  root.visible = true
  root.color = 'red'
  root['background color'] = 'yellow'
  root.text = 'Main Window'
  root.children = {
    { id = 'child1', zOrder = 1, visible = true, parent = root },
    { id = 'child2', zOrder = 2, visible = true, parent = root },
    { id = 'child3', zOrder = 3, visible = false, clickVolume = 0.02, parent = root },
  }
  root.savedIndexes = { 4, 1, 3, 2, 5, total = 5 }
  root.layoutPositions = { 'top', 'left', 'bottom', 'right' }
  root.innerLengths = { x = 1, l = { x = 2, l = { x = 3, l = { x = 4, l = { x = 5, l = { x = 6 } } } } } }

  return root
end

function table.tostring(t, maxDepth, indent)
  local indent = indent or '  '
  local visited = {}

  local function stringify(value, depth)
    if depth > maxDepth then
      return '"{..}"'
    end
  
    if type(value) ~= 'table' or visited[value] then
      return '"' .. tostring(value) .. '"'
    end
    
    visited[value] = true
    
    local lines = { '{\n' }

    -- count the total number of elements in the table to determine if we need to add a comma after the last element
    local totalElements = 0
    for k, v in pairs(value) do
      totalElements = totalElements + 1
    end

    local isArray = false
    local arrayCounter = 0

    -- verify if the table is an array
    for key, value in pairs(value) do
      arrayCounter = arrayCounter + 1
      if type(key) ~= 'number' or arrayCounter ~= key then
        isArray = false
        break
      elseif arrayCounter == key then
        isArray = true
      end
    end


    local currentElement = 0
    for key, val in pairs(value) do
      currentElement = currentElement + 1
      local line
      if isArray then
        line = indent:rep(depth)
      else
        local keyStr = tostring(key)
        if type(key) == 'number' then
          line = indent:rep(depth) .. '[' .. keyStr .. '] = '
        elseif string.find(keyStr, ' ') then
          line = indent:rep(depth) .. '["' .. keyStr .. '"] = '
        else
          line = indent:rep(depth) .. keyStr .. ' = '
        end
      end

      -- if the value is a table, recursively stringify it     
      if type(val) == 'table' then
        line = line .. stringify(val, depth + 1)
      elseif type(val) == 'string' then
        line = line .. '"' .. tostring(val) .. '"'
      else 
        line = line .. tostring(val)
      end
      
      if currentElement < totalElements then
        table.insert(lines, line .. ',\n')
      else 
        table.insert(lines, line .. '\n')
      end
    end
    
    -- close the table with the appropriate indentation
    table.insert(lines, indent:rep(depth - 1) .. '}')

    return table.concat(lines)
  end
  
  return stringify(t, 1)
end


local function main()
  local rootElement = setupRootElement()
  print(table.tostring(rootElement, 4, '  '))
end

main()
