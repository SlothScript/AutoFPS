FramerateMoverDB = FramerateMoverDB or { x = 0, y = -15 }

local frame = CreateFrame("Frame")

local function GetFPSFrame()
    return FramerateFrame or FramerateLabel
end

local function EnableFPS()
    if ToggleFramerate then
        ToggleFramerate(true)
    elseif SetCVar then
        SetCVar("showFPS", 1)
    end
end

local function MoveFPS(x, y)
    local fps = GetFPSFrame()
    if not fps then return end

    fps:ClearAllPoints()
    fps:SetPoint("CENTER", UIParent, "TOP", x, y - 15)

    FramerateMoverDB.x = x
    FramerateMoverDB.y = y
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function()
    EnableFPS()

    local fps = GetFPSFrame()
    if not fps then
        print("AutoFPS: FPS frame not found")
        return
    end

    MoveFPS(FramerateMoverDB.x, FramerateMoverDB.y)
end)

SLASH_AUTOFPS1 = "/frpos"
SlashCmdList.AUTOFPS = function(msg)
    local x, y = msg:match("^%s*(-?%d+)%s+(-?%d+)%s*$")
    x, y = tonumber(x), tonumber(y)

    if not x or not y then
        print("Usage: /frpos <x> <y>")
        return
    end

    MoveFPS(x, y)
    print("AutoFPS: moved to", x, y)
end
