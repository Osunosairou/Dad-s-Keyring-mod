local kringMod = RegisterMod("Dad's Keyring", 1)
local game = Game()
local kringId = Isaac.GetItemIdByName("Dad's Keyring")
local hasKRing = false
local keys = {
    strangeKey = TrinketType.TRINKET_STRANGE_KEY,
    crystalKey = TrinketType.TRINKET_CRYSTAL_KEY,
    blueKey = TrinketType.TRINKET_BLUE_KEY,
	gildedKey = TrinketType.TRINKET_GILDED_KEY,
	rustedKey = TrinketType.TRINKET_RUSTED_KEY,
	storeKey = TrinketType.TRINKET_STORE_KEY

}


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
        print(kringId)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, kringId, Vector(320,300), Vector(0,0), nil)
    end

    if player:HasCollectible(kringId) and not hasKRing then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, keys.storeKey, Vector(320,280), Vector(0,0), nil)
    end

    updateKRing(player)
end
kringMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, kringMod.onUpdate)