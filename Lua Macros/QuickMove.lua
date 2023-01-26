-- Aegisub Automation Tools for Quick Move Position Tags
script_name = "Quick Move"
script_description = "快速移动"
script_author = "IKK"
-- part of scirpts are from Hyperdimensional Relocator written by reanimated 
script_version = "0.2"

-- getpos
-- ** This function is witten by reanimated from Hyperdimensional Relocator **
-- **      Check site: "http://unanimated.hostfree.pw/ts/relocator.lua"     **

function getSize(subs)
    local i = 1
    local x = 0
    local y = 0
    while i <= 10 do
        local l = subs[i]
        if l.class == "info" then
            info = l.key
            if info == "PlayResX" then
                x = l.value
            else
                if info == "PlayResY" then y = l.value end
            end
        end
        i = i + 1
    end
    return x, y
end

function getpos(subs, text)
    st = nil
    defst = nil
    for g = 1, #subs do
        if subs[g].class == "info" then
            local k = subs[g].key
            local v = subs[g].value
            if k == "PlayResX" then resx = v end
            if k == "PlayResY" then resy = v end
        end
        if resx == nil then resx = 0 end
        if resy == nil then resy = 0 end
        if subs[g].class == "style" then
            local s = subs[g]
            if s.name == line.style then
                st = s
                break
            end
            if s.name == "Default" then defst = s end
        end
        if subs[g].class == "dialogue" then
            if defst then
                st = defst
            else
                aegisub.debug.out("Style '" .. line.style ..
                                      "' not found.\nStyle 'Default' not found. ",
                                  1)
            end
            break
        end
    end
    if st then
        acleft = st.margin_l
        if line.margin_l > 0 then acleft = line.margin_l end
        acright = st.margin_r
        if line.margin_r > 0 then acright = line.margin_r end
        acvert = st.margin_t
        if line.margin_t > 0 then acvert = line.margin_t end
        acalign = st.align
        if text:match("\\an%d") then acalign = text:match("\\an(%d)") end
        aligntop = "789"
        alignbot = "123"
        aligncent = "456"
        alignleft = "147"
        alignright = "369"
        alignmid = "258"
        if alignleft:match(acalign) then
            horz = acleft
        elseif alignright:match(acalign) then
            horz = resx - acright
        elseif alignmid:match(acalign) then
            horz = resx / 2
        end
        if aligntop:match(acalign) then
            vert = acvert
        elseif alignbot:match(acalign) then
            vert = resy - acvert
        elseif aligncent:match(acalign) then
            vert = resy / 2
        end
    end
    if horz > 0 and vert > 0 then
        if not text:match("^{\\") then text = "{\\rel}" .. text end
        text = text:gsub("^({\\[^}]-)}",
                         "%1\\pos(" .. horz .. "," .. vert .. ")}"):gsub(
                   "\\rel", "")
    end
    return text
end

-- 通用模块
function Move(subs, sel, x_move, y_move)
    for k, v in pairs(sel) do
        line = subs[v]
        local tmp = line.text

        -- check if there are pos or move tag
        local match_pos = tmp:match("\\pos")
        local match_move = tmp:match("\\move")
        if (not match_pos) and (not match_move) then
            tmp = getpos(subs, tmp)
        end

        -- change pos
        tmp = tmp:gsub("\\pos%(([%d.-]+),([%d.-]+)", function(x, y)
            return "\\pos(" .. x + x_move .. "," .. y + y_move
        end)

        -- change move
        tmp = tmp:gsub("\\move%(([%d.-]+),([%d.-]+),([%d.-]+),([%d.-]+)",
                       function(a, b, c, d)
            return "\\move(" .. a + x_move .. "," .. b + y_move .. "," .. c +
                       x_move .. "," .. d + y_move
        end)

        -- change org
        tmp = tmp:gsub("\\org%(([%d.-]+),([%d.-]+)", function(x, y)
            return "\\org(" .. x + x_move .. "," .. y + y_move
        end)

        -- change clip
        -- ** adapted from reanimated **
        tmp = tmp:gsub("clip%(([%d.-]+),([%d.-]+),([%d.-]+),([%d.-]+)",
                       function(a, b, c, d)
            a = a + x_move
            b = b + y_move
            c = c + x_move
            d = d + y_move
            return "clip(" .. a .. "," .. b .. "," .. c .. "," .. d
        end)
        if tmp:match("clip%(m [%d%a%s%-%.]+%)") then
            ctext = tmp:match("clip%(m ([%d%a%s%-%.]+)%)")
            ctext2 = ctext:gsub("([%d%-%.]+)%s([%d%-%.]+)", function(a, b)
                return a + x_move .. " " .. b + y_move
            end)
            ctext = ctext:gsub("%-", "%%-")
            tmp = tmp:gsub("clip%(m " .. ctext, "clip(m " .. ctext2)
        end

        if tmp:match("clip%(%d+,m [%d%a%s%-%.]+%)") then
            fac, ctext = tmp:match("clip%((%d+),m ([%d%a%s%-%.]+)%)")
            factor = 2 ^ (fac - 1)
            ctext2 = ctext:gsub("([%d%-%.]+)%s([%d%-%.]+)", function(a, b)
                return a + x_move .. " " .. b + y_move
            end)
            ctext = ctext:gsub("%-", "%%-")
            tmp = tmp:gsub(",m " .. ctext, ",m " .. ctext2)
        end

        -- 更新此行字幕
        line.text = tmp
        subs.delete(v)
        subs[-v] = line
    end
end

