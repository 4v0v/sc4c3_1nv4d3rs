Play_scene = Scene:extend('Play_scene')

function Play_scene:new()
	Play_scene.super.new(@)
	@.camera:set_position(400, 300)

	@:add('playground', Rectangle(100, 0, lg.getWidth() - 200, lg.getHeight(), {visible = false}))
	@:add('player', Player(400, 550))
	@:add('enemy1', Enemy(550, 50))
	@:add('enemy2', Enemy(400, 50))
	@:add('enemy3', Enemy(250, 50))
	@:add('enemy4', Enemy(250, 150))

	@.enemies_direction        = 1
	@.enemies_already_collided = false

	@:every(.5, fn() 
		local enemies    = @:get_by_type('Enemy')
		local playground = @:get('playground')

		local enemies_outside_playground
		ifor enemies do
			if playground && !rect_rect_inside({it.pos.x, it.pos.y, it.w, it.h}, playground:aabb()) && !@.enemies_already_collided then
				enemies_outside_playground = true
				@.enemies_direction       *= -1
				break
			end
		end

		if enemies_outside_playground then
			ifor enemies do
				@:tween(.3, it.pos, {y = it.pos.y + 50}, 'in-out-cubic')
			end
			@.enemies_already_collided = true
		else
			ifor enemies do
				@:tween(.3, it.pos, {x = it.pos.x - 50 * @.enemies_direction}, 'in-out-cubic')
			end
			if @.enemies_already_collided then @.enemies_already_collided = false end
		end
	end)

end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)

	local enemies = @:get_by_type('Enemy')
	local bullets = @:get_by_type('Bullet')
	local player  = @:get('player')

	ifor enemies do 
		if it.pos.y > 500 then
			print('Game over')
			break
		end
	end

	ifor bullet in bullets do 
		ifor enemy in enemies do
			if rect_rect_collision({bullet.pos.x, bullet.pos.y, bullet.w, bullet.h}, {enemy.pos.x, enemy.pos.y, enemy.w, enemy.h}) then
				enemy:kill()
				bullet:kill()
			end
		end
	end

	if @:count('Enemy') == 0 then
		@:add('enemy1', Enemy(550, 50))
		@:add('enemy2', Enemy(400, 50))
		@:add('enemy3', Enemy(250, 50))
		@:add('enemy4', Enemy(250, 150))
	end
end