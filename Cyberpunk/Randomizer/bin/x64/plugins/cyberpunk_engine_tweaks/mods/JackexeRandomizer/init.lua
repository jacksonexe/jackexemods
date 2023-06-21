--Created by Jackexe
--Any code modification is allowed provided attribution is given
Cron = require('External/Cron.lua')

function FileExists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end

function ReadFile()

end
IsRandom = false
RandomizedCharacters = {}
function RevertRandom()
    print("Reverting Randomization")
    for _,record in ipairs(RandomizedCharacters) do
        local id = record["id"]
        local adam = record
        if(not string.find(tostring(id.value), "Player") and (not string.find(tostring(id.value), "Sandra") or not string.find(tostring(id.value), "sandra")) and not string.find(tostring(id.value), "Jackie") and not string.find(tostring(id.value), "jackie")) then
            TweakDB:SetFlat(record:GetID() .. ".abilites", adam["abilites"])
            TweakDB:SetFlat(record:GetID() .. ".actionMap", adam["actionMap"])
            TweakDB:SetFlat(record:GetID() .. ".archetypeName", adam["archetypeName"])
            TweakDB:SetFlat(record:GetID() .. ".baseAttitudeGroup", adam["baseAttitudeGroup"])
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
            TweakDB:SetFlat(record:GetID() .. ".rarity", adam["rarity"])
            TweakDB:SetFlat(record:GetID() .. ".reactionPreset", adam["reactionPreset"])
            TweakDB:SetFlat(record:GetID() .. ".statModifierGroups", adam["statModifierGroups"])
            TweakDB:SetFlat(record:GetID() .. ".voiceTag", adam["voiceTag"])
            TweakDB:SetFlat(record:GetID() .. ".weakspots", adam["weakspots"])
            TweakDB:SetFlat(record:GetID() .. ".EquipmentAreas", adam["EquipmentAreas"])
            --TweakDB:SetFlat(record:GetID() .. ".affiliation", adam["affiliation"])
            TweakDB:SetFlat(record:GetID() .. ".archetypeData", adam["archetypeData"])
            TweakDB:SetFlat(record:GetID() .. ".attachmentSlots", adam["attachmentSlots"])
            --TweakDB:SetFlat(record:GetID() .. ".isChild", adam["isChild"])
            --TweakDB:SetFlat(record:GetID() .. ".isCrowd", adam["isCrowd"])
            --TweakDB:SetFlat(record:GetID() .. ".isLightCrowd", adam["isLightCrowd"])
            TweakDB:SetFlat(record:GetID() .. ".objectActions", adam["objectActions"])
            TweakDB:SetFlat(record:GetID() .. ".scannerModulePreset", adam["scannerModulePreset"])
            TweakDB:SetFlat(record:GetID() .. ".statPools", adam["statPools"])
            TweakDB:SetFlat(record:GetID() .. ".statModifiers", adam["statModifiers"])
            TweakDB:SetFlat(record:GetID() .. ".threatTrackingPreset", adam["threatTrackingPreset"])
            TweakDB:SetFlat(record:GetID() .. ".secondaryEquipment", adam["secondaryEquipment"])
            TweakDB:SetFlat(record:GetID() .. ".primaryEquipment", adam["primaryEquipment"])
            TweakDB:SetFlat(record:GetID() .. ".lootDrop", adam["lootDrop"])
            TweakDB:SetFlat(record:GetID() .. ".lootBagEntity", adam["lootBagEntity"])
            TweakDB:SetFlat(record:GetID() .. ".items", adam["items"])
            TweakDB:SetFlat(record:GetID() .. ".itemGroups", adam["itemGroups"])
            TweakDB:SetFlat(record:GetID() .. ".dropsAmmoOnDeath", adam["dropsAmmoOnDeath"])
            TweakDB:SetFlat(record:GetID() .. ".dropsMoneyOnDeath", adam["dropsMoneyOnDeath"])
            TweakDB:SetFlat(record:GetID() .. ".dropsWeaponOnDeath", adam["dropsWeaponOnDeath"])
            TweakDB:SetFlat(record:GetID() .. ".defaultEquipment", adam["defaultEquipment"])
        elseif string.find(tostring(id.value), "Jackie") or string.find(tostring(id.value), "jackie") then
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
        elseif string.find(tostring(id.value), "Johnny") or string.find(tostring(id.value), "johnny") then
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
        elseif (string.find(tostring(id.value), "Player")) then
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
        end
    end
end

