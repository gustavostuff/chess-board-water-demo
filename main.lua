-- global suff

_G.boardSizeZ = 8
_G.boardScale = 1
_G.boardSizeX = 8 * _G.boardScale
_G.boardSizeY = 8 * _G.boardScale

_G.font = love.graphics.newFont('assets/fonts/proggy-tiny/proggy-tiny.ttf', 16)
_G.font:setFilter('nearest', 'nearest')

love.math.setRandomSeed(os.time())

-- end of globals

local colors = require 'colors'
local boards = require 'boards'
local renderer2d = require 'renderer-2d'
local renderer3d = require 'renderer-3d'
local utils = require 'utils'

function love.load()
  canvas = love.graphics.newCanvas(320, 180)
  canvas:setFilter('nearest', 'nearest')
  sx = love.graphics.getWidth() / canvas:getWidth()
  sy = love.graphics.getHeight() / canvas:getHeight()
  love.graphics.setLineStyle('rough')
  love.graphics.setLineWidth(1)

  love.graphics.setFont(font)

  currentBoard = boards.random
  renderer2d:init(currentBoard)
  renderer3d:init(currentBoard)
  renderer3d:changeCameraLook(0, 0)
end

function love.update(dt)
  renderer3d:update(dt)
end

local function _printDebug()
  local cam = renderer3d.camera
  local camX, camY, camZ = cam.position[1], cam.position[2], cam.position[3]
  local rX, rY, rZ = cam.target[1], cam.target[2], cam.target[3]

  local text = 'FPS: ' .. love.timer.getFPS() ..
    -- '\ncamera position: ' .. (camX .. ',' .. camY .. ',' .. camZ) ..
    -- '\ncamera target: ' .. (rX .. ',' .. rY .. ',' .. rZ) ..
    ''

    utils.sp(text, 2, love.graphics.getHeight() - _G.font:getHeight() * 1)
end

function love.draw()
  love.graphics.setCanvas({ canvas, depth = true })
  love.graphics.clear(colors.green)

  renderer3d:draw()
  renderer2d:drawTopology(currentBoard)
  renderer2d:drawSlice()
  renderer2d:printInfo()

  love.graphics.setCanvas()
  love.graphics.setColor(colors.white)
  love.graphics.draw(canvas, 0, 0, 0, sx, sy)

  _printDebug()
end

function love.keypressed(k)
  if k == 'escape' then
    love.event.push('quit')
  end

  if k == 'up' then
    renderer2d:changeSlice(1)
    renderer3d:changeWaterLevel(1)
  end
  if k == 'down' then
    renderer2d:changeSlice(-1)
    renderer3d:changeWaterLevel(-1)
  end
end

function love.mousemoved(x, y, dx, dy)
  renderer3d:changeCameraLook(dx, dy)
end
