local levels = {}

function levels.init()
    local tileSymbols = [[
bry
#op
]]

    local tileImage = love.graphics.newImage("tiles.png")

    levels.tileQuads = {}

    -- oh no, how to enumerate over lines in lua :(
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
    levels.tileBatch:clear()
    local levelString = love.filesystem.read("levels/"..name)
    local y = 0
    for line in levelString:gmatch("[^\r\n]+") do
        local x = 0
        for char in line:gmatch(".") do
            if char ~= " " then
                levels.tileBatch:add(levels.tileQuads[char], x*32, y*32)
            end
            x = x+1
        end
        y = y+1
    end

    print(levels.tileBatch)
end

function levels.drawLevel(level)
    love.graphics.draw(levels.tileBatch)
end

return levels
