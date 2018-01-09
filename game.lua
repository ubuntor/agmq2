local game = {}

function game.keypressed(key, level)
    -- blargh this is ugly
    if key == "up" then
        local id, quad, x, y, _ = unpack(level.player)
        y = y-1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, 0, 1, 1, 16, 16)
        level.player = {id, quad, x, y, 0}
    end
    if key == "down" then
        local id, quad, x, y, _ = unpack(level.player)
        y = y+1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, math.rad(180), 1, 1, 16, 16)
        level.player = {id, quad, x, y, 2}
    end
    if key == "left" then
        local id, quad, x, y, _ = unpack(level.player)
        x = x-1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, math.rad(270), 1, 1, 16, 16)
        level.player = {id, quad, x, y, 3}
    end
    if key == "right" then
        local id, quad, x, y, _ = unpack(level.player)
        x = x+1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, math.rad(90), 1, 1, 16, 16)
        level.player = {id, quad, x, y, 1}
    end
end


return game
