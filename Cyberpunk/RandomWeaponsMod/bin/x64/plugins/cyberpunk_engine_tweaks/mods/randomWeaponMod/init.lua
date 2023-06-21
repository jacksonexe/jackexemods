-- see if the file exists
function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
  end
  
  -- get all lines from a file, returns an empty 
  -- list/table if the file does not exist
  function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
  end
  
function RemoveAllWeapons()
    local player = Game.GetPlayer()
    local ssc = Game.GetScriptableSystemsContainer()
    local ts = Game.GetTransactionSystem()
    local es = ssc:Get(CName.new('EquipmentSystem'))
    local espd = es:GetPlayerData(player)
    espd['GetItemInEquipSlot2'] = espd['GetItemInEquipSlot;gamedataEquipmentAreaInt32']
    local slots = {
        Weapon = 3
    }
    
    for k,v in pairs(slots) do
        for i=1,v do
            local itemid = espd:GetItemInEquipSlot2(k, i - 1)
            if itemid.id.hash ~= 0 then 
                ts:RemoveItem(player, itemid, 1)
            end
        end
    end
end

registerForEvent("onInit", function()
    local file = 'weapons.txt'
    local lines = lines_from(file)
    local allweapons = {}
    local numWeapons = 0
    for _,record in ipairs(TweakDB:GetRecords("gamedataCharacter_Record")) do
        TweakDB:SetFlat(record:GetID() .. ".dropsWeaponOnDeath", false)
    end
    for _,record in ipairs(TweakDB:GetRecords("gamedataLootItem_Record")) do
        local id = TweakDB:GetFlat(record:GetID() .. ".itemID")
        local rec = TweakDB:GetRecord(id)
        if rec.Ammo ~= nil then
            TweakDB:SetFlat(record:GetID() .. ".dropCountMax", 0)
            TweakDB:SetFlat(record:GetID() .. ".dropCountMin", 0)
            TweakDB:SetFlat(record:GetID() .. ".dropChance", 0)
        end
    end
    for _,record in ipairs(TweakDB:GetRecords("gamedataVendor_Record")) do
        local ids = TweakDB:GetFlat(record:GetID() .. ".vendorFilterTags")
        table.insert(ids, "Weapon")
        TweakDB:SetFlat(record:GetID() .. ".vendorFilterTags", ids)
    end
    print("Getting Weapon Data")
    for _,record in ipairs(lines) do
        allweapons[numWeapons] = record
        numWeapons = numWeapons + 1
    end
    print(tostring(numWeapons))
    Observe("PlayerPuppet", "OnWeaponEquipEvent", function(evt, evt2)
        print(GameDump(evt2.Item))
        local player = Game.GetPlayer()
        local ssc = Game.GetScriptableSystemsContainer()
        local ts = Game.GetTransactionSystem()
        local ss = Game.GetStatsSystem()
        local es = ssc:Get(CName.new('EquipmentSystem'))
        local espd = es:GetPlayerData(player)
        espd['GetItemInEquipSlot2'] = espd['GetItemInEquipSlot;gamedataEquipmentAreaInt32']
        local slots = {
            Weapon = 3
        }
        
        for k,v in pairs(slots) do
            for i=1,v do
                local itemid = espd:GetItemInEquipSlot2(k, i - 1)
                if itemid.id.hash ~= 0 then 
                    local itemdata = ts:GetItemData(player, itemid)
                    local playerPLValue = ss:GetStatValue(player:GetEntityID(), 'PowerLevel')
                    local statObj = itemdata:GetStatsObjectID()
                    local itemLevel = ss:GetStatValue(statObj, 'ItemLevel')
                    local powerLevel = ss:GetStatValue(statObj, 'PowerLevel')
                    local addItemLevel = 0
                    if itemLevel < math.floor(playerPLValue) * 10 then
                        print(tostring(itemid))
                        addItemLevel = math.floor(playerPLValue - powerLevel) * 10 + 20
                        print(tostring(itemLevel))
                        print(tostring(addItemLevel))
                        local levelMod = Game['gameRPGManager::CreateStatModifier;gamedataStatTypegameStatModifierTypeFloat']('ItemLevel', 'Additive', addItemLevel)
                        ss:AddSavedModifier(statObj, levelMod)
                    end
                end
            end
        end
    end)
    UpdatingEquipment = false
    Observe('ScriptedPuppet', "OnDeath", function (evt, deathEvent)
        if(deathEvent.instigator:IsPlayer()) then
            RemoveAllWeapons()
            local randIndex = math.random(0, numWeapons)
            local item = allweapons[randIndex]
            print(item)
            Game.EquipItemToHand(item)
        end
    end)
    Observe('ScriptedPuppet', "OnKillRewardEvent", function (evt, killReward)
        if(killReward.killType == gameKillType.Defeat) then
            local randIndex = math.random(0, numWeapons)
            local item = allweapons[randIndex]
            RemoveAllWeapons()
            print(item)
            Game.EquipItemToHand(item)
            
        end
    end)

end)