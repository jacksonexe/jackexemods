
Enabled = true
added = false
CurrentNPC = nil
Cron = require('External/Cron.lua')

function SetCarmogedden(prefix)
    TweakDB:SetFlat(prefix .. ".acceleration", 5000)
    TweakDB:SetFlat(prefix .. ".ignoreCars", true)
    TweakDB:SetFlat(prefix .. ".ignoreRules", true)
    TweakDB:SetFlat(prefix .. ".ignoreLights", true)
    TweakDB:SetFlat(prefix .. ".ignorePedestrians", true)
    TweakDB:SetFlat(prefix .. ".ignorePlayer", true)
    TweakDB:SetFlat(prefix .. ".ignoreSpeedLimitations", true)
    TweakDB:SetFlat(prefix .. ".ignoreStatics", true)
    TweakDB:SetFlat(prefix .. ".maxSpeed", 5000)
    TweakDB:SetFlat(prefix .. ".minSpeed", 3000)
    TweakDB:SetFlat(prefix .. ".surroundDistance", 0.0001)
    TweakDB:SetFlat(prefix .. ".directionSmoothFactor", 0.001)
    TweakDB:SetFlat(prefix .. ".deceleration", 5)
    TweakDB:SetFlat(prefix .. ".rotationSpeed", 5)
    TweakDB:SetFlat(prefix .. ".avoidanceReserve", 0.0001)
    TweakDB:SetFlat(prefix .. ".avoidanceReserve", 0.0001)
    TweakDB:SetFlat(prefix .. ".bumpTriggerMinSpeed", 5000)
    TweakDB:SetFlat(prefix .. ".accelerationFactor", 100)
    TweakDB:SetFlat(prefix .. ".bumpTriggerMaxDistancePlayer", 0.001)
    TweakDB:SetFlat(prefix .. ".bumpTriggerMaxDistanceNPC", 0.001)  
end

function SetCivilianmogedden(prefix)
    TweakDB:SetFlat(prefix .. ".acceleration", 25)
    TweakDB:SetFlat(prefix .. ".ignoreCars", true)
    TweakDB:SetFlat(prefix .. ".ignoreRules", true)
    TweakDB:SetFlat(prefix .. ".ignoreLights", true)
    TweakDB:SetFlat(prefix .. ".ignorePedestrians", true)
    TweakDB:SetFlat(prefix .. ".ignorePlayer", true)
    TweakDB:SetFlat(prefix .. ".ignoreSpeedLimitations", true)
    TweakDB:SetFlat(prefix .. ".ignoreStatics", true)
    TweakDB:SetFlat(prefix .. ".maxSpeed", 25)
    TweakDB:SetFlat(prefix .. ".maxSpeedTolerance", 25)
    TweakDB:SetFlat(prefix .. ".minSpeed", 25)
    TweakDB:SetFlat(prefix .. ".surroundDistance", 0.0001)
    TweakDB:SetFlat(prefix .. ".maxAnimScale", 25)
    TweakDB:SetFlat(prefix .. ".minAnimScale", 25)
    TweakDB:SetFlat(prefix .. ".directionSmoothFactor", 0.001)
end

