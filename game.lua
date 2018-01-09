local game = {}

function game.keypressed(key, level)
    local id, quad, x, y, rot = unpack(level.player)
    if key == "up" then
        y = y-1
        rot = 0
    end
    if key == "down" then
        y = y+1
        rot = 2
    end
    if key == "left" then
        x = x-1
        rot = 3
    end
    if key == "right" then
        x = x+1
        rot = 1
    end
    level.tileBatch:set(id, quad, x*32+16, y*32+16, math.rad(90*rot), 1, 1, 16, 16)
    level.player = {id, quad, x, y, rot}
end


return game
