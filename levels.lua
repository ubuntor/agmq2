local levels = {}

function levels.init()
    local tileSymbols = [[
bryI<=
#op
EQ
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
            if char == "p" then
                id = level.tileBatch:add(levels.tileQuads[char], x*32+16, y*32+16, 0, 1, 1, 16, 16)
                level.player = {id, levels.tileQuads[char], x, y, 0}
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
