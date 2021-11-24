local kringMod = RegisterMod("Dad's Keyring", 1)
local game = Game()
local kringId = Isaac.GetItemIdByName("Dad's Keyring")
local hasKRing = false
local keys = {
    crystalKey = TrinketType.TRINKET_CRYSTAL_KEY,
    strangeKey = TrinketType.TRINKET_STRANGE_KEY,
    blueKey = TrinketType.TRINKET_BLUE_KEY,
	gildedKey = TrinketType.TRINKET_GILDED_KEY,
	rustedKey = TrinketType.TRINKET_RUSTED_KEY,
	storeKey = TrinketType.TRINKET_STORE_KEY
}

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
function kringMod:onUpdate(player)

    -- spawns the item at the start of the run
    if game:GetFrameCount() == 1 then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, kringId, Vector(320,300), Vector(0,0), nil)
    end

    if player:HasCollectible(kringId) and not hasKRing then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, selectKey(), Vector(320,280), Vector(0,0), nil)
    end

    updateKRing(player)
end
kringMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, kringMod.onUpdate)