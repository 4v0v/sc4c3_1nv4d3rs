Play_scene = Scene:extend('Play_scene')

function Play_scene:new()
	Play_scene.super.new(@)
	@.camera:set_position(400, 300)

	@:add('playground', Rectangle(100, 0, lg.getWidth() - 200, lg.getHeight(), {visible = false}))
	@:add('player'    , Player(400, 550))
	@:add(Enemy(550, 100))
	@:add(Enemy(400, 100))
	@:add(Enemy(250, 100))
	@:add(Enemy(250, 200))

	@.enemies_already_collided = false
	@.enemies_direction        = 1

	@:every(.5, fn() 
		local enemies    = @:get_by_type('Enemy')
		local playground = @:get('playground')

		local enemies_outside_playground
		ifor enemies do
			if playground && !rect_rect_inside(it:aabb(), playground:aabb()) && !@.enemies_already_collided then
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
			if rect_rect_collision(bullet:aabb(), enemy:aabb()) then
				enemy:kill()
				bullet:kill()
			end
		end
	end

	if #@:get_by_type('Enemy') == 0 then
		@:add(Enemy(550, 100))
		@:add(Enemy(400, 100))
		@:add(Enemy(250, 100))
		@:add(Enemy(250, 200))
	end
end