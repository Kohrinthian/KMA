-- Default saved settings
KMADB = KMADB or { size = 28 }

-- Hide the original stock minimap arrow
if MinimapPlayer then 
    MinimapPlayer:Hide() 
end
if MinimapPlayer_Texture then 
    MinimapPlayer_Texture:SetAlpha(0) 
end

-- Create the custom overlay arrow frame centered on the minimap
local f = CreateFrame("Frame", "KMACustomArrow", Minimap)
f:SetWidth(KMADB.size)
f:SetHeight(KMADB.size)
f:SetPoint("CENTER", Minimap, "CENTER", 0, 0)

-- Attach your custom TGA texture
local tex = f:CreateTexture(nil, "OVERLAY")
tex:SetAllPoints(f)
tex:SetTexture("Interface\\AddOns\\KMA\\Media\\KMA.tga")

-- 1.12 Model-scanning rotation loop
local function GetNativeArrowModel()
    if not Minimap or not Minimap.GetChildren then return nil end
    for _, child in ipairs({ Minimap:GetChildren() }) do
        if child.GetModel and child.GetFacing then
            local ok, path = pcall(child.GetModel, child)
            if ok and type(path) == "string" then
                path = string.gsub(string.lower(path), "/", "\\")
                if string.find(path, "\\minimaparrow", 1, true) then
                    child:SetAlpha(0)
                    return child
                end
            end
        end
    end
end

local function RotateTexture(texture, angle)
    local c, s = math.cos(angle) / 2, math.sin(angle) / 2
    texture:SetTexCoord(
        0.5 - c - s,
        0.5 + s - c,
        0.5 - c + s,
        0.5 + s + c,
        0.5 + c - s,
        0.5 - s - c,
        0.5 + c + s,
        0.5 - s + c
    )
end

f:SetScript("OnUpdate", function()
    local arrowModel = GetNativeArrowModel()
    if arrowModel and arrowModel.GetFacing then
        local ok, facing = pcall(arrowModel.GetFacing, arrowModel)
        if ok and type(facing) == "number" then
            RotateTexture(tex, -facing)
        end
    end
end)

-- Slash command for live resizing
SLASH_KMA1 = "/kma"
SlashCmdList["KMA"] = function(msg)
    msg = string.gsub(msg or "", "^%s*(.-)%s*$", "%1")
    local size = tonumber(msg)
    if size and size >= 8 and size <= 128 then
        KMADB.size = size
        f:SetWidth(size)
        f:SetHeight(size)
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ffcc[KMA]|r Minimap Arrow size set to: " .. size)
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ffcc[KMA]|r Usage: /kma [size] (e.g., /kma 32)")
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ffcc[KMA]|r Current size: " .. KMADB.size)
    end
end

-- Broadcast greeting when entering the world
local broadcastFrame = CreateFrame("Frame")
broadcastFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
broadcastFrame:SetScript("OnEvent", function()
    -- Fires once upon login/reload
    DEFAULT_CHAT_FRAME:AddMessage("|cff00ffcc[KMA]|r |cffffd100Minimap Arrow loaded!|r Use |cff00ffcc/kma [size]|r - Current: " .. KMADB.size)
    broadcastFrame:UnregisterAllEvents()
end)
