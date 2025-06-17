-- Change to values corresponding to your setup
local WingClip = 47
local AutoShot = 48

function Egnar_OnLoad()
  Egnar_Frame:Hide()
  _, cl = UnitClass("player")
  if cl ~= "HUNTER" then
    DEFAULT_CHAT_FRAME:AddMessage("Egnar is only for hunters")
    return
  end
  FontString1:SetTextColor(1, 1, 1)

  this:RegisterEvent("PLAYER_TARGET_CHANGED")
  this:RegisterEvent("UNIT_FACTION")

  this:SetScript("OnEvent", Egnar_OnEvent)
  this:SetScript("OnUpdate", Egnar_OnUpdate)

  this:RegisterForDrag("LeftButton")
  this:SetScript("OnDragStart", function()
    this:StartMoving()
  end)
  this:SetScript("OnDragStop", function()
    this:StopMovingOrSizing()
  end)

  DEFAULT_CHAT_FRAME:AddMessage("Egnar Loaded")
end

function SetColor(r, g, b, a)
  Egnar_Frame:SetBackdropColor(r, g, b, a)
  Egnar_Frame:SetBackdropBorderColor(r, g, b, a)
end

function Egnar_OnUpdate()
  if IsActionInRange(WingClip) == 1 then
    FontString1:SetText("MELEE")
    SetColor(unpack({0.9, 0.9, 0, 1})) -- YELLOW COLOR 
  elseif IsActionInRange(AutoShot) == 1 then
    if CheckInteractDistance("target", 4) then
      FontString1:SetText("IN RANGE")
      SetColor(unpack({0.6, 1, 0.5, 1})) -- GREEN COLOR
    else
      FontString1:SetText("LONG RANGE")
      SetColor(unpack({0.6, 1, 0.5, 1})) -- GREEN COLOR
    end
  elseif CheckInteractDistance("target", 4) then
    FontString1:SetText("DEAD ZONE")
    SetColor(unpack({0.9, 0, 0.1, 1})) -- RED COLOR
  else
    FontString1:SetText("OUT OF RANGE")
    SetColor(unpack({0.9, 0, 0.1, 1})) -- RED COLOR
  end
end

function Egnar_OnEvent()
  if(UnitExists("target") and (not UnitIsDead("target")) and UnitCanAttack("player", "target")) then
    Egnar_Frame:Show()
  else
    Egnar_Frame:Hide()
  end
end
