Player = Entity:extend('Player')

function Player:new(x, y)
	Player.super.new(@, { x = x, y = y})

	@.w = 100
	@.h = 50
end

function Player:update(dt)
	if   down('left')  || down('q') then self.pos.x -= 300 * dt
	elif down('right') || down('d') then self.pos.x += 300 * dt end

	if down('space') then @.scene:add(Bullet(self.pos.x + self.w / 2, self.pos.y)) end
end

function Player:draw()
	lg.setColor(COLORS.RED)
	lg.rectangle('fill', @.pos.x, @.pos.y, @.w, @.h)
end

