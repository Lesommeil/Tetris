move = love.audio.newSource("audio/Tetrio_move_short.mp3", "static")
down = love.audio.newSource("audio/down.mp3", "static")
rotate = love.audio.newSource("audio/Tetrio_rotate.mp3", "static")
holdS = love.audio.newSource("audio/Tetrio_hold.mp3", "static")
lock = love.audio.newSource("audio/Tetrio_lock.mp3", "static")
clear = love.audio.newSource("audio/Tetrio_clear.mp3", "static")
died = love.audio.newSource("audio/Tetrio_died.mp3", "static")
-- Use this in place of love.keypressed:
function key_event(key)
      if key == 'down' then
        local testAxisY = axisY + 1
        if moveAble(axisX, testAxisY, rotation) then
            axisY = testAxisY
        end


        if down:isPlaying() then
            down:stop()
        end
        if previousMoveY ~= axisY then
            previousMoveY = axisY
            down:play()
     
        end

    elseif key == 'right' then
        local testAxisX = axisX + 1
        if moveAble(testAxisX, axisY, rotation) then
            axisX = testAxisX
        end


        if move:isPlaying() then
            move:stop()
        end

        if previousMoveX ~= axisX then
            previousMoveX = axisX
            move:play()
     
        end

    elseif key == 'left' then
        local testAxisX = axisX - 1
        if moveAble(testAxisX, axisY, rotation) then
            axisX = testAxisX
        end


        if move:isPlaying() then
            move:stop()
        end
        if previousMoveX ~= axisX then
            previousMoveX = axisX
            move:play()
     
        end

    elseif key == 'space' then
        while moveAble(axisX, axisY + 1, rotation) do
            axisY = axisY + 1
            time = 0.5
        end
    
        
    end
    
    if key == 'up' then
        testRotation = rotation + 1
        if testRotation > #pieceStructures[position] then
            testRotation = 1
        end
        detectRotationAble()
        if moveAble(axisX, axisY, testRotation) then
            rotation = testRotation
        end
        
        if rotate:isPlaying() then
            rotate:stop()
        end


        rotate:play()


    elseif key == 'z' then
        testRotation = rotation - 1
        if testRotation < 1 then
            testRotation = #pieceStructures[position]
        end
         detectRotationAble()
        if moveAble(axisX, axisY, testRotation) then
            rotation = testRotation
        end

        if rotate:isPlaying() then
            rotate:stop()
        end


        rotate:play()

    elseif key == 'x' then
        testRotation = rotation + 1
        if testRotation > #pieceStructures[position] then
            testRotation = 1
        end
        detectRotationAble()
        if moveAble(axisX, axisY, testRotation) then
            rotation = testRotation
        end

        if rotate:isPlaying() then
            rotate:stop()
        end


        rotate:play()

    
    end
    
    if key == 'c' then
        if holdAble == 1 then
            if hold == 0 then
                hold 
                
                = position
                position = table.remove(block) 
                axisY = -4
                axisX = 3
                rotation = 1            
                moveAble(axisX, axisY, rotation)
    
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
            else
                temp = hold
                hold = position
                position = temp
                axisY = -4
                axisX = 3
                rotation = 1
                moveAble(axisX, axisY, rotation)
            end
        

        
        end
        if holdS:isPlaying() then
            holdS:stop()
        end
        if holdAble == 1 then
            holdS:play()
        end
        holdAble = -1;
    
    end

end


    
    -- Keys that must not be autorepeated
    norepeat = {
      lshift = true, lctrl = true, lalt = true, numlock = true,
      rshift = true, rctrl = true, ralt = true, capslock = true,
    }
    
function love.keypressed(key, scancode)
      if use_scancode then -- set to false to stop using scancodes
        key = scancode
      end
      -- Autorepeat only if not in norepeat
      if not norepeat[key] then
        lastkey = key
        timer_delay = repeat_delay
        timer_period = -1
        key_event(key)
      end
end
    
function love.keyreleased(key, scancode)
      if use_scancode then
        key = scancode
      end
      if key == lastkey then
        timer_delay = -1
        timer_period = -1
      end
end




function detectRotationAble()
    if position == 1 and rotation == 2 and axisX == -1 then
        axisX = axisX + 1
    elseif position == 3 and rotation == 4 and axisX == -1 then
        axisX = axisX + 1
    elseif position == 4 and rotation == 2 and axisX == -1 then
        axisX = axisX + 1
    elseif position == 5 and rotation == 2 and axisX == -1 then
        axisX = axisX + 1
    end
    
    if position == 1 and rotation == 2 and axisX == 8 then
        axisX = axisX - 2
    elseif position == 3 and rotation == 2 and axisX == 8 then
        axisX = axisX - 1
    elseif position == 4 and rotation == 4 and axisX == 8 then
        axisX = axisX - 1
    elseif position == 5 and rotation == 4 and axisX == 8 then
        axisX = axisX - 1
    elseif position == 6 and rotation ==2 and axisX == 8 then
        axisX = axisX - 1
    elseif position == 7 and rotation == 2 and axisX == 8 then
        axisX = axisX - 1
    end
end

