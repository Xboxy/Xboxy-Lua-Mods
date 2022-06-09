-- name: Advanced Rules
-- description: Displays rules/welcome message to anyone who connects to your server By Xboxy And I Dont Know Who For The Original

-- false: Window won't close when mouse hovers over the OK button, only Buttons work
-- true: Window will close when mouse hovers over the OK button, alternatively buttons work too
CLOSE_ON_MOUSE_HOVER = true

-- text-related options
-- sets font, scale (of text) and color for all texts;
globalFont = FONT_NORMAL
scale = 1.4
color = "#000000"

local switched = true
local hasConfirmed = false
function displayrules(m)
    hostnum = network_local_index_from_global(0)
    host = gNetworkPlayers[hostnum]

    -- texts are written inside here.
    --[[ format: 
    {
        string, 
        x, 
        y, 
        font, 
        scale, 
        color (color in "#xxxxxx" format pls)
    }
--]]
    texts = {
        {
            "Hello, Welcome To " .. host.name .. "'s Server! Heres The Rules",
            0,
            -260,
            globalFont,
            1.2,
            color
        },
        {
            "#1 No Spam!",
            0,
            -180,
            globalFont,
            scale,
            color
        },
        {
            "#2 No Cheating!",
            0,
            -90,
            globalFont,
            scale,
            color
        },
        {
            "#3 No Swearing!",
            0,
            0,
            globalFont,
            scale,
            color
        },
        {
            "ENJOY AND HAVE FUN!",
            0,
            120,
            FONT_COUNT,
            2,
            "#FFFF00"
        },
        {
            "By confirming you agree to the server rules.",
            0,
            180,
            globalFont,
            scale,
            color
        },
        {
            "Breaking the rules will result in a kick or ban.",
            0,
            210,
            globalFont,
            scale,
            color
        },
        {
            "Hover your mouse over OK or press A,",
            0,
            270,
            globalFont,
            scale,
            color
        },
        {
            "OK",
            0,
            360,
            FONT_MENU,
            scale,
            "#ffffff"
        }
    }

    -----------------------------------------
    -- Main code:
    m = gMarioStates[0]
    if (switched == true) then
        if (hasConfirmed == false) then
            set_mario_action(m, ACT_INTRO_CUTSCENE, 0)
        end
        -- render the rectangle.
        renderRect(190, 120, FONT_MENU, 790, 900, "#ffffff")

        -- print all texts
        for _, v in ipairs(texts) do
            printColorText(v[1], v[2], v[3], v[4], v[5], v[6])
        end

        -- get relative coordinates of OK text
        local xd = returnX("OK", scale, globalFont)
        local yd = returnY("OK", scale, globalFont) + 360

        -- get mouse_x and mouse_y coordinates
        local mousex = djui_hud_get_mouse_x()
        local mousey = djui_hud_get_mouse_y()

        -- calculate distance between button and mouse
        -- if player presses D_PAD Down or (if mouse_hover is activated) hovers over the OK text,
        -- the window closes.
        local dist = math.sqrt(((xd - mousex) ^ 2) + (((yd + 40) - mousey) ^ 2))
        if (CLOSE_ON_MOUSE_HOVER) then
            if (dist < 40) then
                switched = false
                play_sound(SOUND_MENU_CLICK_FILE_SELECT, m.marioObj.header.gfx.cameraToObject)
                if (hasConfirmed == false) then
                    gMarioStates[m.playerIndex].health = 2176
                    return warp_to_level(gNetworkPlayers[m.playerIndex].currLevelNum, gNetworkPlayers[m.playerIndex].currAreaIndex, gNetworkPlayers[m.playerIndex].currActNum)
                end
            end
        end

        if (m.controller.buttonPressed) ~= 0 then
            switched = false
            play_sound(SOUND_MENU_CLICK_FILE_SELECT, m.marioObj.header.gfx.cameraToObject)
            if (hasConfirmed == false) then
                gMarioStates[m.playerIndex].health = 2176
    return warp_to_level(gNetworkPlayers[m.playerIndex].currLevelNum, gNetworkPlayers[m.playerIndex].currAreaIndex, gNetworkPlayers[m.playerIndex].currActNum)
            end
        end
    end