function GenerateFile()
    --local character = "Character.main_boss_adam_smasher"
    --local adam = TweakDB:GetRecord(character)
    local allCharacters = TweakDB:GetRecords("gamedataCharacter_Record")
    RandomizedCharacters = {}
    local characterData = {}
    local count = 0
    for _,record in ipairs(allCharacters) do
        local character = {}
        character["abilites"] = TweakDB:GetFlat(record:GetID() .. ".abilites")
        character["actionMap"] = TweakDB:GetFlat(record:GetID() .. ".actionMap")
        character["archetypeName"] =  TweakDB:GetFlat(record:GetID() .. ".archetypeName")
        character["baseAttitudeGroup"] =  TweakDB:GetFlat(record:GetID() .. ".baseAttitudeGroup")
        character["entityTemplatePath"] =  TweakDB:GetFlat(record:GetID() .. ".entityTemplatePath")
        character["rarity"] =  TweakDB:GetFlat(record:GetID() .. ".rarity")
        character["reactionPreset"] =  TweakDB:GetFlat(record:GetID() .. ".reactionPreset")
        character["statModifierGroups"] =  TweakDB:GetFlat(record:GetID() .. ".statModifierGroups")
        character["voiceTag"] = TweakDB:GetFlat(record:GetID() .. ".voiceTag")
        character["weakspots"] =  TweakDB:GetFlat(record:GetID() .. ".weakspots")
        character["EquipmentAreas"] = TweakDB:GetFlat(record:GetID() .. ".EquipmentAreas")
        --character["affiliation"] =  TweakDB:GetFlat(record:GetID() .. ".affiliation")
        character["archetypeData"] = TweakDB:GetFlat(record:GetID() .. ".archetypeData")
        character["attachmentSlots"] = TweakDB:GetFlat(record:GetID() .. ".attachmentSlots")
        --character["isChild", TweakDB:GetFlat(record:GetID() .. ".isChild")
        --character["isCrowd", TweakDB:GetFlat(record:GetID() .. ".isCrowd")
        --character["isLightCrowd", TweakDB:GetFlat(record:GetID() .. ".isLightCrowd")
        character["objectActions"] = TweakDB:GetFlat(record:GetID() .. ".objectActions")
        character["scannerModulePreset"] = TweakDB:GetFlat(record:GetID() .. ".scannerModulePreset")
        character["statPools"] = TweakDB:GetFlat(record:GetID() .. ".statPools")
        character["statModifiers"] = TweakDB:GetFlat(record:GetID() .. ".statModifiers")
        character["threatTrackingPreset"] = TweakDB:GetFlat(record:GetID() .. ".threatTrackingPreset")
        character["secondaryEquipment"] = TweakDB:GetFlat(record:GetID() .. ".secondaryEquipment").value
        character["primaryEquipment"] = TweakDB:GetFlat(record:GetID() .. ".primaryEquipment").value
        character["lootDrop"] = TweakDB:GetFlat(record:GetID() .. ".lootDrop")
        character["lootBagEntity"] = TweakDB:GetFlat(record:GetID() .. ".lootBagEntity")
        character["items"] = TweakDB:GetFlat(record:GetID() .. ".items")
        character["itemGroups"] = TweakDB:GetFlat(record:GetID() .. ".itemGroups")
        character["dropsAmmoOnDeath"] = TweakDB:GetFlat(record:GetID() .. ".dropsAmmoOnDeath")
        character["dropsMoneyOnDeath"] = TweakDB:GetFlat(record:GetID() .. ".dropsMoneyOnDeath")
        character["dropsWeaponOnDeath"] = TweakDB:GetFlat(record:GetID() .. ".dropsWeaponOnDeath")
        character["defaultEquipment"] = TweakDB:GetFlat(record:GetID() .. ".defaultEquipment").value
        character["id"] = record:GetID()
        characterData[count] = character
        count = count + 1
    end
    local keyset = {}
    for k in pairs(characterData) do
        table.insert(keyset, k)
    end
    local totalChar = 0
    for _,record in ipairs(allCharacters) do
        local id = record:GetID();
        local adam = characterData[keyset[math.random(#keyset)]]
        local original = nil
        for _,rec in ipairs(characterData) do
            if rec["id"].value == id.value then
                original = rec
                break
            end
        end
        if original ~= nil then
            RandomizedCharacters[totalChar] = original
            totalChar = totalChar + 1
        end
        if(not string.find(tostring(id.value), "Player") and (not string.find(tostring(id.value), "Sandra") or not string.find(tostring(id.value), "sandra")) and not string.find(tostring(id.value), "Jackie") and not string.find(tostring(id.value), "jackie")) then
            TweakDB:SetFlat(record:GetID() .. ".abilites", adam["abilites"])
            TweakDB:SetFlat(record:GetID() .. ".actionMap", adam["actionMap"])
            TweakDB:SetFlat(record:GetID() .. ".archetypeName", adam["archetypeName"])
            TweakDB:SetFlat(record:GetID() .. ".baseAttitudeGroup", adam["baseAttitudeGroup"])
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
            TweakDB:SetFlat(record:GetID() .. ".rarity", adam["rarity"])
            TweakDB:SetFlat(record:GetID() .. ".reactionPreset", adam["reactionPreset"])
            TweakDB:SetFlat(record:GetID() .. ".statModifierGroups", adam["statModifierGroups"])
            TweakDB:SetFlat(record:GetID() .. ".voiceTag", adam["voiceTag"])
            TweakDB:SetFlat(record:GetID() .. ".weakspots", adam["weakspots"])
            TweakDB:SetFlat(record:GetID() .. ".EquipmentAreas", adam["EquipmentAreas"])
            --TweakDB:SetFlat(record:GetID() .. ".affiliation", adam["affiliation"])
            TweakDB:SetFlat(record:GetID() .. ".archetypeData", adam["archetypeData"])
            TweakDB:SetFlat(record:GetID() .. ".attachmentSlots", adam["attachmentSlots"])
            --TweakDB:SetFlat(record:GetID() .. ".isChild", adam["isChild"])
            --TweakDB:SetFlat(record:GetID() .. ".isCrowd", adam["isCrowd"])
            --TweakDB:SetFlat(record:GetID() .. ".isLightCrowd", adam["isLightCrowd"])
            TweakDB:SetFlat(record:GetID() .. ".objectActions", adam["objectActions"])
            TweakDB:SetFlat(record:GetID() .. ".scannerModulePreset", adam["scannerModulePreset"])
            TweakDB:SetFlat(record:GetID() .. ".statPools", adam["statPools"])
            TweakDB:SetFlat(record:GetID() .. ".statModifiers", adam["statModifiers"])
            TweakDB:SetFlat(record:GetID() .. ".threatTrackingPreset", adam["threatTrackingPreset"])
            TweakDB:SetFlat(record:GetID() .. ".secondaryEquipment", adam["secondaryEquipment"])
            TweakDB:SetFlat(record:GetID() .. ".primaryEquipment", adam["primaryEquipment"])
            TweakDB:SetFlat(record:GetID() .. ".lootDrop", adam["lootDrop"])
            TweakDB:SetFlat(record:GetID() .. ".lootBagEntity", adam["lootBagEntity"])
            TweakDB:SetFlat(record:GetID() .. ".items", adam["items"])
            TweakDB:SetFlat(record:GetID() .. ".itemGroups", adam["itemGroups"])
            TweakDB:SetFlat(record:GetID() .. ".dropsAmmoOnDeath", adam["dropsAmmoOnDeath"])
            TweakDB:SetFlat(record:GetID() .. ".dropsMoneyOnDeath", adam["dropsMoneyOnDeath"])
            TweakDB:SetFlat(record:GetID() .. ".dropsWeaponOnDeath", adam["dropsWeaponOnDeath"])
            TweakDB:SetFlat(record:GetID() .. ".defaultEquipment", adam["defaultEquipment"])
        elseif string.find(tostring(id.value), "Jackie") or string.find(tostring(id.value), "jackie") then
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
        elseif string.find(tostring(id.value), "Johnny") or string.find(tostring(id.value), "johnny") then
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
        elseif (string.find(tostring(id.value), "Player")) then
            TweakDB:SetFlat(record:GetID() .. ".entityTemplatePath", adam["entityTemplatePath"])
        end
    end
    local lootCount = 0
    local allLoot = TweakDB:GetRecords("gamedataLootItem_Record")
    local lootData = {}
    for _,record in ipairs(allLoot) do
        local loot = {}
        local id = record:GetID()
        if not string.find(tostring(id.value), "Shard") then
            loot["dropChance"] = TweakDB:GetFlat(id .. ".dropChance")
            loot["dropCountMax"] = TweakDB:GetFlat(id .. ".dropCountMax")
            loot["dropCountMin"] =  TweakDB:GetFlat(id .. ".dropCountMin")
            loot["playerPrereqID"] =  TweakDB:GetFlat(id .. ".playerPrereqID").value
            loot["itemID"] =  TweakDB:GetFlat(id .. ".itemID").value
            loot["statModifiers"] =  TweakDB:GetFlat(id .. ".statModifiers")
            lootData[lootCount] = loot
            lootCount = lootCount + 1
        end
    end
    local lootkeyset = {}
    for k in pairs(lootData) do
        table.insert(lootkeyset, k)
    end
    for _,record in ipairs(allLoot) do
        local id = record:GetID();
        local loot = lootData[lootkeyset[math.random(#lootkeyset)]]
        if not string.find(tostring(id.value), "Shard") then
            TweakDB:SetFlat(id .. ".dropChance", loot["dropChance"])
            TweakDB:SetFlat(id .. ".dropCountMax", loot["dropCountMax"])
            TweakDB:SetFlat(id .. ".dropCountMin", loot["dropCountMin"])
            --TweakDB:SetFlat(id .. ".playerPrereqID", loot["playerPrereqID"])
            TweakDB:SetFlat(id .. ".itemID", loot["itemID"])
            TweakDB:SetFlat(id .. ".statModifiers", loot["statModifiers"])
        end
    end

    local vendorCount = 0
    local allVendorItems = TweakDB:GetRecords("gamedataVendorItem_Record")
    local vendorData = {}
    for _,record in ipairs(allVendorItems) do
        local item = {}
        local id = record:GetID()
        if(id.value ~= "Vendors.BaseMoney") then
            --item["availabilityPrereq"] = TweakDB:GetFlat(id .. ".availabilityPrereq")
            item["forceQuality"] = TweakDB:GetFlat(id .. ".forceQuality")
            item["generationPrereqs"] = TweakDB:GetFlat(id .. ".generationPrereqs")
            item["item"] = TweakDB:GetFlat(id .. ".item").value
            item["quantity"] = TweakDB:GetFlat(id .. ".quantity")
            vendorData[vendorCount] =  item
            vendorCount = vendorCount + 1
        end
    end
    local vendorkeyset = {}
    for k in pairs(vendorData) do
        table.insert(vendorkeyset, k)
    end
    for _,record in ipairs(allVendorItems) do
        local id = record:GetID();
        local item = vendorData[vendorkeyset[math.random(#vendorkeyset)]]
        if(id.value ~= "Vendors.BaseMoney") then
            TweakDB:SetFlat(record:GetID() .. ".dropChance", item["dropChance"])
            TweakDB:SetFlat(record:GetID() .. ".forceQuality", item["forceQuality"])
            TweakDB:SetFlat(record:GetID() .. ".generationPrereqs", item["generationPrereqs"])
            TweakDB:SetFlat(record:GetID() .. ".item", item["item"])
            TweakDB:SetFlat(record:GetID() .. ".quantity", item["quantity"])
        end
    end
end

Enabled = false
added = false
Smashes = {}
seed = 1000
if Enabled then
    registerForEvent("onInit", function()
        IsRandom = true
        math.randomseed(seed)
        GenerateFile()
        --[[ Observe("ScriptedPuppet", "OnTakeControl", function(evt, evt2)
            local entityID = evt:GetEntityID()
            local id = evt:GetRecordID()
            if entityID ~= nil and id ~= nil and id.value ~= "Character.main_boss_adam_smasher" then
                local set = false
                Cron.Every(0.1, {tick = 1}, function(timer2)
                    local entity = Game.FindEntityByID(entityID)
                    timer2.tick = timer2.tick + 1
                    
                    if timer2.tick > 30 then
                        Cron.Halt(timer2)
                    end
                    
                    if entity then
                        local spawnTransform = evt:GetWorldTransform()
                        local pos = evt:GetWorldPosition()
                        local angles = GetSingleton('Quaternion'):ToEulerAngles(evt:GetWorldOrientation())
                        spawnTransform:SetPosition(pos)
                        spawnTransform:SetOrientationEuler(angles)
                        local ent = Game.GetPreventionSpawnSystem():RequestSpawn("Character.main_boss_adam_smasher", -99, spawnTransform)
                        Game.GetPreventionSpawnSystem():RequestDespawn(entityID)
                        set = true
                    end
                    if set then
                        Cron.Halt(timer2)
                    end
                end)
            end
        end) ]]
    end)
    registerForEvent('onUpdate', function(delta)
        Cron.Update(delta)
        --[[ if(Game.DbgBraindanceIsActive() and IsRandom) then
            IsRandom = false
            RevertRandom()
        elseif not IsRandom then
            IsRandom = true
            math.randomseed(seed)
            GenerateFile()
        end ]]
        
    end)
end
