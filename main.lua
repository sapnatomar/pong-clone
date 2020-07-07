--[[
    Closely based on GD50 course by Harvard University.
    However, the game is originally programmed by Atari in 1972. Features two
    paddles, controlled by two players, with the goal of getting
    the ball past opponent's edge. Player who reaches Winning Score 
    first wins.
]]

require 'src/dependencies'

function love.load()
    -- sets title of the Appliaction Window
    love.window.setTitle('Pong')

    math.randomseed(os.time())

    -- set love's default filter to "nearest-neighbor", which means no filtering of pixels (blurriness)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- initialize retro text fonts
    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    largeFont = love.graphics.newFont('fonts/font.ttf', 16)
    scoreFont = love.graphics.newFont('fonts/font.ttf', 32)
    love.graphics.setFont(smallFont)

    -- load sound tracks
    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- initialize player paddles and ball
    -- player1 = Paddle(PLAYER1X, PLAYER1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    -- player2 = Paddle(PLAYER2X, PLAYER2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    -- ball = Ball(BALL_X, BALL_Y, BALL_WIDTH, BALL_HEIGHT)

    -- initialize play scores to 0 and winning player to None
    -- player1Score = 0
    -- player2Score = 0
    -- winningPlayer = 0

    -- Welcome Screen State
    -- means on first loading the game, user will be greeted with a welcome Screen
    -- gameState = 'welcomeScreen'

    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['serve'] = function() return ServeState() end,
        ['play'] = function() return PlayState() end,
        ['game-end'] = function() return GameEndState() end
    }
    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

--[[ Called when we resize the screen ]]
function love.resize(w, h)
    push:resize(w, h)
end


function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end


--[[ Runs every Frame 
    passes key we pressed to make required changes ]]
function love.keypressed(key)
    if (key == 'escape') then
        love.event.quit()
    end

    -- elseif key == 'enter' or key == 'return' then
    --     if gameState == 'start' or gameState == 'serve' then
    --         gameState = 'play'
    --     elseif gameState == 'welcomeScreen' then
    --         gameState = 'start'
    --     elseif gameState == 'done' then
    --         resetGame()
    --     end
    -- elseif key == 'backspace' then
    --     resetGame()
    -- end

    love.keyboard.keysPressed[key] = true
end


--[[ Runs every frame
    passes dt (delta time) in seconds since the last frame 
]]
function love.update(dt)

    -- no update on screen for following gameStates
    -- if gameState == 'welcomeScreen' or gameState == 'done' then
    --     return
    -- end

    -- if gameState == 'play' then
    --     -- check collsion with paddle 1
    --     if ball:collides(player1) then
    --         ball.x = player1.x + 5

    --     -- check collision with paddle 2
    --     elseif ball:collides(player2) then
    --         ball.x = player2.x - BALL_WIDTH
    --     end
    -- end

    -- check if ball is out of x Application width scope
    -- if ball.x < 0 then
    --     player2Score = player2Score + 1
    --     helperFunction()
    --     ball.dx = math.random(100, 150)
    -- elseif ball.x > VIRTUAL_WIDTH then
    --     player1Score = player1Score + 1
    --     helperFunction()
    --     ball.dx = -math.random(100, 150)
    -- end

    -- player1:update(dt, 'w', 's')
    -- player2:update(dt, 'up', 'down')

    -- update only if game is in 'play' or 'serve' state
    -- if gameState == 'play' then
    --     ball:update(dt)
    -- end

    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end


--[[ Called after love.update 
    to draw the updated state of objects on screen
]]
function love.draw()
    push:apply('start')

    -- clear the screen with a specific color
    love.graphics.clear(40, 45, 52, 255)
    gStateMachine:render()

    -- if gameState == 'welcomeScreen' then
    --     love.graphics.setFont(largeFont)
    --     love.graphics.printf('Pong!', 0, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'center')
    --     love.graphics.setFont(smallFont)
    --     love.graphics.printf('Press Enter to play!', 0, VIRTUAL_HEIGHT/2 +6, VIRTUAL_WIDTH, 'center')

    -- elseif gameState == 'done' then
    --     love.graphics.setFont(largeFont)
    --     love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!', 0, VIRTUAL_HEIGHT/2 -20 , VIRTUAL_WIDTH, 'center')
    --     love.graphics.setFont(smallFont)
    --     love.graphics.printf('Press Enter to Play again!', 0, VIRTUAL_HEIGHT/2 +6, VIRTUAL_WIDTH, 'center')
    -- else
    --     love.graphics.setFont(smallFont)
    --     love.graphics.printf('Press Backspace to restart!', 0, 10, VIRTUAL_WIDTH, 'center')

    --     love.graphics.setFont(scoreFont)
    --     love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/2-50, VIRTUAL_HEIGHT/3)
    --     love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH/2+30, VIRTUAL_HEIGHT/3)
        
    --     player1:render()
    --     player2:render()
    --     ball:render()
    -- end

    displayFPS()

    push:apply('end')
end 


-- function helperFunction()
--     ball:reset()

--     if player1Score == WINNING_SCORE then
--         winningPlayer = 1
--         gameState = 'done'
--     elseif player2Score == WINNING_SCORE then
--         winningPlayer = 2
--         gameState = 'done'
--     else
--         gameState = 'serve'
--         sounds['score']:play()
--     end
-- end


-- Helper Function to simply reset/restart the game
-- function resetGame()
--     gameState = 'start'
--     ball:reset()
--     player1Score = 0
--     player2Score = 0
-- end


-- renders the current Frames per second
function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end