
StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if (love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')) then
        startGame()
    end
end

function StartState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Pong!', 0, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to play!', 0, VIRTUAL_HEIGHT/2 +6, VIRTUAL_WIDTH, 'center')
end