-- name: \\#ffffff\\Milne's 3.0
-- incompatible: moveset
-- description: Original By \\#0ee3ce\\Steven \\#dcdcdc\\Modified By \\#ffffff\\Xboxy

gStateExtras = {}
for i=0,(MAX_PLAYERS-1) do
	gStateExtras[i] = {}
	local m = gMarioStates[i]
	local e = gStateExtras[i]
	e.animFrame = 0
	e.rotAngle = 0
	e.crystallanced = 0
	e.ttvertspeed = 0
	e.tthorispeed = 0
	e.clspeed = 0
end

ACT_TWISTER_THOK_JUMP   = (0x08A | ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
ACT_TWISTER_THOK_STOMP  = (0x08B | ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
ACT_CRYSTAL_LANCE_DASH  = (0x08C | ACT_FLAG_AIR | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
ACT_CRYSTAL_LANCE_WALL  = (0x08D | ACT_FLAG_AIR | ACT_FLAG_STATIONARY)
ACT_CRYSTAL_LANCE_START = (0x08D | ACT_FLAG_AIR | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)

function act_twister_thok_jump(m)
	local e = gStateExtras[m.playerIndex]
	if m.actionTimer == 0 then
        m.actionState = m.actionArg
		play_character_sound(m, CHAR_SOUND_HOOHOO)
		m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
		if m.flags & (MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD) == 0 then
			m.health = m.health - 0x100
		end
	end

	if m.actionTimer < 5 then
		m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
	end

	if m.actionState == 1 then spinDirFactor = nil end
	set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING_FLIP)
	local stepResult = perform_air_step(m, 0)
	if stepResult == AIR_STEP_LANDED then
		if should_get_stuck_in_ground(m) ~= 0 then
			queue_rumble_data_mario(m, 0, 0)
			play_character_sound(m, CHAR_SOUND_YAHOO)
			set_mario_action(m, ACT_FEET_STUCK_IN_GROUND, 0)
		else
			if check_fall_damage(m, ACT_SQUISHED) == 0 then
				set_mario_action(m, ACT_STOMACH_SLIDE_STOP, 0)
			end
		end
	end
	-- set facing direction
	-- not part of original Extended Moveset
	local yawDiff = m.faceAngle.y - m.intendedYaw
	e.rotAngle = e.rotAngle + yawDiff
	m.faceAngle.y = m.intendedYaw

	e.rotAngle = e.rotAngle + 0x2000
    if e.rotAngle >  0x10000 then e.rotAngle = e.rotAngle - 0x10000 end
    if e.rotAngle < -0x10000 then e.rotAngle = e.rotAngle + 0x10000 end
    m.marioObj.header.gfx.angle.y = m.marioObj.header.gfx.angle.y + e.rotAngle

	if m.actionTimer > 0 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
		if m.flags & (MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD) == 0 then
			m.vel.y = -50
			mario_set_forward_vel(m, m.forwardVel * 2)
		else
			m.vel.y = -40
			mario_set_forward_vel(m, m.forwardVel * 1.5)
		end
		return set_mario_action(m, ACT_TWISTER_THOK_STOMP, 0)
    end
	
	if (m.input & INPUT_B_PRESSED) ~= 0 and e.crystallanced == 0 then
	    e.crystallanced = 1
        set_mario_action(m, ACT_CRYSTAL_LANCE_START, 0)
    end
	
    m.actionTimer = m.actionTimer + 1
    return 0
end

function act_twister_thok_stomp(m)
	local e = gStateExtras[m.playerIndex]
	if m.actionTimer == 0 then
		m.actionState = m.actionArg
		play_character_sound(m, CHAR_SOUND_YAHOO)
		if m.flags & (MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD) == 0 then
			m.health = m.health - 0x100
		end
    end
	
	if m.actionTimer < 5 then
		m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
	end

	if m.actionState == 1 then spinDirFactor = -1 end
	set_mario_animation(m, MARIO_ANIM_RUNNING_UNUSED)
	local stepResult = perform_air_step(m, 0)
	if stepResult == AIR_STEP_LANDED then
		if should_get_stuck_in_ground(m) ~= 0 then
			queue_rumble_data_mario(m, 5, 80)
			play_character_sound(m, CHAR_SOUND_OOOF2)
			set_mario_action(m, ACT_FEET_STUCK_IN_GROUND, 0)
		else
			if check_fall_damage(m, ACT_SQUISHED) == 0 then
				set_mario_action(m, ACT_JUMP_LAND, 0)
			end
		end
	end
	if (m.input & INPUT_B_PRESSED) ~= 0 and e.crystallanced == 0 then
		e.crystallanced = 1
		set_mario_action(m, ACT_CRYSTAL_LANCE_START, 0)
	end
	-- set facing direction
    -- not part of original Extended Moveset
	local yawDiff = m.faceAngle.y - m.intendedYaw
	e.rotAngle = e.rotAngle + yawDiff
	m.faceAngle.y = m.intendedYaw

	e.rotAngle = e.rotAngle + 0x3053
	if e.rotAngle >  0x10000 then e.rotAngle = e.rotAngle - 0x10000 end
	if e.rotAngle < -0x10000 then e.rotAngle = e.rotAngle + 0x10000 end
	m.marioObj.header.gfx.angle.y = m.marioObj.header.gfx.angle.y + e.rotAngle

	m.actionTimer = m.actionTimer + 1
    return 0
end

function act_crystal_lance_start(m)
    local e = gStateExtras[m.playerIndex]
    if m.actionTimer > 10 then
		return set_mario_action(m, ACT_CRYSTAL_LANCE_DASH, 0)
	else
		set_mario_animation(m, MARIO_ANIM_SWINGING_BOWSER)
		set_anim_to_frame(m, 1)
		mario_set_forward_vel(m, -28)	    
		m.vel.y = 0
		m.actionTimer = m.actionTimer + 1
		m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		stepResult = perform_air_step(m, 0)
	end
	m.actionTimer = m.actionTimer + 1
	return 0
end	

function act_crystal_lance_dash(m)
	local e = gStateExtras[m.playerIndex]
	if m.actionTimer == 0 then
		m.actionState = m.actionArg
		e.animFrame = 0
		play_character_sound(m, CHAR_SOUND_HERE_WE_GO)
		play_sound(SOUND_ACTION_FLYING_FAST, m.marioObj.header.gfx.cameraToObject)
		if m.flags & (MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD) == 0 then
			m.health = m.health - 0x100
		end
	elseif m.actionTimer > 0 then
		if (m.input & INPUT_B_PRESSED) ~= 0 then
			set_mario_action(m, ACT_FREEFALL, 0)
		end
	end
	if m.actionTimer > 20 then
		return set_mario_action(m, ACT_FREEFALL, 0)
	else
		set_mario_animation(m, MARIO_ANIM_PICK_UP_LIGHT_OBJ)
		set_anim_to_frame(m, e.animFrame)
		if e.animFrame >= 25 then
			e.animFrame = 25
		end
		if m.flags & (MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD) == 0 then
			mario_set_forward_vel(m, 150)
		else
			mario_set_forward_vel(m, 100)
		end
		m.vel.y = 0
		m.actionTimer = m.actionTimer + 1
		m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		e.animFrame = e.animFrame + 1
	end
	local stepResult = 0
	if (m.input & INPUT_OFF_FLOOR) ~= 0 then
		stepResult = perform_air_step(m, 0)
	elseif (m.input & INPUT_OFF_FLOOR) == 0 then
		stepResult = perform_ground_step(m)
	end
	if (stepResult == AIR_STEP_HIT_WALL or stepResult == GROUND_STEP_HIT_WALL) then
		m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
		play_sound(SOUND_ACTION_METAL_BONK, m.marioObj.header.gfx.cameraToObject)
		set_mario_action(m, ACT_CRYSTAL_LANCE_WALL, 0)
    end
	m.marioBodyState.handState = MARIO_HAND_OPEN
	m.actionTimer = m.actionTimer + 1
	return 0
end

function act_crystal_lance_wall(m)
	local e = gStateExtras[m.playerIndex]
	m.vel.y = 0
    mario_set_forward_vel(m, 0)
	m.marioBodyState.handState = MARIO_HAND_OPEN
	if (m.input & INPUT_A_PRESSED) ~= 0 then
		set_jumping_action(m, ACT_TRIPLE_JUMP, 0)
		play_character_sound(m, CHAR_SOUND_HOOHOO)
		m.vel.y = 65.0
    end
	if (m.input & INPUT_Z_PRESSED) ~= 0 then
		m.vel.y = -10
		set_mario_action(m, ACT_SOFT_BONK, 0)
    end
	if (m.input & INPUT_B_PRESSED) ~= 0 then
		set_mario_action(m, ACT_JUMP_KICK, 0)
	end
end

function mario_update(m)
	local e = gStateExtras[m.playerIndex]
	local thokkable = m.action == ACT_JUMP or m.action == ACT_DOUBLE_JUMP or m.action == ACT_LONG_JUMP or m.action == ACT_TRIPLE_JUMP or m.action == ACT_SIDE_FLIP or m.action == ACT_BACKFLIP or m.action == ACT_WALL_KICK_AIR or m.action == ACT_STEEP_JUMP
	if thokkable and m.actionTimer > 0 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
		if m.flags & (MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD) == 0 then
			m.vel.y = 60
			mario_set_forward_vel(m, m.forwardVel * 2.5)
		else
			m.vel.y = 50
			mario_set_forward_vel(m, m.forwardVel * 2)
		end
		return set_mario_action(m, ACT_TWISTER_THOK_JUMP, 0)
    end
	if thokkable then
		m.actionTimer = m.actionTimer + 1
	end
	if (m.action & ACT_FLAG_AIR) == 0 or m.action == ACT_WALL_KICK_AIR then
		e.crystallanced = 0
	end
	if m.action == ACT_DIVE and e.crystallanced == 0 then
		e.crystallanced = 1
		return set_mario_action(m, ACT_CRYSTAL_LANCE_START, 0)
	end
	if m.action == ACT_WATER_IDLE then
		return set_mario_action(m, ACT_WATER_FALLING, 0)
	end
end

function mario_before_phys_step(m)
	local hScale = 1.0
	local e = gStateExtras[m.playerIndex]
	if (m.action & ACT_FLAG_AIR) ~= 0 and m.vel.y < 0 then
		m.vel.y = m.vel.y - 1.5
	end
	-- slower holding item
	if m.heldObj ~= nil then
		hScale = hScale * 2
	end
	m.vel.x = m.vel.x * hScale
	m.vel.z = m.vel.z * hScale
end

-----------
-- hooks --
-----------
hook_event(HOOK_BEFORE_PHYS_STEP, mario_before_phys_step)
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_SET_MARIO_ACTION, mario_on_set_action)

hook_mario_action(ACT_TWISTER_THOK_JUMP, act_twister_thok_jump)
hook_mario_action(ACT_TWISTER_THOK_STOMP, act_twister_thok_stomp)
hook_mario_action(ACT_CRYSTAL_LANCE_START, act_crystal_lance_start)
hook_mario_action(ACT_CRYSTAL_LANCE_DASH, act_crystal_lance_dash)
hook_mario_action(ACT_CRYSTAL_LANCE_WALL, act_crystal_lance_wall)