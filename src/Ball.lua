Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2)==1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = BALL_X
    self.y = BALL_Y

    self.dx = math.random(2)==1 and -100 or 100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)

    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        sounds['wall_hit']:play()

    elseif self.y >= VIRTUAL_HEIGHT - BALL_HEIGHT then
        self.y = VIRTUAL_HEIGHT - BALL_HEIGHT
        self.dy = -self.dy
        sounds['wall_hit']:play()
    end

end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or self.x + self.width < paddle.x then
        return false
    end
    if self.y > paddle.y + paddle.height or self.y + self.height < paddle.y then
        return false
    else
        sounds['paddle_hit']:play()
        self.dx = -self.dx*1.03

        if self.dy < 0 then
            self.dy = -math.random(10, 150)
        else
            self.dy = math.random(10, 150)
        end
        
        return true
    end
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
    