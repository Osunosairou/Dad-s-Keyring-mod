local kringMod = RegisterMod("Dad's Keyring", 1)
local game = Game()
local room = Game():GetRoom()
local kringId = Isaac.GetItemIdByName("Dad's Keyring")
local hasKRing = false
local keyQtd = 0
local usedKeys = 0
local keys = {
    storeKey = TrinketType.TRINKET_STORE_KEY,
    rustedKey = TrinketType.TRINKET_RUSTED_KEY,
    gildedKey = TrinketType.TRINKET_GILDED_KEY,
    blueKey = TrinketType.TRINKET_BLUE_KEY,
    strangeKey = TrinketType.TRINKET_STRANGE_KEY,
    crystalKey = TrinketType.TRINKET_CRYSTAL_KEY
}
local checkKey = {
    gotStoreKey = false,
    gotRustedKey = false,
    gotGildedKey = false,
    gotBlueKey = false,
    gotStrangeKey = false,
    gotCrystalKey = false
}



-- Randomize which key spawns
local function selectKey()
    local keyNum = math.random(1, 100)
    if keyNum <= 25  then
        return keys.storeKey
    elseif keyNum > 25 and keyNum <= 50 then
        return keys.rustedKey
    elseif keyNum > 50 and keyNum <= 65  then
        return keys.gildedKey
    elseif keyNum > 65 and keyNum <= 80  then
        return keys.blueKey
    elseif keyNum > 80 and keyNum <= 95  then
        return keys.strangeKey
    elseif keyNum > 95 and keyNum <= 100  then
        return keys.crystalKey
    end
end

-- AddSmeltedTrinket function made by "kittenchilly" on Steam
--removes the player's current trinkets, gives the player the one you provided, uses the smelter, then gives the player back the original trinkets.
function AddSmeltedTrinket(trinket, player)
    if not player then
        player = Isaac.GetPlayer(0)
    end

    --get the trinkets they're currently holding
    local trinket0 = player:GetTrinket(0)
    local trinket1 = player:GetTrinket(1)

    --remove them
    if trinket0 ~= 0 then
        player:TryRemoveTrinket(trinket0)
    end
    if trinket1 ~= 0 then
        player:TryRemoveTrinket(trinket1)
    end

    player:AddTrinket(trinket) --add the trinket
    player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, false, false) --smelt it
    
    --give their trinkets back
    if trinket0 ~= 0 then
        player:AddTrinket(trinket0)
    end
    if trinket1 ~= 0 then
        player:AddTrinket(trinket1)
    end
end

-- RemoveSmeltedTrinket function made by "Guwahavel#7089" on Discord
function RemoveSmeltedTrinket(trinket, player)
    if not player then
        player = Isaac.GetPlayer(0)
    end
    local readd = 0
    local trinket0 = player:GetTrinket(0)
    local trinket1 = player:GetTrinket(1)
    if trinket0 == trinket then
        player:TryRemoveTrinket(trinket)
        readd = readd + 1
    end
    if trinket1 == trinket then
        player:TryRemoveTrinket(trinket)
        readd = readd + 1
    end
    player:TryRemoveTrinket(trinket)
    if readd > 0 then
        for i = 0, readd do
            player:AddTrinket(trinket)
        end
    end
end

-- Smelt any keys held
local function smeltKeys(player)
    local trinket0 = player:GetTrinket(0)
    local trinket1 = player:GetTrinket(1)
    for index, key in pairs(keys) do
        if trinket0 == key then
            AddSmeltedTrinket(trinket0, player)
            player:TryRemoveTrinket(trinket0)
            keyQtd = keyQtd + 1
        end
        if trinket1 == key then
            AddSmeltedTrinket(trinket1, player)
            player:TryRemoveTrinket(trinket1)
            keyQtd = keyQtd + 1
        end
    end
end

local function selectKeySpawnChance()

end

