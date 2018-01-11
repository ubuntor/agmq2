local game = {}

local function forward(x, y, rot)
    if rot == 0 then
        y = y-1
    elseif rot == 1 then
        x = x+1
    elseif rot == 2 then
        y = y+1
    else
        x = x-1
    end
    return {x,y}
end

local function backward(x, y, rot)
    if rot == 0 then
        y = y+1
    elseif rot == 1 then
        x = x-1
    elseif rot == 2 then
        y = y-1
    else
        x = x+1
    end
    return {x,y}
end

function game.keypressed(key, level)
    local playerindex = level.player.x.." "..level.player.y -- hmmmmmmmm
    local playerinfo = level.map[playerindex]
    local newx = level.player.x
    local newy = level.player.y
    if key == "up" then
        newy = level.player.y-1
        playerinfo.rot = 0
    end
    if key == "down" then
        newy = level.player.y+1
        playerinfo.rot = 2
    end
    if key == "left" then
        newx = level.player.x-1
        playerinfo.rot = 3
    end
    if key == "right" then
        newx = level.player.x+1
        playerinfo.rot = 1
    end
    if key == "space" then
        local fx, fy = unpack(forward(level.player.x, level.player.y, playerinfo.rot))
        local finfo = level.map[fx.." "..fy]
        if finfo ~= nil then
            finfo.rot = (finfo.rot+1)%4
            level.tileBatch:set(finfo.id, finfo.quad, fx*32+16, fy*32+16, math.rad(90*finfo.rot), 1, 1, 16, 16)
        end
    end
    local newindex = newx.." "..newy
    -- blah
    if level.map[newindex] == nil then
        level.map[newindex] = playerinfo
        level.map[playerindex] = nil
        level.player = {x=newx, y=newy}
    elseif level.map[newindex].char == "*" then
        level.tileBatch:set(level.map[newindex].id, 0, 0, 0, 0, 0)
        level.map[newindex] = playerinfo
        level.map[playerindex] = nil
        level.player = {x=newx, y=newy}
        level.stars = level.stars-1
        if level.stars <= 0 then -- hmm levels must have at least 1 star
            local exitinfo = level.map[level.exit.x.." "..level.exit.y]
            exitinfo.quad = level.tileQuads["X"]
            level.tileBatch:set(exitinfo.id, exitinfo.quad, level.exit.x*32+16, level.exit.y*32+16, math.rad(90*exitinfo.rot), 1, 1, 16, 16)
        end
    elseif level.map[newindex].char == "X" and level.stars <= 0 then
        return true -- next level?
    end
    level.tileBatch:set(playerinfo.id, playerinfo.quad, level.player.x*32+16, level.player.y*32+16, math.rad(90*playerinfo.rot), 1, 1, 16, 16)
end

return game
