local game = {}

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
    local newindex = newx.." "..newy
    if level.map[newindex] == nil then
        level.map[newindex] = playerinfo
        level.map[playerindex] = nil
        level.player = {x=newx, y=newy}
    end
    level.tileBatch:set(playerinfo.id, playerinfo.quad, level.player.x*32+16, level.player.y*32+16, math.rad(90*playerinfo.rot), 1, 1, 16, 16)
end


return game