-- 20% of changing a trinket to a key trinket
function kringMod:keySpawnChance(TrinketType)
    local keyNum = math.random(1, 100)
    local keyNum2
    local gotKey = false
    for playerNum = 1, game:GetNumPlayers() do
        local player = game:GetPlayer(playerNum)
        if player:HasCollectible(kringId) then
            if keyNum >= 1 and keyNum <= 20 and usedKeys < 6 then
                repeat
                    keyNum2 = math.random(1, 6)
                    if keyNum2 == 1 then
                        if checkKey.gotStoreKey == false then
                            gotKey = true
                            usedKeys = usedKeys + 1
                            checkKey.gotStoreKey = true
                            return keys.storeKey
                        else
                            gotKey = false
                        end
                    end
                    if keyNum2 == 2 then
                        if checkKey.gotRustedKey == false then
                            gotKey = true
                            usedKeys = usedKeys + 1
                            checkKey.gotRustedKey = true
                            return keys.rustedKey 
                        else
                            gotKey = false
                        end
                    end
                    if keyNum2 == 3 then
                        if checkKey.gotGildedKey == false then
                            gotKey = true
                            usedKeys = usedKeys + 1
                            checkKey.gotGildedKey = true
                            return keys.gildedKey 
                        else
                            gotKey = false
                        end
                    end
                    if keyNum2 == 4 then
                        if checkKey.gotBlueKey == false then
                            gotKey = true
                            usedKeys = usedKeys + 1
                            checkKey.gotBlueKey = true
                            return keys.blueKey
                        else
                            gotKey = false
                        end
                    end
                    if keyNum2 == 5 then
                        if checkKey.gotStrangeKey == false then
                            gotKey = true
                            usedKeys = usedKeys + 1
                            checkKey.gotStrangeKey = true
                            return keys.strangeKey
                        else
                            gotKey = false
                        end
                    end
                    if keyNum2 == 6 then
                        if checkKey.gotCrystalKey == false then
                            gotKey = true
                            usedKeys = usedKeys + 1
                            checkKey.gotCrystalKey = true
                            return keys.crystalKey
                        else
                            gotKey = false
                        end
                    end
                until gotKey == true
            end
        end
    end
end
kringMod:AddCallback(ModCallbacks.MC_GET_TRINKET, kringMod.keySpawnChance)

-- Checks if the player has the item
local function updateKRing(player)
    hasKRing = player:HasCollectible(kringId)
end

-- Code when the run starts or continues
function kringMod:onPlayerInit(player)
    updateKRing(player)
end
kringMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, kringMod.onPlayerInit)

-- Every major effect happens here
function kringMod:onUpdate()
    -- Checks for every player
    for playerNum = 1, game:GetNumPlayers() do
        local player = game:GetPlayer(playerNum)
        local spawnPos = room:FindFreePickupSpawnPosition(player.Position, 0, true, false)

        -- spawns the item at the start of the run
        if game:GetFrameCount() == 1 then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, kringId, Vector(320,300), Vector(0,0), nil)
        end

        -- When the item is picked up for the first time
        if player:HasCollectible(kringId) and not hasKRing then
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, selectKey(), spawnPos, Vector(0,0), nil)
        end

        -- While the item is held
        if player:HasCollectible(kringId) then
            smeltKeys(player)
        end

        -- When the item is removed
        if not player:HasCollectible(kringId) and hasKRing then
            -- Check all the key trinkets the player has
            for i = 0, keyQtd, 1 do
                for index, key in pairs(keys) do
                    -- Unsmelt and drop them into the ground
                    if player:HasTrinket(key, false) then
                        RemoveSmeltedTrinket(key, player)
                        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, key, spawnPos, Vector(0,0), nil)
                    end
                end
            end
        end
        updateKRing(player)
    end
end
kringMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, kringMod.onUpdate)

if EID then
    EID:addCollectible(kringId, "Drops a key related trinket#All key trinkets from now on will be added to your inventory#Has a 20% chance of replacing found trinkets with key related ones ")
end