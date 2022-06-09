-- name: \\#ff0000\\Jump Then Get Burned
-- description: \\#9e2020\\AHHHHHHHHHHHHHHH!

Threshold = 0

function mario_update(m)
    
    if m.action == ACT_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_BACKFLIP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    
    if m.action == ACT_DIVE then
        set_mario_action(m, ACT_BURNING_FALL, 0)
    end

    if m.action == ACT_JUMP_KICK then
        set_mario_action(m, ACT_BURNING_FALL, 0)
    end

    if m.action == ACT_LONG_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_SHOT_FROM_CANNON then
        set_mario_action(m, ACT_BURNING_FALL, 0)
    end

    if m.action == ACT_DOUBLE_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_TRIPLE_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_TWIRLING then
        set_mario_action(m, ACT_BURNING_FALL, 0)
    end

    if m.action == ACT_WATER_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_TOP_OF_POLE_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_STEEP_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_RIDING_SHELL_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_HOLD_METAL_WATER_JUMP then
        set_mario_action(m, ACT_BURNING_FALL, 0)
    end

    if m.action == ACT_SPECIAL_TRIPLE_JUMP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_GROUND_POUND_LAND then
        set_mario_action(m, ACT_BURNING_GROUND, 0)
    end

    if m.action == ACT_GROUND_POUND then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    if m.action == ACT_SIDE_FLIP then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
    end

    
    if (m.forwardVel > 0-Threshold) and (m.forwardVel < Threshold) then
        m.forwardVel = Threshold 
    end
end

-- hooks --
hook_event(HOOK_MARIO_UPDATE, mario_update)
