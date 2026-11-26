local push = require "lib.push"
Class = require "lib.class"

require "classes.bird"
require "classes.pipe"

local background = love.graphics.newImage("images/background.png")
local backgroundScroll = 0

local ground = love.graphics.newImage("images/ground.png")
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

local bird = Bird()

local pipes = {}
local spawnTimer = 0

function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setTitle("Flappy Bird!")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    resizable = true,
    vsync = true,
    fullscreen = false
  })
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, { upscale = "normal" })

  --input table
  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  --add to our table of keys pressed this frame
  love.keyboard.keysPressed[key] = true
  if key == "escape" then
    love.event.quit()
  end
end

--[[
  New function used to check our global input table for keys activated during this frame
]]
function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
  spawnTimer = spawnTimer + dt

  if spawnTimer > 2 then
    table.insert(pipes, Pipe())
    print('Added new pipe!')
    spawnTimer = 0
  end

  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT

  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH


  for k, pipe in pairs(pipes) do
    pipe:update(dt)

    -- if pipe is no longer visible past left edge, remove it from scene
    if pipe.x < -pipe.width then
      table.remove(pipes, k)
    end
  end
  bird:update(dt)

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()

  love.graphics.draw(background, -backgroundScroll, 0)
  bird:render()
  
  for k, pipe in pairs(pipes) do
    pipe:render()
  end 
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  push:finish()
end
