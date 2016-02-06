require "prefabutil"

local assets = {
	Asset("ANIM", "anim/berriesfarmer.zip"),
}

local function crsItemTest(inst, item, slot)
 return item.prefab == "berries" or
	item.prefab == "poop" or
 item.prefab == "spoiled_food" or
 item.prefab == "nightmarefuel"
end

local function fn(Sim)
 local inst = CreateEntity()
 
 inst.crsDarkFarmerType = "berries"
 inst.crsFoodStatus = 0
 
 inst.entity:AddTransform()
 
 inst.entity:AddAnimState()
 inst.AnimState:SetBank("berriesfarmer")
 inst.AnimState:SetBuild("berriesfarmer")
 inst.AnimState:PlayAnimation("idle")
 
 inst.entity:AddSoundEmitter()

 inst:AddTag("structure")
 inst:AddTag("chest")
 inst:AddTag("crsCustomPerishMult")
 inst.crsCustomPerishMult = 0

 inst:AddComponent("inspectable")
 
 inst:AddComponent("container")
 inst.components.container.itemtestfn = crsItemTest
 inst.components.container.side_align_tip = 160

 inst:AddComponent("lootdropper")
 
 inst:AddComponent("workable")
 inst.components.workable:SetWorkAction(ACTIONS.HAMMER)

 local function crsSearchForBush(inst)
  if inst.crsFoodStatus > 0 then
   local crsPickableBush = FindEntity(inst, crsDarkBerryFarmerCollectRadius, function(crsPickableBush)
    return crsPickableBush.name == "Berry Bush" and crsPickableBush.components.pickable and crsPickableBush.components.pickable.canbepicked
   end)
   local crsFertilizableBush = FindEntity(inst, crsDarkBerryFarmerCollectRadius, function(crsFertilizableBush)
    return crsFertilizableBush.name == "Berry Bush" and crsFertilizableBush.components.pickable and crsFertilizableBush.components.pickable:CanBeFertilized()
   end)
   if crsPickableBush then
    inst.components.container:GiveItem(SpawnPrefab("berries"))
    crsPickableBush.components.pickable:Pick(inst)
    inst.crsFoodStatus = inst.crsFoodStatus - 1
   end
   if crsFertilizableBush then
    local crsHasFertilizer = inst.components.container:FindItem(function(crsFertilizer)
     return crsFertilizer.components.fertilizer
    end)
    if crsHasFertilizer then
     crsFertilizableBush.components.pickable:Fertilize(crsHasFertilizer)
     inst.crsFoodStatus = inst.crsFoodStatus - 1
    end
   end
  else
   local crsHasFood = inst.components.container:FindItem(function(crsFood)
    return crsFood.name == "Nightmare Fuel"
   end)
   if crsHasFood then
    if crsHasFood.components.stackable then
     if crsHasFood.components.stackable.stacksize >= crsDarkBerryFarmerNumFood then
      crsHasFood.components.stackable:Get(crsDarkBerryFarmerNumFood):Remove()
      inst.crsFoodStatus = crsDarkFarmerFeedValue
     end
    else
     crsHasFood:Remove()
     inst.crsFoodStatus = crsDarkFarmerFeedValue
    end
   end
  end
 end
 inst:DoPeriodicTask(crsDarkFarmerCollectInterval, crsSearchForBush)

 inst.OnSave = function(inst, data)
  data.crsFoodStatus = inst.crsFoodStatus
 end
	inst.OnLoad = function(inst, data)
  if data and data.crsFoodStatus then
   inst.crsFoodStatus = data.crsFoodStatus
  end
 end
 
 return inst
end

return Prefab( "common/berriesfarmer", fn, assets, prefabs),
		MakePlacer("common/berriesfarmer_placer", "berriesfarmer", "berriesfarmer", "idle")
