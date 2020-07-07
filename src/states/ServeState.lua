
ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.serve = params.serve

    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end

function ServeState:update(dt)

    self.player1:update(dt, 'w', 's')
    self.player2:update(dt, 'up', 'down')
    
    if love.keyboard.wasPressed('backspace') then
        startGame()
    elseif love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            player1 = self.player1,
            player2 = self.player2,
            ball = self.ball,
            player1Score = self.player1Score,
            player2Score = self.player2Score
        })
    end
end

function ServeState:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Backspace to restart!', 0, 10, VIRTUAL_WIDTH, 'center')

    if self.serve == 1 or self.serve == 2 then
        love.graphics.printf('Player ' .. tostring(self.serve) ..'\'s serve', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press enter to serve!', 0, 30, VIRTUAL_WIDTH, 'center')

    renderScore(self.player1Score, self.player2Score)
    self.player1:render()
    self.player2:render()
    self.ball:render()
end