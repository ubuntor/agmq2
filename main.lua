local levels = require 'levels'
local game = require 'game'
local currentLevel

function love.load()
    love.keyboard.setKeyRepeat(true)
    levels.init()
    currentLevel = levels.loadLevel("level01")
end

function love.draw()
    levels.drawLevel(currentLevel)
end

function love.keypressed(key)
    game.keypressed(key, currentLevel)
end
