
PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.player1 = params.player1
    self.player2 = params.player2
    self.ball = params.ball
    self.player1Score = params.player1Score
    self.player2Score = params.player2Score
end


function PlayState:update(dt)

    if love.keyboard.wasPressed('backspace') then
        startGame()
    end


    -- check collision with paddle 1
    if self.ball:collides(self.player1) then
        self.ball.x = self.player1.x + 5

    -- check collision with paddle 2
    elseif self.ball:collides(self.player2) then
        self.ball.x = self.player2.x - BALL_WIDTH
    end


    --[[ score the opposite player if the player 
        who currently has the ball in his court misses it ]]
    if self.ball.x < 0 then
        self.player2Score = self.player2Score + 1
        
        if self.player2Score == WINNING_SCORE then
            gStateMachine:change('game-end', {
                winner = 2,
                player1Score = self.player1Score,
                player2Score = self.player2Score
            })
        else
            sounds['score']:play()
            self.ball:reset()
            self.ball.dx = math.random(100, 150)
            
            gStateMachine:change('serve', {
                player1 = self.player1,
                player2 = self.player2,
                ball = self.ball,
                player1Score = self.player1Score,
                player2Score = self.player2Score,
                serve = 1
            })
        end
    elseif self.ball.x > VIRTUAL_WIDTH then
        self.player1Score = self.player1Score + 1

        if self.player1Score == WINNING_SCORE then
            gStateMachine:change('game-end', {
                winner = 1,
                player1Score = self.player1Score,
                player2Score = self.player2Score
            })
        else
            sounds['score']:play()
            self.ball:reset()
            self.ball.dx = -math.random(100, 150)
            
            gStateMachine:change('serve', {
                player1 = self.player1,
                player2 = self.player2,
                ball = self.ball,
                player1Score = self.player1Score,
                player2Score = self.player2Score,
                serve = 2
            })
        end
    end

    self.player1:update(dt, 'w', 's')
    self.player2:update(dt, 'up', 'down')
    self.ball:update(dt)
end


function PlayState:render()
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press Backspace to restart!', 0, 10, VIRTUAL_WIDTH, 'center')

    renderScore(self.player1Score, self.player2Score)
    self.player1:render()
    self.player2:render()
    self.ball:render()
end