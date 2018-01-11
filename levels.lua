local levels = {}

-- https://stackoverflow.com/questions/19326368/iterate-over-lines-including-blank-lines
local function magiclines(s)
        if s:sub(-1)~="\n" then s=s.."\n" end
        return s:gmatch("(.-)\n")
end

function levels.init()
    local tileSymbols = [[
BRYF<=T
#OPI
EQW
*XL
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
    level.tileQuads = levels.tileQuads -- hmm this structuring is questionable...
    level.tileBatch = levels.tileBatch
    level.map = {}
    level.textblocks = {}
    level.stars = 0
    level.exit = {}

    local levelString = love.filesystem.read("levels/"..name)
    local y = 0
    for line in magiclines(levelString) do
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
                elseif char == "L" then
                    quad = levels.tileQuads["I"]
                    rot = 1
                elseif char == "K" then
                    quad = levels.tileQuads["I"]
                    rot = 2
                elseif char == "J" then
                    quad = levels.tileQuads["I"]
                    rot = 3
                elseif char == "*" then
                    quad = levels.tileQuads[char]
                    level.stars = level.stars+1
                elseif char == "X" then
                    quad = levels.tileQuads["L"]
                    level.exit = {x=x, y=y}
                elseif char:match("[a-z]") then
                    level.textblocks[x.." "..y] = {text=char, x=x, y=y} -- hmmmmmmmm?
                    quad = levels.tileQuads["B"]
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
        love.graphics.printf({{34, 32, 52}, v.text}, v.x*32+16, v.y*32+16, 32, 'center', math.rad(90*rot), 1, 1, 14, 24) -- eh, good enough
    end
end

return levels
