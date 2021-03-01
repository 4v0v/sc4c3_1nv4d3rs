Bullet = Entity:extend('Bullet')

function Bullet:new(x, y)
	Bullet.super.new(@, { x = x, y = y})

	@.w = 10
	@.h = 10
end

function Bullet:update(dt)
	self.pos.y -= 300 * dt

	if self.pos.y < 0 then self:kill() end
end

function Bullet:draw()
	lg.setColor(COLORS.GREEN)
	lg.rectangle('fill', @.pos.x, @.pos.y, @.w, @.h)
end

