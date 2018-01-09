local levels = require 'levels'
local currentLevel

function love.load()
    levels.init()
    currentLevel = levels.loadLevel("level01")
end

function love.draw()
    levels.drawLevel(currentLevel)
end
