Bird = Class {}

local GRAVITY = 20

function Bird:init()
  self.image = love.graphics.newImage("images/bird.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

  self.dy = 0
end

function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt

  --negative gravity when we hit space
  if love.keyboard.wasPressed("space") then
    self.dy = -5
  end

  if (self.y + self.dy) > (VIRTUAL_HEIGHT - (self.height + 16)) then
    self.y = VIRTUAL_HEIGHT - (self.height + 16)
  elseif (self.y + self.dy) < 0 then
    self.y = 0
  else
    self.y = self.y + self.dy
  end
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end
