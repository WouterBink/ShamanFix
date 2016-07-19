local time = GetTime();
local f = CreateFrame("Frame", nil, UIParent);
f:SetScript("OnUpdate", function()
  if GetTime() - time > 1 then
    f:SetScript("OnUpdate", nil);
    print("Shamans fixed!");
    RAID_CLASS_COLORS["SHAMAN"].r = 0.0;
    RAID_CLASS_COLORS["SHAMAN"].g = 0.44;
    RAID_CLASS_COLORS["SHAMAN"].b = 0.87;
  end
end)

function tsh()
    local tc = RAID_CLASS_COLORS["SHAMAN"];
    DEFAULT_CHAT_FRAME:AddMessage("Shaman", tc.r, tc.g, tc.b);
end