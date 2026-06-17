--------------------------------------------------
-- WeintCodex :: WeakAuras Module
-- Kategorien: Klassenauren, Raidauren, Boss-Auren, Utility
--------------------------------------------------

WeintCodex.WeakAuras = {}

local C = WeintCodex.Colors

--------------------------------------------------
-- WeakAura-Datenbank
-- Wird durch Import ergänzt (WCIMPORT:WA:...)
--------------------------------------------------

local defaultAuras = {
    ["Klassenauren"] = {
        {
            name    = "Todesritter – Ruhige Stärke Tracker",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt Stapel von Ruhiger Stärke und Ablaufzeit.",
            class   = "DEATHKNIGHT",
            color   = {0.77, 0.12, 0.23},
        },
        {
            name    = "Paladin – Heilige Macht Stacks",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt aktuelle Heilige Macht und nächsten Verbraucher.",
            class   = "PALADIN",
            color   = {0.96, 0.55, 0.73},
        },
        {
            name    = "Krieger – Raserei & Mordsinn",
            author  = "Fabian",
            version = "1.1",
            desc    = "Überwacht Raserei-Stapel und Mordsinn-Fenster.",
            class   = "WARRIOR",
            color   = {0.78, 0.61, 0.43},
        },
        {
            name    = "Magier – Procs & Feuerball-Proc",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt Pyroblast-Proc und Heiße Strähne.",
            class   = "MAGE",
            color   = {0.41, 0.80, 0.94},
        },
        {
            name    = "Druide – Eclipse-Tracking",
            author  = "Fabian",
            version = "1.2",
            desc    = "Eclipse-Balken für Balance-Druiden.",
            class   = "DRUID",
            color   = {1.00, 0.49, 0.04},
        },
        {
            name    = "Schurke – Combo-Punkte & Energy",
            author  = "Fabian",
            version = "1.0",
            desc    = "Kombo-Punkte visuell + Energy-Schwellwert.",
            class   = "ROGUE",
            color   = {1.00, 0.96, 0.41},
        },
    },

    ["Raidauren"] = {
        {
            name    = "Raidweit – Blutstropfen-Timer",
            author  = "Fabian",
            version = "2.0",
            desc    = "Zeigt den Boss-Blutstropfen-Enrage-Timer für alle.",
            class   = "RAID",
            color   = {0.54, 0.36, 0.96},
        },
        {
            name    = "Tankwechsel-Hinweis (allgemein)",
            author  = "Fabian",
            version = "1.3",
            desc    = "Warnt bei Tankwechsel-relevanten Debuffs in SoO.",
            class   = "TANK",
            color   = {0.40, 0.80, 1.00},
        },
        {
            name    = "Heiler – Raid-CD Tracker",
            author  = "Fabian",
            version = "1.5",
            desc    = "Übersicht aller Raid-Cooldowns in einer Leiste.",
            class   = "HEALER",
            color   = {0.13, 0.77, 0.37},
        },
        {
            name    = "Interrupt-Tracker SoO",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt Unterbrechungs-Assignments pro Gegner.",
            class   = "RAID",
            color   = {0.96, 0.76, 0.20},
        },
    },

    ["Boss-Auren"] = {
        {
            name    = "Immerseus – Korrosiver Schlamm",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt eigene Stapel von Korrosivem Schlamm.",
            class   = "BOSS",
            color   = {0.20, 0.60, 0.90},
        },
        {
            name    = "Norushen – Verderbnis-Anzeige",
            author  = "Fabian",
            version = "1.1",
            desc    = "Zeigt Verderbnis-Wert und Prüfungs-Modus.",
            class   = "BOSS",
            color   = {0.50, 0.10, 0.60},
        },
        {
            name    = "Sha des Stolzes – Stolz-Tracker",
            author  = "Fabian",
            version = "1.2",
            desc    = "Zeigt eigenen Stolz-Wert und Raidstolz.",
            class   = "BOSS",
            color   = {0.70, 0.30, 0.80},
        },
        {
            name    = "Malkorok – Schild-Tracker",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt Schild-HP und Warnung vor Blutrausch.",
            class   = "BOSS",
            color   = {0.80, 0.20, 0.30},
        },
        {
            name    = "Garrosh – Phasen-Anzeige",
            author  = "Fabian",
            version = "1.3",
            desc    = "Zeigt aktuelle Kampfphase und nächsten Übergang.",
            class   = "BOSS",
            color   = {0.90, 0.20, 0.20},
        },
    },

    ["Utility-Auren"] = {
        {
            name    = "Trank-Reminder",
            author  = "Fabian",
            version = "1.0",
            desc    = "Erinnert dich vor dem Pull und bei 20% Boss-HP an den Kampftrank.",
            class   = "UTILITY",
            color   = {0.96, 0.76, 0.20},
        },
        {
            name    = "Flask-Check vor Pull",
            author  = "Fabian",
            version = "1.0",
            desc    = "Warnt wenn kein Flacon aktiv ist beim Raid-Ready.",
            class   = "UTILITY",
            color   = {0.30, 0.80, 0.50},
        },
        {
            name    = "Ressurection-Queue",
            author  = "Fabian",
            version = "2.1",
            desc    = "Zeigt Wiederbelebungs-Warteschlange für Heiler.",
            class   = "UTILITY",
            color   = {0.13, 0.77, 0.37},
        },
        {
            name    = "Loot-Spec Reminder",
            author  = "Fabian",
            version = "1.0",
            desc    = "Zeigt aktuelle Loot-Spezialisierung beim Öffnen von Beute.",
            class   = "UTILITY",
            color   = {0.60, 0.60, 0.80},
        },
    },
}

