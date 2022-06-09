-- name: Green Demons v2
-- description: Vile demons have appeared! Taking the form of homing 1ups, these foul creatures will stop at nothing to kill you. Can you and your friends can escape them? /Skin To Change The Skin Of The Green Demon, note that this does not change anything else.  Modified By Xboxy
-- updates: blacklisted levels to prevent the 1up from spawning in them and a sound playing when the 1up spawns (added by submergedmaid)


blacklisted_levels = {[6]=true, [16]=true, [26]=true, [30]=true, [33]=true, [34]=true}

Demonskin = E_MODEL_1UP

function oneup_update(m)

if not blacklisted_levels[gNetworkPlayers[0].currLevelNum] then
    if not (obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil) then
		play_sound(SOUND_GENERAL2_1UP_APPEAR, gMarioStates[0].marioObj.header.gfx.cameraToObject)
        local obj = spawn_sync_object(
            id_bhvHidden1upInPole,

            Demonskin,

            gMarioStates[0].pos.x, gMarioStates[0].pos.y + 100, gMarioStates[0].pos.z + 1000,
        
            function(obj)
                obj.oBehParams2ndByte = 2
                obj.oAction = 3
            end)		
		end
	end
end


function player_kill(unloadedObj)
    nearest = nearest_mario_state_to_object(unloadedObj)
    if (get_id_from_behavior(unloadedObj.behavior) == id_bhvHidden1upInPole and nearest.playerIndex == 0) then
		gMarioStates[0].health = 0xff
    end
end


hook_event(HOOK_ON_SYNC_VALID, oneup_update)
hook_event(HOOK_ON_OBJECT_UNLOAD, player_kill)

function skinset(msg)
    if msg == '1up' then
        djui_chat_message_create('Demon Skin set to 1up')
        Demonskin = E_MODEL_1UP
        return true
    elseif msg == 'heart' then
        djui_chat_message_create('Demon Skin set to Heart')
        Demonskin = E_MODEL_HEART
        return true
    end
    if msg == 'bluecoin' then
        djui_chat_message_create('Demon Skin set to Blue Coin')
        Demonskin = E_MODEL_BLUE_COIN
        return true
    end
    if msg == 'egg' then
        djui_chat_message_create('Demon Skin set to Yoshi Egg')
        Demonskin = E_MODEL_YOSHI_EGG
        return true
    end
    if msg == 'star' then
        djui_chat_message_create('Demon Skin set to Star')
        Demonskin = E_MODEL_STAR
        return true
    end
    if msg == 'bowserbomb' then
        djui_chat_message_create('Demon Skin set to Bowser Bomb')
        Demonskin = E_MODEL_BOWSER_BOMB
        return true
    end
    if msg == 'shell' then
        djui_chat_message_create('Demon Skin set to Koopa Shell')
        Demonskin = E_MODEL_KOOPA_SHELL
        return true
    end
    if msg == 'waterbomb' then
        djui_chat_message_create('Demon Skin set to Water Bomb')
        Demonskin = E_MODEL_WATER_BOMB
        return true
    end
    if msg == 'air' then
        djui_chat_message_create('Demon Skin set to Wing Cap')
        Demonskin = E_MODEL_MARIOS_WING_CAP
        return true
    end
    if msg == 'bubble' then
        djui_chat_message_create('Demon Skin set to Bubble')
        Demonskin = E_MODEL_BUBBLE_PLAYER
        return true
    end
    if msg == 'key' then
        djui_chat_message_create('Demon Skin set to Bowser Key')
        Demonskin = E_MODEL_BOWSER_KEY
        return true
    end
    if msg == 'betakey' then
        djui_chat_message_create('Demon Skin set to Beta Boo Key')
        Demonskin = E_MODEL_BETA_BOO_KEY
        return true
    end
    if msg == 'star2' then
        djui_chat_message_create('Demon Skin set to Collected Star')
        Demonskin = E_MODEL_TRANSPARENT_STAR
        return true
    end
    if msg == 'coin' then
        djui_chat_message_create('Demon Skin set to Collected Star')
        Demonskin = E_MODEL_YELLOW_COIN
        return true
    end
    if msg == 'redcoin' then
        djui_chat_message_create('Demon Skin set to Red Coin')
        Demonskin = E_MODEL_RED_COIN
        return true
    end
    return false
end
    
hook_chat_command('skin', "[1up|heart|redcoin|bluecoin|bowserbomb|star|shell|waterbomb|star2|key|betakey|bubble|waterbomb|coin|air|egg] change the skin of the Green Demon More Skins By Xboxy", skinset)