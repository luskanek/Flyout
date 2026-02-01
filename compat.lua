local _G = getfenv(0)

-- upvalues
local IsAddOnLoaded = IsAddOnLoaded

local mod = math.mod

-- Bongos
local function GetActionButton_Bongos(action)
    return _G['BActionButton' .. action]
end

-- pfUI
local function GetActionButton_PF(action)
    local bar = nil

    if action < 25 then
        bar = 'pfActionBarMain'
    elseif action < 37 then
        bar = 'pfActionBarRight'
    elseif action < 49 then
        bar = 'pfActionBarVertical'
    elseif action < 61 then
        bar = 'pfActionBarLeft'
    elseif action < 73 then
        bar = 'pfActionBarTop'
    elseif action < 85 then
        bar = 'pfActionBarStanceBar1'
    elseif action < 97 then
        bar = 'pfActionBarStanceBar2'
    elseif action < 109 then
        bar = 'pfActionBarStanceBar3'
    elseif action < 121 then
        bar = 'pfActionBarStanceBar4'
    else
        bar = 'pfActionBarMain'
    end

    local i = 1
    if mod(action, 12) ~= 0 then
        i = mod(action, 12)
    else
        i = 12
    end

    return _G[bar .. 'Button' .. i]
end

-- Dragonflight3
local function GetActionButton_Dragonflight3(action)
    local bar, index

    if action >= 1 and action <= 12 then
        bar = 'DF_MainBar'
        index = action

    elseif action >= 13 and action <= 24 then
        bar = 'DF_MultiBar5'
        index = action - 12

    elseif action >= 25 and action <= 36 then
        bar = 'DF_MultiBar4'
        index = action - 24

    elseif action >= 37 and action <= 48 then
        bar = 'DF_MultiBar3'
        index = action - 36

    elseif action >= 49 and action <= 60 then
        bar = 'DF_MultiBar2'
        index = action - 48

    elseif action >= 61 and action <= 72 then
        bar = 'DF_MultiBar1'
        index = action - 60

    elseif action >= 133 and action <= 142 then
        bar = 'DF_PetBar'
        index = action - 132

    elseif action >= 200 and action <= 209 then
        bar = 'DF_StanceBar'
        index = action - 199
    end

    if bar and index then
        return _G[bar .. 'Button' .. index]
    end
end


local function HandleEvent()
    if IsAddOnLoaded('Bongos') and IsAddOnLoaded('Bongos_ActionBar') then
        Flyout_GetActionButton = GetActionButton_Bongos
    end

    if IsAddOnLoaded('pfUI') then
        Flyout_GetActionButton = GetActionButton_PF
    end
	
	if IsAddOnLoaded('-Dragonflight3') then
		Flyout_GetActionButton = GetActionButton_Dragonflight3
	end
end

-- override original functions
local handler = CreateFrame('Frame')
handler:RegisterEvent('VARIABLES_LOADED')
handler:SetScript('OnEvent', HandleEvent)
