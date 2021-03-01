Play_scene = Scene:extend('Play_scene')

function Play_scene:new()
	Play_scene.super.new(@)
	@.camera:set_position(400, 300)

	@:add('player', Player(400, 550))

	@:add('enemy1', Enemy(550, 50))
	@:add('enemy2', Enemy(400, 50))
	@:add('enemy3', Enemy(250, 50))
	@:add('enemy4', Enemy(250, 150))

	@.enemy_direction = -1
end

function Play_scene:update(dt)
	Play_scene.super.update(@, dt)

	local enemies = @:get_by_type('Enemy')
	local bullets = @:get_by_type('Bullet')
	local player  = @:get('player')

	ifor enemies do
		it.pos.x += @.enemy_direction * 200 * dt
	end

	local enemies_collide_with_screen_border
	ifor enemies do
		if !rect_rect_inside({it.pos.x, it.pos.y, it.w, it.h}, {0, 0, lg.getWidth(), lg.getHeight()} ) then
			enemies_collide_with_screen_border = true
			break
		end
	end

	if enemies_collide_with_screen_border then
		@.enemy_direction *= -1
		ifor enemies do it.pos.y += 50 end
	end


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


end