
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

local function partitionRandom(arr, low, high)
  local rand_idx = math.random(low, high)

  local temp         = arr[rand_idx]
  arr[rand_idx]      = arr[high]
  arr[high]          = temp

  return partition(arr, low, high)
end

local function quickSortRandom(arr, low, high)
  low  = low  or 1
  high = high or #arr

  if low >= high then
    return
  end

  local pivot_idx = partitionRandom(arr, low, high)

  quickSortRandom(arr, low,           pivot_idx - 1)
  quickSortRandom(arr, pivot_idx + 1, high)
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

-- Example O(n log n) fixed usage:
math.randomseed(os.time())
local arr_random = generateOrderedArray(10000)

local t1    = os.clock()
quickSortRandom(arr_random, 1, #arr_random)
local timeTaken = os.clock() - t1

-- print("Sorted list:", table.concat(arr_random, ", "))
print("Time taken:", timeTaken)