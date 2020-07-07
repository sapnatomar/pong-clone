
function startGame()
    gStateMachine:change('serve', {
        player1 = Paddle(PLAYER1X, PLAYER1Y, PADDLE_WIDTH, PADDLE_HEIGHT),
        player2 = Paddle(PLAYER2X, PLAYER2Y, PADDLE_WIDTH, PADDLE_HEIGHT),
        ball = Ball(BALL_X, BALL_Y, BALL_WIDTH, BALL_HEIGHT),
        serve = 0,
        player1Score = 0,
        player2Score = 0
    })
end


function renderScore(score1, score2)
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(score1), VIRTUAL_WIDTH/2-50, VIRTUAL_HEIGHT/3)
    love.graphics.print(tostring(score2), VIRTUAL_WIDTH/2+30, VIRTUAL_HEIGHT/3)
end