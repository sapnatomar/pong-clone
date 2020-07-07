--[[
    Closely based on Pong-Remake of GD50 course by Harvard University.
    However, the game is originally programmed by Atari in 1972. Features two
    paddles, controlled by two players, with the goal of getting
    the ball past opponent's edge. Player who reaches Winning Score 
    first wins.
]]

-- All the global variables can be accessed from 'src/constants'
-- All the dependencies can be accessed from 'src/dependencies'

require 'src/dependencies'

function love.load()
    -- sets title of the Application Window
    love.window.setTitle('Pong')

    math.randomseed(os.time())

    -- set love's default filter to "nearest-neighbor", which means no filtering of pixels (blurriness)
    love.graphics.setDefaultFilter('nearest', 'nearest')
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

--[[ Runs every Frame passes key we pressed to make required changes ]]
function love.keypressed(key)
    if (key == 'escape') then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

--[[ Runs every frame passes dt (delta time) in seconds since the last frame ]]
function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

--[[ Called after love.update to draw the updated state of objects on screen ]]
function love.draw()
    push:apply('start')
    -- clear the screen with a specific color
    love.graphics.clear(40, 45, 52, 255)
    gStateMachine:render()

    displayFPS()
    push:apply('end')
end 

-- renders the current Frames per second
function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end