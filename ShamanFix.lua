local _G = getfenv(0) -- this should improve lookup speed

-- Fix shaman colors.
_G.RAID_CLASS_COLORS["SHAMAN"] = { r = 0, g = 0.44, b = 0.87}

-- Reapply the fix 1 sec after loading.
-- TODO make this less hacky.
local time = GetTime();
local f = CreateFrame("Frame", nil, UIParent);

-- Table of hexadecimal values of class colors.
local ClassColorsHex = {}
for k,v in _G.RAID_CLASS_COLORS do
	ClassColorsHex[k] = string.format("%2x%2x%2x", v.r*255, v.g*255, v.b*255)
end

-- Just to be sure.
ClassColorsHex["SHAMAN"] = "0070de";

function ShamanFix_FixShamanColor()
	_G.RAID_CLASS_COLORS["SHAMAN"] = { r = 0, g = 0.44, b = 0.87}
		
	-- Hack for WIM.
	_G.WIM_ClassColors[WIM_LOCALIZED_SHAMAN] = "0070de";
	
	-- Hack for TinyTip.
	-- Tinytip doesn't expose its hex color table so instead we override its ColorPlayer function.
	TinyTip_ColorPlayer = ShamanFix_ColorPlayer;
end

f:SetScript("OnUpdate", function()
  if GetTime() - time > 1 then
    f:SetScript("OnUpdate", nil);
	ShamanFix_FixShamanColor();
	print("Shamans fixed!");
  end
end)

f:SetScript("OnLoad", function()
   f:RegisterEvent("PLAYER_ENTERING_WORLD");
end)

f:SetScript("OnEvent", function()
   if (event == "PLAYER_ENTERING_WORLD") then
      ShamanFix_FixShamanColor();
   end     
end)

-- Tinytip replacement function.
function ShamanFix_ColorPlayer(unit)
	_,tmp=_G.UnitClass(unit)
	if tmp and ClassColorsHex[tmp] then
		return ClassColorsHex[tmp]
	else
		return "FFFFFF"
	end
end