--------------------------------------------------
-- Frame
--------------------------------------------------

local waFrame = nil

local classColors = {
    DEATHKNIGHT = {0.77, 0.12, 0.23},
    PALADIN     = {0.96, 0.55, 0.73},
    WARRIOR     = {0.78, 0.61, 0.43},
    MAGE        = {0.41, 0.80, 0.94},
    DRUID       = {1.00, 0.49, 0.04},
    ROGUE       = {1.00, 0.96, 0.41},
    RAID        = {0.54, 0.36, 0.96},
    TANK        = {0.40, 0.80, 1.00},
    HEALER      = {0.13, 0.77, 0.37},
    BOSS        = {0.90, 0.40, 0.20},
    UTILITY     = {0.96, 0.76, 0.20},
}

local function SetSolidBg(f, r, g, b, a)
    local t = f:CreateTexture(nil, "BACKGROUND")
    t:SetAllPoints(f)
    t:SetColorTexture(r, g, b, a or 1)
    return t
end

local function DrawBorder(f, r, g, b, a, thick)
    thick = thick or 1
    local W, H = f:GetWidth(), f:GetHeight()
    local function T(pt, rpt, w, h)
        local t = f:CreateTexture(nil, "OVERLAY")
        t:SetColorTexture(r, g, b, a)
        t:SetPoint(pt, f, rpt, 0, 0)
        t:SetSize(w, h)
    end
    T("TOPLEFT", "TOPLEFT", W, thick)
    T("BOTTOMLEFT", "BOTTOMLEFT", W, thick)
    T("TOPLEFT", "TOPLEFT", thick, H)
    T("TOPRIGHT", "TOPRIGHT", thick, H)
end

local function CreateWAFrame()
    if waFrame then return waFrame end

    local cp = WeintCodex.ContentPanel
    local f  = CreateFrame("Frame", nil, cp)
    f:SetAllPoints(cp)

    -- Title
    local titleStr = f:CreateFontString(nil, "OVERLAY")
    titleStr:SetFont("Fonts\\FRIZQT__.TTF", 20, "OUTLINE")
    titleStr:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -18)
    titleStr:SetTextColor(C.gold[1], C.gold[2], C.gold[3])
    titleStr:SetText("WeakAuras")
    f.Title = titleStr

    local subtitleStr = f:CreateFontString(nil, "OVERLAY")
    subtitleStr:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
    subtitleStr:SetPoint("BOTTOMLEFT", titleStr, "BOTTOMRIGHT", 8, 2)
    subtitleStr:SetTextColor(C.textDim[1], C.textDim[2], C.textDim[3])
    subtitleStr:SetText("|cff4B4060Wähle eine Kategorie in der linken Leiste.|r")
    f.Subtitle = subtitleStr

    local div = f:CreateTexture(nil, "OVERLAY")
    div:SetHeight(1)
    div:SetPoint("TOPLEFT",  f, "TOPLEFT",  20, -48)
    div:SetPoint("TOPRIGHT", f, "TOPRIGHT", -20, -48)
    div:SetColorTexture(C.purpleDim[1], C.purpleDim[2], C.purpleDim[3], 0.50)

    -- Category header
    local catHeader = f:CreateFontString(nil, "OVERLAY")
    catHeader:SetFont("Fonts\\FRIZQT__.TTF", 14, "OUTLINE")
    catHeader:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -58)
    catHeader:SetTextColor(C.purple[1], C.purple[2], C.purple[3])
    catHeader:SetText("")
    f.CatHeader = catHeader

    -- Scroll area
    local scroll = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT",     f, "TOPLEFT",     20, -82)
    scroll:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -20, 8)

    local scrollChild = CreateFrame("Frame", nil, scroll)
    scrollChild:SetWidth(840)
    scrollChild:SetHeight(1)
    scroll:SetScrollChild(scrollChild)
    f.ScrollChild = scrollChild

    waFrame = f
    return f
end

--------------------------------------------------
-- Refresh display for a category
--------------------------------------------------

local activeRows = {}

