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
    level.tileBatch = levels.tileBatch -- hmm
    level.map = {}
    level.textblocks = {}

    local levelString = love.filesystem.read("levels/"..name)
    local y = 0
    for line in levelString:gmatch("[^\r\n]+") do
        local x = 0
        for char in line:gmatch(".") do
            if char ~= " " then
                local id, quad, text
                local rot = 0
                -- blargh
                if char == "P" then
                    quad = levels.tileQuads[char]
                    rot = 0
                    level.player = {x=x, y=y}
                elseif char == "D" then
                    quad = levels.tileQuads["W"]
                    rot = 1
                elseif char == "S" then
                    quad = levels.tileQuads["W"]
                    rot = 2
                elseif char == "A" then
                    quad = levels.tileQuads["W"]
                    rot = 3
                elseif char:match("[a-z]") then
                    level.textblocks[x.." "..y] = {text=char, x=x, y=y} -- hmmmmmmmm?
                    quad = levels.tileQuads["R"]
                else
                    quad = levels.tileQuads[char]
                end
                id = level.tileBatch:add(quad, x*32+16, y*32+16, math.rad(90*rot), 1, 1, 16, 16)
                level.map[x.." "..y] = {id=id, quad=quad, rot=rot, char=char}
            end
            x = x+1
        end
        y = y+1
    end

    return level
end

function levels.drawLevel(level)
    love.graphics.draw(level.tileBatch)
    for k,v in pairs(level.textblocks) do
        local rot = level.map[k].rot
        love.graphics.printf({{34, 32, 52}, v.text}, v.x*32+16, v.y*32+16, 32, 'center', math.rad(90*rot), 1, 1, 16, 24) -- eh, good enough
    end
end

return levels
