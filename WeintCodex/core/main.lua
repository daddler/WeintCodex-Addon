WeintCodex = WeintCodex or {}
WeintCodex.Version = "0.6"

SLASH_WEINTCODEX1 = "/wc"
SLASH_WEINTCODEX2 = "/weintcodex"

SlashCmdList["WEINTCODEX"] = function(msg)
    local cmd = msg and msg:lower() or ""

    if cmd == "import" then
        if WeintCodex.Sync and WeintCodex.Sync.ShowImportDialog then
            WeintCodex.Sync.ShowImportDialog()
        end
        return
    end

    if WeintCodex.MainFrame:IsShown() then
        WeintCodex.MainFrame:Hide()
    else
        if WeintCodex.ResetToHome then
            WeintCodex.ResetToHome()
        end
        WeintCodex.MainFrame:Show()
    end
end

local function OnAddonLoaded(self, event, addonName)
    if addonName ~= "WeintCodex" then return end

    if not WeintCodex_SavedData then
        WeintCodex_SavedData = {
            bossData = {},
            raidData = {},
            materialData = {},
        }
    end

    WeintCodex.SavedData = WeintCodex_SavedData

    if WeintCodex.ResetToHome then
        WeintCodex.ResetToHome()
    end

    print("|cff8B5CF6[WeintCodex]|r |cff22C55Ev" .. WeintCodex.Version .. "|r geladen. |cffaaaaaa/wc zum Öffnen.|r")
end

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", OnAddonLoaded)
