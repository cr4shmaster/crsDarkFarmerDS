require "prefabutil"

local assets = {
	Asset("ANIM", "anim/reedsfarmer.zip"),
}

crsDarkFarmerDS = "workshop-501860211"
-- crsDarkFarmerDS = "crsDarkFarmerDS"

local crsCollectRadius = GetModConfigData("crsDarkReedFarmerCollectRadius", crsDarkFarmerDS)
local crsCollectInterval = GetModConfigData("crsDarkFarmerCollectInterval", crsDarkFarmerDS)
local crsFeedValue = GetModConfigData("crsDarkFarmerFeedValue", crsDarkFarmerDS)
local crsFoodCount = GetModConfigData("crsDarkReedFarmerFoodCount", crsDarkFarmerDS)

local function crsItemTest(inst, item, slot)
 return item.prefab == "cutreeds" or
 item.prefab == "nightmarefuel"
end

local function fn(Sim)
 local inst = CreateEntity()
 
 inst.crsDarkFarmerType = "reeds"
 inst.crsFoodStatus = 0
 
 inst.entity:AddTransform()
 
 inst.entity:AddAnimState()
 inst.AnimState:SetBank("reedsfarmer")
 inst.AnimState:SetBuild("reedsfarmer")
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
 
 local function crsSearchForReeds(inst)
  if inst.crsFoodStatus > 0 then
   local crsReeds = FindEntity(inst, crsCollectRadius, function(crsReeds)
    return crsReeds.name == "Reeds" and crsReeds.components.pickable and crsReeds.components.pickable.canbepicked
   end)
   if crsReeds then -- if valid
    inst.components.container:GiveItem(SpawnPrefab("cutreeds"))
    crsReeds.components.pickable:Pick(inst)
    inst.crsFoodStatus = inst.crsFoodStatus - 1
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
 inst:DoPeriodicTask(crsCollectInterval, crsSearchForReeds)

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

return Prefab( "common/reedsfarmer", fn, assets),
		MakePlacer("common/reedsfarmer_placer", "reedsfarmer", "reedsfarmer", "idle")
