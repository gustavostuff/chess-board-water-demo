local function generateRandomBoard()
  local newBoard = {
    items = {}
  }
  local max = 1
  local text = ''
  for y = 1, _G.boardSizeY do
    local newRow = {}
    table.insert(newBoard.items, newRow)
    for x = 1, _G.boardSizeX do
      local value = love.math.random(1, boardSizeZ)
      if value > max then max = value end
      table.insert(newRow, value)
      text = text .. value .. ', '
    end
    text = text .. '\n'
  end
  
  newBoard.max = max
  print(text)
  return newBoard
end

local boards = {
  ['clay'] = {
    max = 5,
    items = {
      {2, 2, 2, 2, 5, 2, 1, 1},
      {3, 3, 3, 5, 2, 5, 2, 1},
      {3, 1, 1, 1, 4, 2, 2, 1},
      {2, 3, 2, 2, 2, 3, 3, 2},
      {3, 2, 3, 3, 3, 2, 3, 2},
      {3, 2, 4, 2, 2, 3, 1, 2},
      {2, 3, 3, 2, 2, 3, 2, 1},
      {1, 2, 2, 3, 3, 2, 2, 1},
    }
  },
  ['simple'] = {
    max = 4,
    items = {
      {2, 2, 2, 1, 1, 1, 3, 4},
      {2, 1, 1, 2, 1, 1, 2, 3},
      {2, 1, 1, 2, 1, 1, 1, 1},
      {1, 2, 2, 1, 1, 1, 1, 1},
      {1, 1, 1, 1, 1, 1, 1, 1},
      {1, 1, 1, 1, 1, 1, 1, 1},
      {1, 1, 1, 1, 1, 1, 1, 1},
      {4, 1, 2, 3, 4, 1, 1, 1},
    }
  },
  ['random'] = generateRandomBoard()
}

return boards
