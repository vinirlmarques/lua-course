local function partition(arr, low, high)
  local pivot = arr[high]
  local i     = low - 1

  for j = low, high - 1 do
    if arr[j] <= pivot then
      i = i + 1
      local temp = arr[i]
      arr[i]     = arr[j]
      arr[j]     = temp
    end
  end

  local temp = arr[i + 1]
  arr[i + 1] = arr[high]
  arr[high]  = temp
  return i + 1
end

local function quickSort(arr, low, high)
  low  = low  or 1
  high = high or #arr

  if low >= high then
    return
  end

  local pivot_idx = partition(arr, low, high)

  quickSort(arr, low,           pivot_idx - 1)
  quickSort(arr, pivot_idx + 1, high)
end

local function generateOrderedArray(n)
  local arr = {}
  local i   = 1
  while i <= n do
    arr[i] = i
    i      = i + 1
  end
  return arr
end


-- Example O(n log n) usage:
local numbers = {38, 12, 57, 3, 91, 24, 66, 7, 45, 19}
quickSort(numbers, 1, #numbers)
-- print("Sorted list:", table.concat(numbers, ", "))

-- Example O(n^2) usage:
local arr = generateOrderedArray(10000)

local t1    = os.clock()
quickSort(arr, 1, #arr)
local timeTaken = os.clock() - t1

-- print("Sorted list:", table.concat(arr, ", "))
print("Time taken:", timeTaken)
