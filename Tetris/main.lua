love.window.setVSync(0)
math.randomseed(os.clock()*1000000000000000000000000000000000000000000000000000000000000000000000)
function love.load()
    love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=1920, minheight=1080})
    require "blockTable"
    require "keyPressed"
    require "theShadow"
    
    
    song = love.audio.newSource("audio/hangingoutintokyo.mp3", "stream")
    song:setLooping(true)
    song:play()

    grey = love.graphics.newImage("grey.png")

    

    block = {}
    inert = {}

    blockSize = 32
    gridXCount = 10
    gridYCount = 20

    offsetX = 23
    offsetY = 8
    
    offsetForeseeX = 34
    offsetForeseeY = 8
    time = 0

    hold = 0
    holdAble = 1
    for y = -5, gridYCount do
        inert[y] = {}
        for x = 1, gridXCount do
            inert[y][x] = ' '
        end
    end
previous = 0
    function newBlock()

        for pieceTypeIndex = 1, #pieceStructures do

            local randomPosition = love.math.random(1000, 99999)
            randomPosition = randomPosition % 7 + 1
            while (randomPosition == previous) do
                local something = love.math.random(1,78)
                randomPosition = love.math.random(1000 + previous * something, 99999)
                randomPosition = randomPosition % 7 + 1
                if previous ~= randomPosition then
                    break
                end
            end
            previous = randomPosition
            table.insert(
                block, 
                pieceTypeIndex,
                randomPosition
            )
            print(#block)
        end
    end
    newBlock()

    function newPiece()
        axisY = -4
        axisX = 3
        rotation = 1
        position = table.remove(block)
        if #block <= #pieceStructures - 1 then
            local randomPosition = love.math.random(1000, 99999)
            randomPosition = randomPosition % 7 + 1
            while (randomPosition == previous) do
                local something = love.math.random(1,78)
                randomPosition = love.math.random(1000 + previous * something, 99999)
                randomPosition = randomPosition % 7 + 1
                if previous ~= randomPosition then
                    break
                end
            end
            previous = randomPosition
            table.insert(
                block, 
                1,
                randomPosition   
            )
        end
        shadow_axisY = axisY
        previousMoveX = 0
        previousMoveY = 0
        
        if holdAble == -1 then
            holdAble = 1
        end
    end
    newPiece()
    function moveAble(testX, testY, testRotation)
        
        for y = 1, 4 do
            for x = 1, 4 do
                
                local blockTestX = testX + x
                local blockTestY = testY + y
                if pieceStructures[position][testRotation][y][x] ~= ' '
                and (blockTestX < 1 or blockTestX > gridXCount + 1 
                or blockTestY > gridYCount 
                or inert[blockTestY][blockTestX] ~= ' ' and inert[blockTestX][blockTestY] ~= "Image: 0x021ce4d290a0") then
                    return false
                end
            end
        end
        return true
    end

end
-- Configuration area
repeat_delay = 0.2    -- Delay until repeat starts
repeat_period = 0.05  -- Time between repetitions once repeat starts

use_scancode = true    -- Whether to use the key's scancode

-- Our timers
timer_delay = -1
timer_period = -1


function love.update(dt)

    -- this code is to set keyrepeat delay.
    if timer_delay >= 0 then
        timer_delay = timer_delay - dt
        if timer_delay < 0 then
          key_event(lastkey)
          timer_period = repeat_period + timer_delay
          while timer_period < 0 do
            key_event(lastkey)
            timer_period = timer_period + repeat_period
          end
        end
      elseif timer_period >= 0 then
        timer_period = timer_period - dt
        while timer_period < 0 do
          key_event(lastkey)
          timer_period = timer_period + repeat_period
        end
    end



    -- main logic code
    time = time + dt
    if time >0.5 then
        local testAxisY = axisY + 1
        if moveAble(axisX, testAxisY, rotation) then
            axisY = axisY + 1
            time = 0
        else
            for y = 1, 4 do
                for x = 1, 4 do
                    if pieceStructures[position][rotation][y][x] ~= ' ' then
                        inert[axisY + y][axisX + x] = pieceStructures[position][rotation][y][x]
                    end
                end
            end
            counter = 0
            for y = -1, #inert do
                local complete = true
                for x = 1, #inert[y] do
                    if  inert[y][x] == ' 'then
                        complete = false
                        break
                    end                    
                end
                if complete then
                    for removeY = y, -1, -1 do
                        for removeX = 1, gridXCount do
                            inert[removeY][removeX] = inert[removeY - 1][removeX]
                        end
                    end

                    for removeX = 1, gridXCount do
                        inert[-1][removeX] = ' '
                    end

                    if clear:isPlaying() then
                        clear:stop()
                    end
                    clear:play()
                    
                end
            end
            if lock:isPlaying() then
                lock:stop()
            end
                lock:play()
            newPiece()
            if not moveAble(axisX, axisY, rotation) then
                died:play()
                if song:isPlaying() then
                    song:stop()
                end
                
                love.load()
            end
        end
    end

    
end


function love.draw()
      -- draw shadow
      while moveAble(axisX, shadow_axisY + 1, rotation) do
        shadow_axisY = shadow_axisY + 1

    end

    for y = 1, 4 do
        for x = 1, 4 do
            if shadow[position][rotation][y][x] ~= ' ' then
                love.graphics.draw(shadow[position][rotation][y][x], 
                blockSize * (x + offsetX) + blockSize * (axisX - 1), blockSize * (y + offsetY) + blockSize * (shadow_axisY - 1))
            end
        end
    end

    shadow_axisY =shadow_axisY - 4
  
  
    
  
    -- draw background
    for y = 0, gridYCount - 1 do
        for x = 0, gridXCount - 1 do
            love.graphics.setColor(.75, .75, .75, 0.1)
            love.graphics.rectangle('line', (x + offsetX) * blockSize, (y + offsetY) * blockSize, blockSize, blockSize )
        end
    end
    

    -- draw block
    for y = 1, 4 do
        for x = 1, 4 do
            love.graphics.setColor(255, 255, 255)
            --print(position..' '..rotation..' '..y.. ' '..x)
            
            if pieceStructures[position][rotation][y][x] ~= ' ' then
                love.graphics.draw(pieceStructures[position][rotation][y][x], 
                blockSize * (x + offsetX) + blockSize * (axisX - 1), blockSize * (y + offsetY) + blockSize * (axisY - 1))
            end

        end 
    end







    -- draw inert
    for y = -1, gridYCount do
        for x = 1, gridXCount do
            if inert[y][x] ~= ' ' then
                love.graphics.draw(inert[y][x], ((x + offsetX) - 1) * 32, ((y + offsetY) - 1) * 32)
            end
        end
    end






    for y = 1, 4 do
        for x = 1, 4 do
            if pieceStructures[block[7]][1][y][x] ~= ' ' then
                love.graphics.draw(pieceStructures[block[7]][1][y][x], (x + offsetForeseeX) * blockSize, (y + offsetForeseeY) * blockSize)
            end
        end
    end


    for y = 1, 4 do
        for x = 1, 4 do
            if pieceStructures[block[6]][1][y][x] ~= ' ' then
                love.graphics.draw(pieceStructures[block[6]][1][y][x], (x + offsetForeseeX) * blockSize, (y + offsetForeseeY) * blockSize+ 100)
            end
        end
    end

    for y = 1, 4 do
        for x = 1, 4 do
            if pieceStructures[block[5]][1][y][x] ~= ' ' then
                love.graphics.draw(pieceStructures[block[5]][1][y][x], (x + offsetForeseeX) * blockSize, (y + offsetForeseeY) * blockSize + 200)
            end
        end
    end

    for y = 1, 4 do
        for x = 1, 4 do
            if pieceStructures[block[4]][1][y][x] ~= ' ' then
                love.graphics.draw(pieceStructures[block[4]][1][y][x], (x + offsetForeseeX) * blockSize, (y + offsetForeseeY) * blockSize + 300)
            end
        end
    end

    for y = 1, 4 do
        for x = 1, 4 do
            if pieceStructures[block[3]][1][y][x] ~= ' ' then
                love.graphics.draw(pieceStructures[block[3]][1][y][x], (x + offsetForeseeX) * blockSize, (y + offsetForeseeY) * blockSize + 400)
            end
        end
    end

    

    if hold ~= 0 then
        if holdAble == -1 then 
            for y = 1, 4 do
                for x = 1, 4 do
                    if pieceStructures[hold][1][y][x] ~= ' ' then
                        love.graphics.draw(grey, (x + 18) * blockSize - 16, (y + 7) * blockSize + 23)
                    end
                end
            end
        else       
            for y = 1, 4 do
                for x = 1, 4 do
                    if pieceStructures[hold][1][y][x] ~= ' ' then
                        love.graphics.draw(pieceStructures[hold][1][y][x], (x + 18) * blockSize - 16, (y + 7) * blockSize + 23)
                    end
                end
            end
        end 
        
    end
    
    love.graphics.rectangle('fill',(offsetX + gridXCount) * blockSize +2, offsetY * blockSize + 2,2,  gridYCount * blockSize + 2)
    love.graphics.rectangle('fill',offsetX * blockSize -2, offsetY * blockSize + 2,2,  gridYCount * blockSize + 2)
    love.graphics.rectangle('fill',offsetX * blockSize -2, (offsetY + gridYCount ) * blockSize + 2, gridXCount * blockSize+26,  2)


    love.graphics.rectangle('fill',(offsetX + gridXCount) * blockSize +22, offsetY * blockSize + 2,2,  gridYCount * blockSize + 2)
    love.graphics.rectangle('fill',(offsetX + gridXCount) * blockSize +200, offsetY * blockSize + 2,2,  gridYCount * blockSize - 70)
    aline = {(offsetX + gridXCount) * blockSize +180, (offsetY + gridYCount) * blockSize + 2 - 50, 
    (offsetX + gridXCount) * blockSize +200, (offsetY + gridYCount) * blockSize + 2 - 70 }
    love.graphics.line(aline)
    love.graphics.rectangle('fill', (offsetX + gridXCount) * blockSize +22, (offsetY + gridYCount) * blockSize + 2 - 51, 157.6, 2)
    love.graphics.rectangle('fill', (offsetX + gridXCount) * blockSize +22, offsetY * blockSize + 2, 178, 40 )
    
    love.graphics.draw(love.graphics.newImage("next.png"), (offsetX + gridXCount) * blockSize +34, offsetY * blockSize + 12)
    
    love.graphics.rectangle('fill',offsetX * blockSize -170, offsetY * blockSize + 2 , 170, 40)
    love.graphics.rectangle('fill',offsetX * blockSize -150, offsetY * blockSize + 129 , 150, 2)
    love.graphics.rectangle('fill',offsetX * blockSize -170, offsetY * blockSize + 2 , 2, 108)       
    love.graphics.print(love.timer.getFPS(), 1, 1)
    anotherline = {offsetX * blockSize -169, offsetY * blockSize + 109, offsetX * blockSize -150, offsetY * blockSize + 130}
    love.graphics.line(anotherline)
    love.graphics.draw(love.graphics.newImage("hold.png"), offsetX * blockSize -170 + 14, offsetY * blockSize + 12)


end








-- function stupidRandomSet(randomPosition)
--     for i = 1, 5 do
--         if i % 2 == 0 then
--             randomPosition = randomPosition + love.math.random(1, 113 * 7)
--         elseif i%3 == 0 then
--             randomPosition = randomPosition + love.math.random(1, 50 * 7)
--         elseif i%4 == 0 then
--             randomPosition = randomPosition - love.math.random(1, 123 * 7)
--         else
--             randomPosition = randomPosition - love.math.random(1, 13 * 7)

--         end
        
--     end

--     return randomPosition
-- end



--failed set time delay
-- timer = 0
-- timerDefault = 0.2

-- function love.update(dt)
--     local keypressed_down = love.keyboard.isScancodeDown('down')
--     local keypressed_left = love.keyboard.isScancodeDown('left')
--     local keypressed_right = love.keyboard.isScancodeDown('right')

--     if keypressed_down then
--         timer = timer + dt
--         if timer > timerDefault then
--         local testAxisY = axisY + 1
--             if moveAble(axisX, testAxisY, rotation) then
--                 axisY = testAxisY
--             end
--         else
--             timer = 0
--         end
--     end

--     if keypressed_left then
--         timer = timer + dt
--         if timer > timerDefault then
--         local testAxisX = axisX - 1
--             if moveAble(testAxisX, axisY, rotation) then
--                 axisX = testAxisX
--             end
--         else
--             timer = 0
--         end
--     end

--     if keypressed_right then
--         timer = timer + dt
--         if timer > timerDefault then
--         local testAxisX = axisX + 1
--             if moveAble(testAxisX, axisY, rotation) then
--                 axisX = testAxisX
--             end
--         else
--             timer = 0
--         end
--     end