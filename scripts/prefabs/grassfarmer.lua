require "prefabutil"

local assets = {
	Asset("ANIM", "anim/grassfarmer.zip"),
}

crsDarkFarmerDS = "workshop-501860211"
-- crsDarkFarmerDS = "crsDarkFarmerDS"

local crsCollectRadius = GetModConfigData("crsDarkGrassFarmerCollectRadius", crsDarkFarmerDS)
local crsCollectInterval = GetModConfigData("crsDarkFarmerCollectInterval", crsDarkFarmerDS)
local crsFeedValue = GetModConfigData("crsDarkFarmerFeedValue", crsDarkFarmerDS)
local crsFoodCount = GetModConfigData("crsDarkGrassFarmerFoodCount", crsDarkFarmerDS)

local function crsItemTest(inst, item, slot)
 return item.prefab == "cutgrass" or
	item.prefab == "poop" or
 item.prefab == "spoiled_food" or
 item.prefab == "nightmarefuel"
end

local function fn(Sim)
 local inst = CreateEntity()
 
 inst.crsDarkFarmerType = "grass"
 inst.crsFoodStatus = 0
 
 inst.entity:AddTransform()
 
 inst.entity:AddAnimState()
 inst.AnimState:SetBank("grassfarmer")
 inst.AnimState:SetBuild("grassfarmer")
 inst.AnimState:PlayAnimation("idle")
 
 inst.entity:AddSoundEmitter()
 
 inst.entity:AddDynamicShadow()
 inst.DynamicShadow:SetSize(10,5)
 
 inst:AddTag("structure")
 inst:AddTag("chest")

 inst:AddComponent("inspectable")
 
 inst:AddComponent("container")
 inst.components.container.itemtestfn = crsItemTest
 inst.components.container.side_align_tip = 160

 inst:AddComponent("lootdropper")
 
 inst:AddComponent("workable")
 inst.components.workable:SetWorkAction(ACTIONS.HAMMER)

 local function crsSearchForGrass(inst)
  if inst.crsFoodStatus > 0 then
   local crsPickableGrass = FindEntity(inst, crsCollectRadius, function(crsPickableGrass)
    return crsPickableGrass.name == "Grass" and crsPickableGrass.components.pickable and crsPickableGrass.components.pickable.canbepicked
   end)
   local crsFertilizableGrass = FindEntity(inst, crsCollectRadius, function(crsFertilizableGrass)
    return crsFertilizableGrass.name == "Grass" and crsFertilizableGrass.components.pickable and crsFertilizableGrass.components.pickable:CanBeFertilized()
   end)
   if crsPickableGrass then
    inst.components.container:GiveItem(SpawnPrefab("cutgrass"))
    crsPickableGrass.components.pickable:Pick(inst)
    inst.crsFoodStatus = inst.crsFoodStatus - 1
   end
   if crsFertilizableGrass then
    local crsHasFertilizer = inst.components.container:FindItem(function(crsFertilizer)
     return crsFertilizer.components.fertilizer
    end)
    if crsHasFertilizer then
     crsFertilizableGrass.components.pickable:Fertilize(crsHasFertilizer)
     inst.crsFoodStatus = inst.crsFoodStatus - 1
    end
   end
  else
   local crsHasFood = inst.components.container:FindItem(function(crsFood)
    return crsFood.name == "Nightmare Fuel"
   end)
   if crsHasFood then
    if crsHasFood.components.stackable then
     if crsHasFood.components.stackable.stacksize >= crsFoodCount then
      crsHasFood.components.stackable:Get(crsFoodCount):Remove()
      inst.crsFoodStatus = crsFeedValue
     end
    else
     crsHasFood:Remove()
     inst.crsFoodStatus = crsFeedValue
    end
   end
  end
 end
 inst:DoPeriodicTask(crsCollectInterval, crsSearchForGrass)

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

return Prefab( "common/grassfarmer", fn, assets),
		MakePlacer("common/grassfarmer_placer", "grassfarmer", "grassfarmer", "idle")