function EnableChaos()
	player = Game.GetPlayer()
	local ssc = Game.GetScriptableSystemsContainer()
	local ts = Game.GetTransactionSystem()
	local ss = Game.GetStatsSystem()
	local es = ssc:Get(CName.new('EquipmentSystem'))
	local espd = es:GetPlayerData(player)
	TweakDB:SetFlat("AIGeneralSettings.ReactionSystem.aggressiveCiviliansLimit", 100000000)
	for _,record in ipairs(TweakDB:GetRecords("gamedataCharacter_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".value", "Hostile")
	end
	for _,record in ipairs(TweakDB:GetRecords("gamedataAttitude_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isCrowd", false)
		TweakDB:SetFlat(record:GetID() .. ".isChild", false)
	end

	TweakDB:SetFlat("Character.Crowd_NPC_Base_inline0.item", TweakDBID.new("Items.w_melee_dildo"))

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPreset_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Police_Aggressive")
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPresetCivilian_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Civilian_Guard")
		TweakDB:SetFlat(record:GetID() .. ".reactionGroup", "Police")
	end

    for _,record in ipairs(TweakDB:GetRecords("gamedataVehicleAirControlAxis_Record")) do
        if string.find(tostring(record:GetID().value), "_inline2") then
            TweakDB:SetFlat(record:GetID() .. ".angleCorrectionFactorMax", 0)
            TweakDB:SetFlat(record:GetID() .. ".angleCorrectionFactorMin", 0)
        end
	end

    for _,record in ipairs(TweakDB:GetRecords("gamedataVehicle_Record")) do
        if string.find(tostring(record:GetID().value), "Vehicle.av_") then
            TweakDB:SetFlat(record:GetID() .. ".destruction", true)
        end
	end

    for _,record in ipairs(TweakDB:GetRecords("gamedataVehicleDefaultState_Record")) do
        if string.find(tostring(record:GetID().value), "Vehicle.av_") then
            TweakDB:SetFlat(record:GetID() .. ".DisableAllInteractions", false)
            TweakDB:SetFlat(record:GetID() .. ".SpawnDestroyed", true)
        end
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataRule_Record")) do
		local workspot = TweakDB:GetFlat(record:GetID() .. ".workspotOutput")
		local output = TweakDB:GetFlat(record:GetID() .. ".output")
		if workspot.value == "Fear" then
			TweakDB:SetFlat(record:GetID() .. ".workspotOutput", "None")
		end
		if output.value == "ReactionOutput.Flee" or output.value == "ReactionOutput.Panic" then
			TweakDB:SetFlat(record:GetID() .. ".output", TweakDBID.new("ReactionOutput.Intruder"))
		end
	end        

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPresetCorpo_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Corpo_Aggressive")
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPresetGanger_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Ganger_Aggressive")
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPresetMechanical_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Mechanical_Aggressive")
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPresetNoReaction_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Police_Aggressive")
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataReactionPresetPolice_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".isAggressive", true)
		TweakDB:SetFlat(record:GetID() .. ".aggressiveThreshold", -1000)
		TweakDB:SetFlat(record:GetID() .. ".enumName", "Police_Aggressive")
		TweakDB:SetFlat(record:GetID() .. ".fearThreshold", 10000000)
	end

	for _,record in ipairs(TweakDB:GetRecords("gamedataAttitudeGroup_Record")) do
		TweakDB:SetFlat(record:GetID() .. ".defaultAttitude", "Hostile")
		--TweakDB:SetFlat(record:GetID() .. ".attitudeToSelf", "Passive")
	end
	
	SetCarmogedden("Crowds.PanicDriving")
	SetCarmogedden("Crowds.Car_Calm_Driving")
	SetCarmogedden("Crowds.Car_Sport_Driving")
	SetCarmogedden("Crowds.DefaultDriving")
	SetCarmogedden("Crowds.DrivingNormal")
	SetCarmogedden("Crowds.DrivingFast")
	SetCarmogedden("Crowds.NormalDriving")
	SetCarmogedden("Crowds.Mini_Normal_Driving")
	SetCarmogedden("Crowds.Mini_Slow_Driving")
	SetCarmogedden("Crowds.SUV_Normal_Driving")
	SetCarmogedden("Crowds.Truck_Normal_Driving")
	SetCarmogedden("Crowds.Truck_Slow_Driving")
	SetCarmogedden("Crowds.Commoners_Normal_Driving")
	SetCarmogedden("Crowds.StopDriving")
	SetCivilianmogedden("Crowds.JogMovement")
	SetCivilianmogedden("Crowds.DefaultMovement")
	SetCivilianmogedden("Crowds.ManBigCivilianWalkMovementPattern_inline0")
	SetCivilianmogedden("Crowds.ManCivilianWalkMovementPattern_inline0")
	SetCivilianmogedden("Crowds.ManHomelessWalkMovementPattern_inline0")
	SetCivilianmogedden("Crowds.RunMovement")
	SetCivilianmogedden("Crowds.StoopKingWalkMovementPattern_inline0")
	SetCivilianmogedden("Crowds.StoopQueenWalkMovementPattern_inline0")
	SetCivilianmogedden("Crowds.UmbrellaMovement")
	SetCivilianmogedden("Crowds.WomanCivilianWalkMovementPattern_inline0")
	SetCivilianmogedden("Crowds.WalkMovement")
	SetCivilianmogedden("Crowds.StopMovement")
end
Entities = {}
function SpawnCyberpsycho()
    player = Game.GetPlayer()
    Game.GetPreventionSpawnSystem():RequestDespawnPreventionLevel(-99)
    Entities = {}
    Cron.Every(0.2, {tick = 1}, function(timer)
        local i = 0
        local offset = 5
        for _,record in ipairs(TweakDB:GetRecords("gamedataCharacter_Record")) do
            local id = record:GetID();
            if string.find(tostring(id.value), "cyberpsycho") and (tostring(id.value) ~= "Character.mq030_cyberpsycho") then
                local spawnTransform = player:GetWorldTransform()
                local pos = player:GetWorldPosition()
                local heading = player:GetWorldForward()
                local angles = GetSingleton('Quaternion'):ToEulerAngles(player:GetWorldOrientation())
                local newPos = Vector4.new(pos.x + (heading.x * offset), pos.y + (heading.y * offset), pos.z - heading.z, pos.w - heading.w)
                offset = offset + 0.7
                spawnTransform:SetPosition(newPos)
                spawnTransform:SetOrientationEuler(EulerAngles.new(0, 0, angles.yaw - 180))
                local entityID = Game.GetPreventionSpawnSystem():RequestSpawn(id, -99, spawnTransform)
                Entities[i] = entityID;
                i = i + 1
            end
        end
        
        Cron.Every(0.1, {tick = 1}, function(timer2)
            set = false
            for _,entityId in ipairs(Entities) do
                local entity = Game.FindEntityByID(entityId)

                timer2.tick = timer2.tick + 1
                
                if timer2.tick > 30 then
                    Cron.Halt(timer)
                end

                if entity then
                    for _,entityId in ipairs(Entities) do
                        local entity = Game.FindEntityByID(entityId)
                        local AIC = entity:GetAIControllerComponent()
                        local targetAttAgent = entity:GetAttitudeAgent()
                        local reactionComp = entity.reactionComponent
            
                        local aiRole = NewObject('handle:AIRole')
                        aiRole:OnRoleSet(entity)
            
                        Game['senseComponent::RequestMainPresetChange;GameObjectString'](entity, "Combat")
                        AIC:GetCurrentRole():OnRoleCleared(entity)
                        AIC:SetAIRole(aiRole)
                        entity.movePolicies:Toggle(true)
                        targetAttAgent:SetAttitudeGroup(CName.new("hostile"))
                        reactionComp:SetReactionPreset(GetSingleton("gamedataTweakDBInterface"):GetReactionPresetRecord(TweakDBID.new("ReactionPresets.Ganger_Aggressive")))
                        reactionComp:TriggerCombat(player)
                        set = true
                    end
                end
            end
            if set then
                Cron.Halt(timer2)
            end
        end)
        Cron.Halt(timer)
    end)
end

function OnGround( scriptInterface )
    local geometryDescription
    local queryFilter = QueryFilter.new()
    local geometryDescriptionResult
    local currentPosition
    local distanceToGround
    local onGround = Game.GetNavigationSystem():IsOnGround(Game.GetPlayer())
    currentPosition = DefaultTransition.GetPlayerPosition( scriptInterface );
    --queryFilter = queryFilter.AddGroup( 'Static' );
    queryFilter = queryFilter.AddGroup( 'Terrain' );
    --queryFilter = queryFilter.AddGroup( 'PlayerBlocker' );
    geometryDescription = GeometryDescriptionQuery.new();
    geometryDescription.AddFlag(geometryDescription, worldgeometryDescriptionQueryFlags.DistanceVector)
    geometryDescription.filter = queryFilter;
    geometryDescription.refPosition = currentPosition;
    geometryDescription.refDirection = Vector4.new( 0.0, 0.0, -1.0, 0.0 );
    geometryDescription.primitiveDimension = Vector4.new( 0.5, 0.1, 0.1, 0.0 );
    geometryDescription.maxDistance = 100.0;
    geometryDescription.maxExtent = 100.0;
    geometryDescription.probingPrecision = 40.0;
    geometryDescription.probingMaxDistanceDiff = 100.0;
    geometryDescription.raycastStartDistance = 0
    sqs = scriptInterface:GetSpatialQueriesSystem()
    gds = sqs:GetGeometryDescriptionSystem()
    geometryDescriptionResult = gds:QueryExtents( geometryDescription );
    distanceToGround = AbsF( geometryDescriptionResult.distanceVector.z );
    if onGround then
        if(Game.GetAINavigationSystem():IsPointOnNavmesh(player, currentPosition, 0.1)) then
            print(distanceToGround)
            return distanceToGround < 2;
        else
            return distanceToGround == 0
        end
    else
        return distanceToGround == 0
    end
end

function SetWantedLevel(heat)
    print(tostring(heat))
    local prevention = GetSingleton("PreventionSystem")
    local request = PreventionConsoleInstructionRequest.new()
    if(not prevention:IsChasingPlayer()) then
        request.instruction = EPreventionSystemInstruction.Active;
        request.heatStage = heat;
        prevention:QueueRequest( request );
    end
end

function MaxWanted()
    SetWantedLevel(EPreventionHeatStage.Heat_4)
end

CopsMsg = false
function CheckCops()
    if CheckInCopBounds() then
        if not CopsMsg then
            local PlayerSystem = Game.GetPlayerSystem()
            local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
            PlayerPuppet:SetWarningMessage("Cops are no longer looking the other way.")
            CopsMsg = true
            MaxWanted()
            Cron.Every(20, {tick = 1}, function (timer)
                if CopsMsg and CheckInCopBounds() then
                    print("Reupping Wanted Level")
                    MaxWanted()
                else
                    Cron.Halt(timer)
                end
            end)
        end
    elseif CopsMsg then
        local PlayerSystem = Game.GetPlayerSystem()
        local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
        PlayerPuppet:SetWarningMessage("Boys in blue are now off getting doughnuts.")
        CopsMsg = false
        Game.PrevSys_safe()
    end
end

CurrentDistrict = nil
CurrentSubDistrict = nil
PreventSystem = nil
LavaMsg = false

function GetCurrentDistrict()
    if PreventSystem == nil then
        return
    end
    local district = PreventSystem.districtManager:GetCurrentDistrict().districtID
    local parent = TweakDB:GetFlat(district.value .. ".parentDistrict")
    if(tostring(parent.value) == "<TDBID:00000000:00>") then
        parent = district
    end
    CurrentSubDistrict = tostring(district.value)
    CurrentDistrict = tostring(parent.value)
end

function StartCourse()

        function CheckInBounds()
            GetCurrentDistrict()
            return CurrentDistrict ~= nil and (CurrentDistrict == "Districts.Watson" or CurrentDistrict == "Districts.LittleChina" or CurrentSubDistrict == "Districts.LittleChina")
        end

        function CheckInCopBounds()
            GetCurrentDistrict()
            return CurrentDistrict ~= nil and (CurrentDistrict == "Districts.CityCenter" or CurrentDistrict == "Districts.Heywood")
        end
        
        function CheckInBlindBounds()
            GetCurrentDistrict()
            return CurrentDistrict ~= nil and (CurrentDistrict == "Districts.Badlands") and CurrentSubDistrict ~= "Districts.NorthSunriseOilField"
        end

        function CheckInLavaArea()
            GetCurrentDistrict()
            return CurrentDistrict ~= nil and (CurrentDistrict == "Districts.Pacifica"  or CurrentDistrict == "Districts.Coastview")
        end


        function CheckLava()
            if CheckInLavaArea() ~= true then
                Game.RemoveEffectPlayer("BaseStatusEffect.Burning")
                if LavaMsg then
                    local PlayerSystem = Game.GetPlayerSystem()
                    local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
                    PlayerPuppet:SetWarningMessage("Floor has cooled down.")
                    LavaMsg = false
                end
                return
            end
            if not LavaMsg then
                local PlayerSystem = Game.GetPlayerSystem()
                local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
                PlayerPuppet:SetWarningMessage("Watch out floor is hot.")
                LavaMsg = true
            end
            if ScriptInterface == nil then
                return
            end
            local grd = OnGround(ScriptInterface)
            if(grd) then
                Game.ApplyEffectOnPlayer("BaseStatusEffect.Burning")
            else
                Game.RemoveEffectPlayer("BaseStatusEffect.Burning")
            end
        end
        EnableChaos()
        Blindness = false
        BlindnessMessage = false
        Cron.Every(15, {tick = 1}, function (timer)
            if(CheckInBounds()) then
                print("Spawning Psychos")
                local PlayerSystem = Game.GetPlayerSystem()
                local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
                PlayerPuppet:SetWarningMessage("Spawning Psychos.")
                SpawnCyberpsycho()
            end
        end)
        Cron.Every(30, {tick = 1}, function (timer)
            if(CheckInBlindBounds()) then
                if not BlindnessMessage then
                    local PlayerSystem = Game.GetPlayerSystem()
                    local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
                    PlayerPuppet:SetWarningMessage("Hope you don't like seeing.")
                end
                Blindness = not Blindness
                if not Blindness then
                    Game.RemoveEffectPlayer("BaseStatusEffect.JohnnySicknessHeavy")
                    Game.RemoveEffectPlayer("BaseStatusEffect.NetwatcherGeneral")
                else
                    Game.ApplyEffectOnPlayer("BaseStatusEffect.JohnnySicknessHeavy")
                    Game.ApplyEffectOnPlayer("BaseStatusEffect.NetwatcherGeneral")
                end
            elseif BlindnessMessage then
                local PlayerSystem = Game.GetPlayerSystem()
                local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
                PlayerPuppet:SetWarningMessage("Alright here are your eyes back.")
                BlindnessMessage = false
            end
        end)
        Observe("ScriptedPuppet", "OnTakeControl", function(evt, evt2)
            local player = Game.GetPlayer()
            local entityID = evt:GetEntityID()
            if entityID ~= nil then
                Cron.Every(0.1, {tick = 1}, function(timer)
                    local entity = Game.FindEntityByID(entityID)
            
                    timer.tick = timer.tick + 1
                    
                    if timer.tick > 30 then
                        Cron.Halt(timer)
                    end
            
                    if entity then
                        entity.isPlayerCompanionCached = false
                        entity.isPlayerCompanionCachedTimeStamp = 0
                        Game['senseComponent::RequestMainPresetChange;GameObjectString'](entity, "Combat")
                        if entity.movePolicies ~= nil then
                            entity.movePolicies:Toggle(true)
                        end
                        local AIC = entity:GetAIControllerComponent()
                        if(AIC ~= nil and AIC:GetCurrentRole() ~= nil) then
                            AIC:GetCurrentRole():OnRoleCleared(entity)
                            AIC:SetAIRole(aiRole)
                        end
                        local targetAttAgent = entity:GetAttitudeAgent()
                        if(targetAttAgent ~= nil) then
                            targetAttAgent:SetAttitudeGroup(CName.new("hostile"))
                        end
                        local reactionComp = entity.reactionComponent
                        if reactionComp ~= nil then
                            reactionComp:SetReactionPreset(GetSingleton("gamedataTweakDBInterface"):GetReactionPresetRecord(TweakDBID.new("ReactionPresets.Ganger_Aggressive")))
                            reactionComp:TriggerCombat(player)
                        end
                        Cron.Halt(timer)
                    end
                end)
            end
        end)
        Observe("LocomotionEventsTransition", "OnEnter", function(evt, stateContext, scriptInterface)
            ScriptInterface = scriptInterface
        end)
        Observe("LocomotionEventsTransition", "OnExit", function(evt, stateContext, scriptInterface)
            ScriptInterface = scriptInterface
        end)

end
StartChaos = false
Init = false
StartLava = false
if Enabled then
    registerHotkey("chaos_start_engine", "Start Chaos Engine", function()
        StartChaos = true
        print("Starting Chaos")
        local PlayerSystem = Game.GetPlayerSystem()
		local PlayerPuppet = PlayerSystem:GetLocalPlayerMainGameObject()
        PlayerPuppet:SetWarningMessage("Chaos has been enabled. Please keep all hands and feet in the ride at all times.")
    end)
    registerHotkey("chaos_toggle_lava", "Toggle Lava", function()
        StartLava = not StartLava
        if StartLava == false then
            Game.RemoveEffectPlayer("BaseStatusEffect.OutOfOxygen")
        end
        print("Toggle Lava")
    end)
    registerForEvent("onInit", function()
        Observe("PreventionSystem", "OnDistrictAreaEntered", function(evt, dev)
            PreventSystem = evt
        end)
    end)
    registerForEvent('onUpdate', function(delta)
        Cron.Update(delta)
        if StartChaos and Init == false then
            StartCourse()
            Init = true
        end
        if StartLava and Init == true then
            CheckLava()
        end
        if Init then
            CheckCops()
        end
    end)
end