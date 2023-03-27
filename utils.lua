local colors = require 'colors'

local utils = {}

function utils:split(input, sep)
  if not sep then
    sep = '%s'
  end

  local t = {}

  for str in string.gmatch(input, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end

  return t
end

function utils:getKey(x, y, z)
  return x .. ',' .. y .. ',' .. z
end

-- shadow print
function utils.sp(text, x, y)
  love.graphics.setColor(colors.black)
  love.graphics.print(text, x - 1, y + 1)
  love.graphics.setColor(colors.white)
  love.graphics.print(text, x, y)
end

function utils.getLen(tbl)
  local count = 0
  for k, v in pairs(tbl) do
    count = count + 1
  end
  return count
end

function utils:getCoords(key)
  local values = self:split(key, ',')
  local x, y, z = values[1], values[2], values[3]
  return tonumber(x), tonumber(y), tonumber(z)
end

return utils
