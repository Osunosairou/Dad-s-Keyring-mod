local kringMod = RegisterMod("Dad's Keyring",1)
local game = Game()
local kringId = Isaac.GetItemIdByName("Dads Keyring")
local hasKRing = false


-- Checks if the player has the item
local function updateKRing(player)
    hasKRing = player.hasCollectible(kringId)
end

-- Code when the run starts or continues
function kringMod:onPlayerInit(player)
    updateKRing(player)
end
kringMod:AddCallback(ModCallBacks.MC_POST_PLAYER_INIT, kringMod.onPlayerInit)

-- Every major effect happens here
function kringMod:onUpdate(player)
    if game:GetFrameCount() == 1 then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, kringId, Vector(320,300), Vector(0,0), nil)
    end
end