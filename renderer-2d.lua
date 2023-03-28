local colors = require 'colors'
local utils = require 'utils'

local renderer2d = {}

local function _markViaFloodFill(slice, x, y)
  if (not slice[y]) or (not slice[y][x]) then
    return
  end
      
  if slice[y][x].willFlowOver or (not slice[y][x].empty) then
    return
  end
  
  slice[y][x].willFlowOver = true

  _markViaFloodFill(slice, x + 1, y);
  _markViaFloodFill(slice, x - 1, y);
  _markViaFloodFill(slice, x, y + 1 );
  _markViaFloodFill(slice, x, y - 1 );
end

local function _markWaterToLose(slice)
  -- left perimeter
  for y = 1, #slice do
    _markViaFloodFill(slice, 1, y)
  end
  -- right
  for y = 1, #slice do
    _markViaFloodFill(slice, #slice[1], y)
  end
  -- top
  for x = 1, #slice[1] do
    _markViaFloodFill(slice, x, 1)
  end
  -- bottom
  for x = 1, #slice[1] do
    _markViaFloodFill(slice, x, #slice)
  end
end

local function _generateSliceForFloor(board, floor)
  local slice = {}
  local items = board.items
  for y = 1, #items do
    local row = items[y]
    slice[y] = {}

    for x = 1, #row do
      local item = row[x]
      table.insert(slice[y],
        (item <= floor) and
        { empty = true } or
        { empty = false }
      )
    end
  end

  _markWaterToLose(slice)

  return slice
end

local function _getColorForWater(item)
  return item and (
    item.willFlowOver and colors.magenta or colors.white
  ) or colors.transparent
end

local function _getVolumeOfWater(slices)
  local count = 0
  for _, slice in ipairs(slices) do
    for y = 1, #slice do
      local row = slice[y]

      for x = 1, #row do
        local item = row[x]

        if item.empty and not item.willFlowOver then
          count = count + 0.5
        end
      end
    end

    slice.volumeOfWater = count
  end

  return count
end

function renderer2d:init(board)
  self.board = board
  self.boardX = 10
  self.boardY = 10
  self.squareSize = 5
  self.squarePadding = 0
  self.showTopology = true
  self.sliceIndex = 1

  -- generate slices from bottom to top
  self.slices = {}

  for floor = 1, board.max do
    local slice = _generateSliceForFloor(board, floor)
    table.insert(self.slices, slice)
  end

  self.volumeOfWater = _getVolumeOfWater(self.slices)
end


function renderer2d:drawTopology(board)
  -- perimeter
  local items = board.items

  -- squares
  for y = 1, #items do
    local row = items[y]
    for x = 1, #row do
      local item = row[x]
      local squareX = self.boardX + (x - 1) * (self.squareSize + self.squarePadding)
      local squareY = self.boardY + (y - 1) * (self.squareSize + self.squarePadding)
      local color = colors.heightLevels[item]
      love.graphics.setColor(color)

      love.graphics.rectangle('fill',
        squareX,
        squareY,
        self.squareSize,
        self.squareSize
      )
    end
  end
end

function renderer2d:changeSlice(value)
  self.sliceIndex = self.sliceIndex + value

  if self.sliceIndex > self.board.max then
    self.sliceIndex = self.board.max
  end
  if self.sliceIndex < 1 then
    self.sliceIndex = 1
  end
end

function renderer2d:getCurrentSlice()
  return self.slices[self.sliceIndex]
end

function renderer2d:drawSlice()
  local slice = self:getCurrentSlice()

  for y = 1, #slice do
    local row = slice[y]
    for x = 1, #row do
      local item = row[x]
      love.graphics.setColor(_getColorForWater(item))
      local squareX = self.boardX + (x - 1) * (self.squareSize + self.squarePadding)
      local squareY = self.boardY + (y - 1) * (self.squareSize + self.squarePadding)

      if item.empty then
        love.graphics.rectangle('fill',
          squareX,
          squareY,
          self.squareSize,
          self.squareSize
        )
      end
    end
  end
end

function renderer2d:printInfo()
  love.graphics.setColor(colors.white)
  local y = self.boardY + (#self.board.items * self.squareSize) + self.squareSize
  utils.sp(
    'current level: ' .. self.sliceIndex ..
    -- '\nwater volume per level: ' ..
    --   ((function()
    --     local currentVolume = 0
    --     local text = ''
    --     for i, slice in ipairs(self.slices) do
    --       if slice.volumeOfWater > currentVolume then
    --         currentVolume = slice.volumeOfWater
    --         text = text .. '\n  level ' .. i .. ': ' .. slice.volumeOfWater
    --       end
    --     end
    --     return text
    --   end)()) ..
    '\ntotal water volume: ' .. self.volumeOfWater ..
    '',
    9, y
  )
end

return renderer2d
