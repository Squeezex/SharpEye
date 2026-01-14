local addonName = ...

-- Check if LibStub, LibDataBroker and LibDBIcon are available
local LDB = LibStub("LibDataBroker-1.1")
local LDBIcon = LibStub("LibDBIcon-1.0")


-- SavedVariables must exist
SharpEyeDB = SharpEyeDB or {}
SharpEyeDB.minimap = SharpEyeDB.minimap or {}


-- Set the icon ID (can be changed)
local ICON_ID = "INV_Misc_Eye_01"


-- Create the LDB object
-- Toggle the ResampleAlwaysSharpen CVar
local ldbLauncher = LDB:NewDataObject("SharpEye", {
    type = "launcher",
    text = "SharpEye",
    icon = "Interface\\Icons\\"..ICON_ID,
    OnClick = function(self, button)
        local state = not GetCVarBool("ResampleAlwaysSharpen")
        SetCVar("ResampleAlwaysSharpen", state)
        print(state and "|cff00ff00Sharpen enabled|r" or "|cffff0000Sharpen disabled|r")
    end,
    OnTooltipShow = function(tt)
        tt:AddLine("SharpEye")
        tt:AddLine("Click: toggle ResampleAlwaysSharpen")
    end,
})

-- Register after ADDON_LOADED
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name == addonName then
        LDBIcon:Register("SharpEye", ldbLauncher, SharpEyeDB.minimap)
    end
end)
