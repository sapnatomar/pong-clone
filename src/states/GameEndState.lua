
GameEndState = Class{__includes = BaseState}

function GameEndState:enter(params)
    self.winner = params.winner
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function GameEndState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        startGame()
    end
end

function GameEndState:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Player ' .. tostring(self.winner) .. ' wins!', 0, VIRTUAL_HEIGHT/3 , VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(scoreFont)
    love.graphics.printf(tostring(self.player1Score).. ' - '..tostring(self.player2Score), 0, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Enter to Play again!', 0, VIRTUAL_HEIGHT/2 + 15, VIRTUAL_WIDTH, 'center')
end