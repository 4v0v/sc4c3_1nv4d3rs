Enemy = Entity:extend('Enemy')

function Enemy:new(x, y)
	Enemy.super.new(@, { x = x, y = y})

	@.w = 100
	@.h = 50
end

function Enemy:update(dt)

end

function Enemy:draw()
	lg.setColor(COLORS.YELLOW)
	lg.rectangle('fill', @.pos.x, @.pos.y, @.w, @.h)
end

