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

  local function stringify(value, depth)
    if depth > maxDepth then
      return '{..}'
    end
    
    if type(value) ~= 'table' then
      return tostring(value)
    end
    
    local lines = { '{\n' }

    -- count the total number of elements in the table to determine if we need to add a comma after the last element
    local totalElements = 0
    for k, v in pairs(value) do
      totalElements = totalElements + 1
    end


    local currentElement = 0
    for key, val in pairs(value) do
      currentElement = currentElement + 1
      local line
      if type(key) == 'number' then
        line = indent:rep(depth)
      else  
        line = indent:rep(depth) .. tostring(key) .. ' = '
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
    table.insert(lines, indent:rep(depth - 1) .. '}\n')

    return table.concat(lines)
  end
  
  return stringify(t, 1)
end

local function main()
  local rootElement = setupRootElement()
  print(table.tostring(rootElement, 3, '  '))
end

main()
