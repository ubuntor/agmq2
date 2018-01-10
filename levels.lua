local levels = {}

function levels.init()
    local tileSymbols = [[
BRYI<=T
#OP
EQW
*X
]]

    local tileImage = love.graphics.newImage("tiles.png")

    levels.tileQuads = {}

    local y = 0
    for line in tileSymbols:gmatch("[^\r\n]+") do
        local x = 0
        for char in line:gmatch(".") do
            levels.tileQuads[char] = love.graphics.newQuad(x*32, y*32, 32, 32, tileImage:getWidth(), tileImage:getHeight())
            x = x+1
        end
        y = y+1
    end

    levels.tileBatch = love.graphics.newSpriteBatch(tileImage)
end

function levels.loadLevel(name)
    local level = {}
    levels.tileBatch:clear()
    level.tileBatch = levels.tileBatch --- hmm

    local levelString = love.filesystem.read("levels/"..name)
    local y = 0
    for line in levelString:gmatch("[^\r\n]+") do
        local x = 0
        for char in line:gmatch(".") do
            -- blargh
            if char == "P" then
                id = level.tileBatch:add(levels.tileQuads[char], x*32+16, y*32+16, 0, 1, 1, 16, 16)
                level.player = {id, levels.tileQuads[char], x, y, 0}
            elseif char == "D" then
                id = level.tileBatch:add(levels.tileQuads["W"], x*32+16, y*32+16, math.rad(90), 1, 1, 16, 16)
            elseif char == "S" then
                id = level.tileBatch:add(levels.tileQuads["W"], x*32+16, y*32+16, math.rad(180), 1, 1, 16, 16)
            elseif char == "A" then
                id = level.tileBatch:add(levels.tileQuads["W"], x*32+16, y*32+16, math.rad(270), 1, 1, 16, 16)
            elseif char ~= " " then
                level.tileBatch:add(levels.tileQuads[char], x*32+16, y*32+16, 0, 1, 1, 16, 16)
            end
            x = x+1
        end
        y = y+1
    end

    return level
end

function levels.drawLevel(level)
    love.graphics.draw(level.tileBatch)
end

return levels
