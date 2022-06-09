-- name: Spring Mario 1.2
-- description: Best Mod Ever!!!! Also Made By Xboxy

Threshold = 0

function mario_update(m)
    if (m.controller.buttonPressed & A_BUTTON) ~= 0 and m.action == ACT_GROUND_POUND_LAND then
        m.action = ACT_SPECIAL_TRIPLE_JUMP
        m.vel.y = 72
    end
    if (m.controller.buttonPressed & B_BUTTON) ~= 0 and m.action == ACT_GROUND_POUND then
        m.action = ACT_THROWN_FORWARD
    end

    if m.action == ACT_JUMP then
        set_mario_action(m, ACT_DOUBLE_JUMP, 0)
        play_sound(SOUND_GENERAL_BOING1, gMarioStates[0].marioObj.header.gfx.cameraToObject)
    end

    if m.action == ACT_BUTT_SLIDE then
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
    end
    
    if m.action == ACT_TWIRLING and (m.controller.buttonDown & Z_TRIG) ~= 0 then
        m.vel.y = -55
        m.particleFlags = m.particleFlags | PARTICLE_DUST
     end
     if m.action == ACT_TWIRLING and (m.controller.buttonDown & A_BUTTON) ~= 0 then
        m.vel.y = 4
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
     end
     if m.action == ACT_FLYING then
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
     end
    if m.action == ACT_DOUBLE_JUMP_LAND then
        set_mario_action(m, ACT_JUMP, 0)
                m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_HORIZONTAL_STAR
    end
    if m.action == ACT_DOUBLE_JUMP then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
        m.faceAngle.y = m.intendedYaw
    end
    if m.action == ACT_JUMP_KICK then
        set_mario_action(m, ACT_TWIRLING, 0)
    end
    if m.action == ACT_TWIRLING then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
    end

    if m.action == ACT_TRIPLE_JUMP then
        set_mario_anim_with_accel(m, MARIO_ANIM_BEING_GRABBED, 0)
        m.faceAngle.y = m.intendedYaw
    end

    if m.action == ACT_DIVE then
        set_mario_action(m, ACT_TWIRLING, 0)
    end
    if m.action == ACT_TRIPLE_JUMP_LAND then
        set_mario_action(m, ACT_JUMP, 0)
    end
    if m.action == ACT_TWIRL_LAND then
        set_mario_action(m, ACT_BUTT_SLIDE, 0)
    end
    if m.action == ACT_HOLD_JUMP then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
        m.faceAngle.y = m.intendedYaw
    end
    if m.action == ACT_HOLD_JUMP_LAND then
        set_mario_action(m, ACT_HOLD_JUMP, 0)
        play_sound(SOUND_GENERAL_BOING1, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_HORIZONTAL_STAR
    end
    if m.action == ACT_THROWING then
        set_mario_action(m, ACT_RELEASING_BOWSER, 0)
    end
    if m.action == ACT_AIR_HIT_WALL then
        set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
        m.vel.y = 10
    end
    if m.action == ACT_HEAVY_THROW then
        set_mario_action(m, ACT_RELEASING_BOWSER, 0)
    end
    if m.action == ACT_WATER_THROW then
        set_mario_action(m, ACT_RELEASING_BOWSER, 0)
    end
    if m.action == ACT_AIR_THROW then
        set_mario_action(m, ACT_RELEASING_BOWSER, 0)
    end
    if m.action == ACT_STEEP_JUMP then
        set_mario_action(m, ACT_JUMP, 0)
        m.faceAngle.y = m.intendedYaw
    end
    if m.action == ACT_GROUND_POUND then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
    end

    if (m.action & ACT_FLAG_AIR) ~= 0 and (m.controller.buttonPressed & U_JPAD) ~= 0 then
        set_mario_action(m, ACT_FLYING, 0)
    end

    if m.action == ACT_FLYING then
        set_mario_anim_with_accel(m, MARIO_ANIM_RELEASE_BOWSER, 0)
    end
    if m.action == ACT_METAL_WATER_JUMP then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
    end
    if m.action == ACT_METAL_WATER_FALLING then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
    end
    if m.action == ACT_RIDING_SHELL_GROUND then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
        m.faceAngle.y = m.intendedYaw
    end
    if m.action == ACT_RIDING_SHELL_JUMP then
        set_mario_anim_with_accel(m, MARIO_ANIM_BEING_GRABBED, 0)
        m.faceAngle.y = m.intendedYaw
    end
    if m.action == ACT_RIDING_SHELL_FALL then
        set_mario_anim_with_accel(m, MARIO_ANIM_BEING_GRABBED, 0)
        m.faceAngle.y = m.intendedYaw
    end
    if m.action == ACT_METAL_WATER_FALL_LAND then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
    end
    if m.action == ACT_METAL_WATER_JUMP_LAND then
        set_mario_anim_with_accel(m, MARIO_ANIM_BOTTOM_STUCK_IN_GROUND, 0)
    end
    if m.action == ACT_METAL_WATER_JUMP_LAND then
        set_mario_action(m, ACT_METAL_WATER_JUMP, 0)
        play_sound(SOUND_GENERAL_BOING1, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_BREATH
        set_camera_shake_from_hit(SHAKE_FOV_MEDIUM)
    end
    if m.action == ACT_RIDING_SHELL_GROUND then
        set_mario_action(m, ACT_RIDING_SHELL_JUMP, 0)
        play_sound(SOUND_GENERAL_BOING1, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_HORIZONTAL_STAR
    end
    if m.action == ACT_METAL_WATER_FALL_LAND then
        set_mario_action(m, ACT_METAL_WATER_JUMP, 0)
        play_sound(SOUND_GENERAL_BOING1, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_BREATH
    end
end
function spring()
    if (gMarioStates[0].health ~= 0xff) then
        play_sound(SOUND_GENERAL_BOING1, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        set_camera_shake_from_hit(SHAKE_ATTACK)
        
    end
end
        
-- hooks --
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_PVP_ATTACK, spring)