end

-- prints text in the center of the screen
function printColorText(text, x, y, font, scale, color)
    local r, g, b, a = 0, 0, 0, 0

    local rgbtable = checkColorFormat(color)
    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(font)

    local screenWidth = djui_hud_get_screen_width()
    local width = (djui_hud_measure_text(text) / 2) * scale

    local screenHeight = djui_hud_get_screen_height()
    local height = 64 * scale

    -- get centre of screen
    local halfwidth = screenWidth / 2
    local halfheight = screenHeight / 2

    local xc = halfwidth - width
    local yc = halfheight - height

    djui_hud_set_color(rgbtable.r, rgbtable.g, rgbtable.b, 255)
    djui_hud_print_text(text, xc + x, yc + y, scale)
end

-- returns X coordinate relative to text
function returnX(text, scale, font)
    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(font)

    local screenWidth = djui_hud_get_screen_width()
    local width = (djui_hud_measure_text(text) / 2) * scale

    local screenHeight = djui_hud_get_screen_height()
    local height = 64 * scale

    -- get centre of screen
    local halfwidth = screenWidth / 2
    local halfheight = screenHeight / 2

    local xc = halfwidth - width
    local yc = halfheight - height

    return xc
end

-- returns Y coordinate relative to text
function returnY(text, scale, font)
    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_font(font)

    local screenWidth = djui_hud_get_screen_width()
    local width = (djui_hud_measure_text(text) / 2) * scale

    local screenHeight = djui_hud_get_screen_height()
    local height = 64 * scale

    -- get centre of screen
    local halfwidth = screenWidth / 2
    local halfheight = screenHeight / 2

    local xc = halfwidth - width
    local yc = halfheight - height

    return yc
end

-- renders a rectangle in the center of the screen
function renderRect(x, y, font, w, h, color)
    local rgbtable = checkColorFormat(color)
    djui_hud_set_resolution(RESOLUTION_DJUI)
    --djui_hud_set_font(font);

    local screenWidth = djui_hud_get_screen_width()
    local screenHeight = djui_hud_get_screen_height()

    -- get center
    local halfwidth = screenWidth / 2
    local halfheight = screenHeight / 2

    local xc = x + halfwidth
    local yc = y + halfheight

    local xx = xc - halfwidth
    local yy = yc - halfheight

    local xd = x + (screenWidth / 2)
    local yd = y + (screenHeight / 2)

    local xe = x + (w / 2)
    local ye = y + (h / 2)

    local fx = xd - xe
    local fy = yd - ye

    djui_hud_set_color(rgbtable.r, rgbtable.g, rgbtable.b, 170)
    djui_hud_render_rect(fx, fy, w, h)
end

function displayrules2()
    if (switched) then
        djui_chat_message_create("The window has already been opened. Please close it first.")
        return true
    end
    switched = true
    return true
end

function checkColorFormat(rgbhex)
    local r, g, b, a = 0, 0, 0, 0

    local d = string.find(color, "#")
    if ((d == 1) and (string.len(rgbhex) == 7)) then
        local colorhex = string.gsub(rgbhex, "#", "")
        r = string.sub(colorhex, 0, 2)
        g = string.sub(colorhex, 3, 4)
        b = string.sub(colorhex, 5, 6)

        r = tonumber(r, 16)
        g = tonumber(g, 16)
        b = tonumber(b, 16)
        return {r = r, g = g, b = b}
    else
        print("Color format is wrong.")
        return
    end
end

hook_event(HOOK_ON_HUD_RENDER, displayrules)
hook_chat_command("rules", "displays the rules of this server", displayrules2)