local function ShowCategory(catName)
    local f  = CreateWAFrame()
    local sc = f.ScrollChild

    for _, row in ipairs(activeRows) do row:Hide() end
    wipe(activeRows)
    for _, child in pairs({sc:GetChildren()}) do child:Hide() end

    local savedAuras = WeintCodex.SavedData and WeintCodex.SavedData.weakAuras
    local categoryData
    if savedAuras and savedAuras[catName] then
        categoryData = savedAuras[catName]
    else
        categoryData = defaultAuras[catName]
    end

    f.CatHeader:SetText("|cff8B5CF6" .. catName .. "|r")

    if not categoryData or #categoryData == 0 then
        local empty = sc:CreateFontString(nil, "OVERLAY")
        empty:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE")
        empty:SetPoint("TOPLEFT", sc, "TOPLEFT", 0, -10)
        empty:SetTextColor(C.textDim[1], C.textDim[2], C.textDim[3])
        empty:SetText("Keine WeakAuras in dieser Kategorie.\n\nImportiere Daten über den |cff8B5CF6Import|r-Tab.")
        sc:SetHeight(80)
        table.insert(activeRows, empty)
        return
    end

    local offsetY = -6
    for _, aura in ipairs(categoryData) do
        local row = CreateFrame("Frame", nil, sc)
        row:SetHeight(58)
        row:SetPoint("TOPLEFT",  sc, "TOPLEFT",  0, offsetY)
        row:SetPoint("TOPRIGHT", sc, "TOPRIGHT", -6, offsetY)
        SetSolidBg(row, C.bgCard[1], C.bgCard[2], C.bgCard[3], 0.70)

        -- Class color strip on left
        local cc = classColors[aura.class] or {0.50, 0.50, 0.80}
        local strip = row:CreateTexture(nil, "OVERLAY")
        strip:SetSize(3, 58)
        strip:SetPoint("LEFT", row, "LEFT", 0, 0)
        strip:SetColorTexture(cc[1], cc[2], cc[3], 0.90)

        -- Icon placeholder
        local iconBox = row:CreateTexture(nil, "ARTWORK")
        iconBox:SetSize(40, 40)
        iconBox:SetPoint("LEFT", row, "LEFT", 12, 0)
        local ic = aura.color or cc
        iconBox:SetColorTexture(ic[1] * 0.50, ic[2] * 0.50, ic[3] * 0.50, 1.0)

        local iconLetter = row:CreateFontString(nil, "OVERLAY")
        iconLetter:SetFont("Fonts\\FRIZQT__.TTF", 16, "OUTLINE")
        iconLetter:SetAllPoints(iconBox)
        iconLetter:SetJustifyH("CENTER")
        iconLetter:SetText("|cffaaaaaa✨|r")

        -- Aura name
        local nameStr = row:CreateFontString(nil, "OVERLAY")
        nameStr:SetFont("Fonts\\FRIZQT__.TTF", 13, "OUTLINE")
        nameStr:SetPoint("TOPLEFT", row, "TOPLEFT", 62, -10)
        nameStr:SetTextColor(C.textBright[1], C.textBright[2], C.textBright[3])
        nameStr:SetText(aura.name or "?")

        -- Meta: author + version
        local metaStr = row:CreateFontString(nil, "OVERLAY")
        metaStr:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
        metaStr:SetPoint("TOPLEFT", nameStr, "BOTTOMLEFT", 0, -2)
        metaStr:SetTextColor(C.textDim[1], C.textDim[2], C.textDim[3])
        metaStr:SetText("|cff3B3060von |r" .. (aura.author or "?") .. "  |cff3B3060v|r" .. (aura.version or "?"))

        -- Description
        local descStr = row:CreateFontString(nil, "OVERLAY")
        descStr:SetFont("Fonts\\FRIZQT__.TTF", 11, "")
        descStr:SetPoint("TOPLEFT", metaStr, "BOTTOMLEFT", 0, -1)
        descStr:SetTextColor(C.textDim[1], C.textDim[2], C.textDim[3])
        descStr:SetText(aura.desc or "")
        descStr:SetWidth(550)
        descStr:SetJustifyH("LEFT")

        -- Class badge
        local classBadge = row:CreateFontString(nil, "OVERLAY")
        classBadge:SetFont("Fonts\\FRIZQT__.TTF", 10, "OUTLINE")
        classBadge:SetPoint("TOPRIGHT", row, "TOPRIGHT", -8, -10)
        classBadge:SetTextColor(cc[1] * 0.80, cc[2] * 0.80, cc[3] * 0.80)
        classBadge:SetText(aura.class or "")

        table.insert(activeRows, row)
        offsetY = offsetY - 64
    end

    sc:SetHeight(math.abs(offsetY) + 20)
end

--------------------------------------------------
-- Module show
--------------------------------------------------

function WeintCodex.WeakAuras.Show()
    local cp = WeintCodex.ContentPanel
    for _, child in pairs({cp:GetChildren()}) do child:Hide() end

    local f = CreateWAFrame()
    f:Show()

    local categories = {"Klassenauren", "Raidauren", "Boss-Auren", "Utility-Auren"}

    local sidebarItems = {
        { label = "WeakAuras", isGroup = true },
    }
    for _, cat in ipairs(categories) do
        local cn = cat
        sidebarItems[#sidebarItems + 1] = {
            label   = cn,
            indent  = true,
            onClick = function() ShowCategory(cn) end,
        }
    end

    WeintCodex.Navigation.BuildSidebar("WeakAuras", sidebarItems)
    ShowCategory(categories[1])
end

function WeintCodex.WeakAuras.Refresh(data)
    if WeintCodex.SavedData then
        WeintCodex.SavedData.weakAuras = data
    end
end
