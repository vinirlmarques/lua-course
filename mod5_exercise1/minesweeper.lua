local Board = require('./mod5_exercise1/board')
local Minesweeper = {}

function Minesweeper.create(config)
  local minesweeper = {}
  minesweeper.startTime = os.time()
  minesweeper.config = config
  minesweeper.board = Board.create(config.difficulty.rows, config.difficulty.cols, '-')

  minesweeper.rows = config.difficulty.rows
  minesweeper.cols = config.difficulty.cols

  minesweeper.flagsPlaced = 0
  minesweeper.totalBombs = config.difficulty.bombs

  minesweeper.opened = {}
  minesweeper.flags = {}
  minesweeper.mines = {}

  for i = 1, minesweeper.rows do
    minesweeper.opened[i] = {}
    minesweeper.flags[i] = {}
    minesweeper.mines[i] = {}

    for j = 1, minesweeper.cols do
      minesweeper.opened[i][j] = false
      minesweeper.flags[i][j] = false
      minesweeper.mines[i][j] = false
    end
  end

  local bombs = minesweeper.totalBombs
  while bombs > 0 do
    local i = math.random(1, minesweeper.rows)
    local j = math.random(1, minesweeper.cols)

    if not minesweeper.mines[i][j] then
      minesweeper.mines[i][j] = true
      bombs = bombs - 1
    end
  end

  if config.cheatMode then
    print('Cheat mode enabled!')
  end

  print('Minesweeper is starting...')

  setmetatable(minesweeper, {
    __index = Minesweeper
  })

  return minesweeper
end

function Minesweeper:countNeighbors(row, col)
  local count = 0

  for i = row - 1, row + 1 do
    for j = col - 1, col + 1 do
      if self.mines[i] and self.mines[i][j] then
        count = count + 1
      end
    end
  end

  if self.mines[row][col] then
    count = count - 1
  end

  return count
end

function Minesweeper:updateBoardView(showAll)
  for i = 1, self.rows do
    for j = 1, self.cols do

      local value

      if self.flags[i][j] then
        value = "F"

      elseif not self.opened[i][j] then
        if showAll and self.mines[i][j] then
          value = "*"
        else
          value = "-"
        end

      elseif self.mines[i][j] then
        value = "*"

      else
        value = tostring(self:countNeighbors(i, j))
      end

      self.board:setValue(i, j, value)
    end
  end
end

function Minesweeper:placeFlag(row, col)
  if not self.flags[row][col] then
    self.flags[row][col] = true
    self.flagsPlaced = self.flagsPlaced + 1
  end
end

function Minesweeper:openCell(row, col)
  self.opened[row][col] = true
end

function Minesweeper:runCheat()
  local cells = {}
  -- collect all board coordinates into a flat list
  for i = 1, self.rows do
    for j = 1, self.cols do
      cells[#cells + 1] = { i, j }
    end
  end

  -- shuffle the list
  for k = #cells, 2, -1 do
    local r = math.random(1, k)
    cells[k], cells[r] = cells[r], cells[k]
  end

  -- open or flag each cell in random order
  for _, cell in ipairs(cells) do
    local i, j = cell[1], cell[2]

    if self.mines[i][j] then
      self:placeFlag(i, j)
    else
      self:openCell(i, j)
    end

    self:updateBoardView(true)
    self.board:draw()
  end
end

function Minesweeper:runGame()
  while true do
    self:updateBoardView()
    self.board:draw()

    io.write("Row: ")
    local row = tonumber(io.read())

    io.write("Col: ")
    local col = tonumber(io.read())

    if self:validateInput(row, col) then
      io.write("Action (o=open, f=flag): ")
      local action = io.read()

      if action == "f" then
        self:placeFlag(row, col)

      else
        if self.mines[row][col] then
          print("BOOM! Game Over!")
          self:updateBoardView(true)
          self.board:draw()
          break
        end

        self:openCell(row, col)

        if self:checkWin() then
          print("You win!")
          self:updateBoardView(true)
          self.board:draw()
          break
        end
      end
    end
  end
end

function Minesweeper:validateInput(row, col)
  if not row or not col then
    print("Invalid input!")
    return false
  end

  if row < 1 or row > self.rows or col < 1 or col > self.cols then
    print("Out of bounds!")
    return false
  end

  if self.opened[row][col] then
    print("Cell already opened!")
    return false
  end

  return true
end

function Minesweeper:checkWin()
  for i = 1, self.rows do
    for j = 1, self.cols do
      if not self.mines[i][j] and not self.opened[i][j] then
        return false
      end
    end
  end
  return true
end

function Minesweeper:run()
  print('Minesweeper is starting...')

  if self.config and self.config.cheatMode then
    self:runCheat()
  else
    self:runGame()
  end

  local elapsed = os.time() - self.startTime
  print('Time elapsed: ' .. elapsed .. 's')
  print('Flags: ' .. self.flagsPlaced .. '/' .. self.totalBombs)

  print('Minesweeper has finished!')
end

return Minesweeper
