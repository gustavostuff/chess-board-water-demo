local g3d = require 'g3d'
local colors = require 'colors'

local renderer3d = {}
local pieceGap = 1
local squareObj = 'assets/models/square.obj'
local squareTexture
local waterObject = 'assets/models/water.obj'
local waterTexture = 'assets/textures/water.png'

local function _generate3dModel(x, y, value)
  if ((x + y) % 2 == 0) then
    squareTexture = 'assets/textures/wood-clear.png'
  else
    squareTexture = 'assets/textures/wood.png'
  end

  return g3d.newModel(squareObj, squareTexture,
    -- translation
    {
      (x - 1) * pieceGap,
      _G.boardSizeY - (y - 1) * pieceGap,
      0
    },
    -- rotation
    {
      math.rad(90), 0, 0
    },
    -- scale
    {
      1, value, 1
    }
  )
end

function renderer3d:init(board)
  self.pieces = {}
  self.board = board
  self.background = g3d.newModel(
    'assets/models/sphere.obj', 
    'assets/textures/stars.png',
    nil,
    nil,
    500
  )

  -- create squares on the chess board
  local items = board.items
  for y = 1, #items do
    local row = items[y]
    for x = 1, #row do
      local value = row[x]
      table.insert(self.pieces, _generate3dModel(x, y, value))
    end
  end

  -- create water prisma
  self.water = g3d.newModel(waterObject, waterTexture,
    {0, 1, 0.4},
    {math.rad(90), 0, 0},
    {1, 1, 2}
  )
  self.water:setScale(_G.boardScale, 1, _G.boardScale)
  self.waterLevelIndex = 1
  self.maxWaterLevel = board.max

  -- camera stuff
  g3d.camera.lookAt(
    0, 0, 6,
    4, 0, 8
  )
  self.camera = g3d.camera
end

function renderer3d:update(dt)
  g3d.camera.firstPersonMovement(dt)
end

function renderer3d:changeCameraLook(dx, dy)
  g3d.camera.firstPersonLook(dx, dy)
end

function renderer3d:changeWaterLevel(value)
  self.waterLevelIndex = self.waterLevelIndex + value

  if self.waterLevelIndex > self.board.max then
    self.waterLevelIndex = self.board.max
  end
  if self.waterLevelIndex < 1 then
    self.waterLevelIndex = 1
  end
  -- scale in Z
  self.water:setScale(_G.boardScale, self.waterLevelIndex, _G.boardScale)
end

function renderer3d:draw()
  love.graphics.setColor(colors.white)
  self.background:draw()
  for _, piece in ipairs(self.pieces) do
    piece:draw()
  end

  self.water:draw()
end


return renderer3d
