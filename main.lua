local kringMod = RegisterMod("Dad's Keyring", 1)
local game = Game()
local kringId = Isaac.GetItemIdByName("Dad's Keyring")
local hasKRing = false


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
    if game:GetFrameCount() == 1 then
        print(kringId)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, kringId, Vector(320,300), Vector(0,0), nil)
    end
    updateKRing(player)
end
kringMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, kringMod.onUpdate)