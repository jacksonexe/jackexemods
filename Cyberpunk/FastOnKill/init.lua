
Enabled = true
TimeScale = 1

function FileExists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
  end
  
function GetTimeScale(file)
    if not FileExists(file) then return {} end
    for line in io.lines(file) do 
        TimeScale = tonumber(line)
    end
end

function SaveTimeScale()
    print("Scale: "..tostring(TimeScale))
    local file,err = io.open("scale.txt",'w')
    if file then
        file:write(tostring(TimeScale))
        file:close()
    else
        print("error:", err)
    end
end

Amount = 0.003
if Enabled then
    registerHotkey("show_time", "Show Time Dilation", function()
        local PlayerSystem = Game.GetPlayerSystem()
        local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
        PlayerPuppet:SetWarningMessage("Currently Time is moving " .. tostring(TimeScale) .. "X faster than normal.")
    end)
    registerForEvent("onInit", function()
        Observe('PlayerPuppet', "OnTakeControl", function()
            GetTimeScale("scale.txt")
            Game.GetTimeSystem():SetTimeDilation("", TimeScale)
            Game.GetTimeSystem():SetTimeDilationOnLocalPlayerZero("", TimeScale)
        end)
        Observe('ScriptedPuppet', "OnDeath", function (evt, deathEvent)
            GetTimeScale("scale.txt")
            TimeScale = TimeScale + Amount
            Game.GetTimeSystem():SetTimeDilation("", TimeScale)
            Game.GetTimeSystem():SetTimeDilationOnLocalPlayerZero("", TimeScale)
            SaveTimeScale()
        end)
        Observe('ScriptedPuppet', "OnKillRewardEvent", function (evt, killReward)
            if(killReward.killType == gameKillType.Defeat) then
                GetTimeScale("scale.txt")
                TimeScale = TimeScale + Amount
                Game.GetTimeSystem():SetTimeDilation("", TimeScale) 
                Game.GetTimeSystem():SetTimeDilationOnLocalPlayerZero("", TimeScale)
                SaveTimeScale()
            end
        end)
    end)
end