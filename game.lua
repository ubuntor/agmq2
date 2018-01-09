local game = {}

function game.keypressed(key, level)
    -- blargh
    if key == "up" then
        local id, quad, x, y = unpack(level.player)
        y = y-1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, 0, 1, 1, 16, 16)
        level.player = {id, quad, x, y}
    end
    if key == "down" then
        local id, quad, x, y = unpack(level.player)
        y = y+1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, 0, 1, 1, 16, 16)
        level.player = {id, quad, x, y}
    end
    if key == "left" then
        local id, quad, x, y = unpack(level.player)
        x = x-1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, 0, 1, 1, 16, 16)
        level.player = {id, quad, x, y}
    end
    if key == "right" then
        local id, quad, x, y = unpack(level.player)
        x = x+1
        level.tileBatch:set(id, quad, x*32+16, y*32+16, 0, 1, 1, 16, 16)
        level.player = {id, quad, x, y}
    end
end


return game
