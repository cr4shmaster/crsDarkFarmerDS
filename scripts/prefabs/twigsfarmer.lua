require "prefabutil"

local assets = {
	Asset("ANIM", "anim/twigsfarmer.zip"),
}

local function crsItemTest(inst, item, slot)
 return item.prefab == "twigs" or
 item.prefab == "nightmarefuel"
end

local function fn(Sim)
 local inst = CreateEntity()
 
 inst.crsDarkFarmerType = "twigs"
 inst.crsFoodStatus = 0
 
 inst.entity:AddTransform()
 
 inst.entity:AddAnimState()
 inst.AnimState:SetBank("twigsfarmer")
 inst.AnimState:SetBuild("twigsfarmer")
 inst.AnimState:PlayAnimation("idle")
 
 inst.entity:AddSoundEmitter()
 
 inst:AddTag("structure")
 inst:AddTag("chest")

 inst:AddComponent("inspectable")
 
 inst:AddComponent("container")
 inst.components.container.itemtestfn = crsItemTest
 inst.components.container.side_align_tip = 160

 inst:AddComponent("lootdropper")
 
 inst:AddComponent("workable")
 inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
 
 local function crsSearchForSapling(inst)
  if inst.crsFoodStatus > 0 then
   local crsSapling = FindEntity(inst, crsDarkTwigFarmerCollectRadius, function(crsSapling)
    return crsSapling.name == "Sapling" and crsSapling.components.pickable and crsSapling.components.pickable.canbepicked
   end)
   if crsSapling then -- if valid
    inst.components.container:GiveItem(SpawnPrefab("twigs"))
    crsSapling.components.pickable:Pick(inst)
    inst.crsFoodStatus = inst.crsFoodStatus - 1
   end
  else
   local crsHasFood = inst.components.container:FindItem(function(crsFood)
    return crsFood.name == "Nightmare Fuel"
   end)
   if crsHasFood then
    if crsHasFood.components.stackable then
     if crsHasFood.components.stackable.stacksize >= crsDarkTwigFarmerNumFood then
      crsHasFood.components.stackable:Get(crsDarkTwigFarmerNumFood):Remove()
      inst.crsFoodStatus = crsDarkFarmerFeedValue
     end
    else
     crsHasFood:Remove()
     inst.crsFoodStatus = crsDarkFarmerFeedValue
    end
   end
  end
 end
 inst:DoPeriodicTask(crsDarkFarmerCollectInterval, crsSearchForSapling)

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

return Prefab( "common/twigsfarmer", fn, assets),
		MakePlacer("common/twigsfarmer_placer", "twigsfarmer", "twigsfarmer", "idle")
