local push = require "push"
local background = love.graphics.newImage("images/background.png")
local backgroundScroll = 0

local ground = love.graphics.newImage("images/ground.png")
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local VIRTUAL_WIDTH = 512
local VIRTUAL_HEIGHT = 288

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

function love.load()
  love.window.setTitle("Flappy Bird!")
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    resizable = true,
    vsync = true,
    fullscreen = false
  })
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, { upscale = "normal" })
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT


  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
end

function love.draw()
  push:start()


  love.graphics.draw(background, -backgroundScroll, 0)
  love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  push:finish()
end