-- 获取全部样式
function GetAllStyle(subs)
    local i = 1
    local AllStyle = {}
    for i = 1, #subs do
        local l = subs[i]
        if l.class == "style" then table.insert(AllStyle, l.name) end
    end
    -- aegisub.debug.out("ASS样式库读取成功.\n")
    return AllStyle
end

-- 移动样式
function move_styles(subs)
    -- 获取样式
    all_styles = GetAllStyle(subs)
    -- 生成GUI
    STYLEGUI = {
        {x = 0, y = 0, width = 5, class = "label", label = "Style name"},
        {x = 6, y = 0, width = 3, class = "label", label = "X"},
        {x = 9, y = 0, width = 3, class = "label", label = "Y"}
    }
    for n = 1, #all_styles do
        table.insert(STYLEGUI, {
            x = 0,
            y = n,
            width = 5,
            class = "label",
            label = all_styles[n]
        })
        table.insert(STYLEGUI, {
            x = 6,
            y = n,
            width = 3,
            class = "floatedit",
            value = 0,
            name = all_styles[n] .. "_x"
        })
        table.insert(STYLEGUI, {
            x = 9,
            y = n,
            width = 3,
            class = "floatedit",
            value = 0,
            name = all_styles[n] .. "_y"
        })

    end

    buttons, results = aegisub.dialog.display(STYLEGUI, {"Apply", "Cancel"})
    if buttons == "Apply" then
        -- 根据样式
        for n = 1, #all_styles do
            current_style_name = all_styles[n]
            current_x = results[current_style_name .. "_x"]
            current_y = results[current_style_name .. "_y"]
            -- aegisub.debug.out(current_x .. "   " .. current_y)
            if current_x ~= 0 or current_y ~= 0 then
                for i = 1, #subs do
                    local l = subs[i]
                    if l.class == "dialogue" then
                        if l.style == current_style_name and not l.comment then
                            Move(subs, {i}, current_x, current_y)
                        end
                    end
                end

            end
        end
    else
        aegisub.debug.out("\n用户中断.\n")
    end

end

function script_has_size(subs)
    x, y = getSize(subs)
    if x ~= 0 and y ~= 0 then
        return true
    else
        return false
    end
end

SMALL_STEP = 1

-- 向左移动1个像素
function Left_move_small(subs, sel) Move(subs, sel, -SMALL_STEP, 0) end

-- 向右移动1个像素
function Right_move_small(subs, sel) Move(subs, sel, SMALL_STEP, 0) end

-- 向上移动1个像素
function Up_move_small(subs, sel) Move(subs, sel, 0, -SMALL_STEP) end

-- 向下移动1个像素
function Down_move_small(subs, sel) Move(subs, sel, 0, SMALL_STEP) end

-- 向左移动15个像素
function Left_move_big(subs, sel)
    x, y = getSize(subs)
    BIG_STEP = x / 128
    Move(subs, sel, -BIG_STEP, 0)
end

-- 向右移动15个像素
function Right_move_big(subs, sel)
    x, y = getSize(subs)
    BIG_STEP = x / 128
    Move(subs, sel, BIG_STEP, 0)
end

-- 向上移动15个像素
function Up_move_big(subs, sel)
    x, y = getSize(subs)
    BIG_STEP = x / 128
    Move(subs, sel, 0, -BIG_STEP)
end

-- 向下移动15个像素
function Down_move_big(subs, sel)
    x, y = getSize(subs)
    BIG_STEP = x / 128
    Move(subs, sel, 0, BIG_STEP)
end

aegisub.register_macro("快速移动/左移小间隔", "Move left small",
                       Left_move_small, script_has_size)

aegisub.register_macro("快速移动/右移小间隔", "Move right small",
                       Right_move_small, script_has_size)

aegisub.register_macro("快速移动/上移小间隔", "Move up small",
                       Up_move_small, script_has_size)

aegisub.register_macro("快速移动/下移小间隔", "Move down small",
                       Down_move_small, script_has_size)

aegisub.register_macro("快速移动/左移大间隔", "Move left big",
                       Left_move_big, script_has_size)

aegisub.register_macro("快速移动/右移大间隔", "Move right big",
                       Right_move_big, script_has_size)

aegisub.register_macro("快速移动/上移大间隔", "Move up big",
                       Up_move_big, script_has_size)

aegisub.register_macro("快速移动/下移大间隔", "Move down big",
                       Down_move_big, script_has_size)

aegisub.register_macro("Furigana Helper/Move by style", "Move by style",
                       move_styles, script_has_size)

-- Hotkey Config Suggestion

-- "automation/lua/QuickMove/快速移动/上移大间隔" : [
--     "Ctrl-Alt-Shift-Up"
-- ],
-- "automation/lua/QuickMove/快速移动/上移小间隔" : [
--     "Ctrl-Shift-Up"
-- ],
-- "automation/lua/QuickMove/快速移动/下移大间隔" : [
--     "Ctrl-Alt-Shift-Down"
-- ],
-- "automation/lua/QuickMove/快速移动/下移小间隔" : [
--     "Ctrl-Shift-Down"
-- ],
-- "automation/lua/QuickMove/快速移动/右移大间隔" : [
--     "Ctrl-Alt-Shift-Right"
-- ],
-- "automation/lua/QuickMove/快速移动/右移小间隔" : [
--     "Ctrl-Shift-Right"
-- ],
-- "automation/lua/QuickMove/快速移动/左移大间隔" : [
--     "Ctrl-Alt-Shift-Left"
-- ],
-- "automation/lua/QuickMove/快速移动/左移小间隔" : [
--     "Ctrl-Shift-Left"
-- ],
