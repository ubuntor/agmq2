local levels = require 'levels'
local game = require 'game'
local currentLevel
local levelList = {"level01"}
local levelIndex = 1

function love.load()
    love.keyboard.setKeyRepeat(true)
    love.graphics.setBackgroundColor(120, 120, 120)
    love.graphics.setNewFont("SomepxNew.ttf", 48)
    levels.init()
    currentLevel = levels.loadLevel(levelList[levelIndex])
end

function love.draw()
    levels.drawLevel(currentLevel)
end

function love.keypressed(key)
    if game.keypressed(key, currentLevel) ~= nil then
        levelIndex = levelIndex+1
        if levelIndex > #levelList then
            levelIndex = 1
        end
        currentLevel = levels.loadLevel(levelList[levelIndex])
    end
end
