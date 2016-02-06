PrefabFiles = {
	"grassfarmer",
	"twigsfarmer",
	"berriesfarmer",
	"reedsfarmer",
}

Assets = {
	Asset("ATLAS", "images/inventoryimages/grassfarmer.xml" ),
	Asset("IMAGE", "images/inventoryimages/grassfarmer.tex" ),
	Asset("ATLAS", "images/inventoryimages/twigsfarmer.xml" ),
	Asset("IMAGE", "images/inventoryimages/twigsfarmer.tex" ),
	Asset("ATLAS", "images/inventoryimages/berriesfarmer.xml" ),
	Asset("IMAGE", "images/inventoryimages/berriesfarmer.tex" ),
	Asset("ATLAS", "images/inventoryimages/reedsfarmer.xml" ),
	Asset("IMAGE", "images/inventoryimages/reedsfarmer.tex" ),
	Asset("ATLAS", "images/inventoryimages/redcontainer.xml" ),
	Asset("IMAGE", "images/inventoryimages/redcontainer.tex" ),
	Asset("ATLAS", "images/inventoryimages/greencontainer.xml" ),
	Asset("IMAGE", "images/inventoryimages/greencontainer.tex" ),
	Asset("ATLAS", "images/inventoryimages/yellowcontainer.xml" ),
	Asset("IMAGE", "images/inventoryimages/yellowcontainer.tex" ),
	Asset("ATLAS", "images/inventoryimages/orangecontainer.xml" ),
	Asset("IMAGE", "images/inventoryimages/orangecontainer.tex" ),
 Asset("SOUND", "sound/sanity.fsb"),
 Asset("SOUND", "sound/wilson.fsb"),
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
Vector3 = GLOBAL.Vector3

-- add strings
local crsRecipeDesc = "Summon dark forces to farm for you!"
local crsInspectDesc = "I guess the darkness is not that bad now!"
STRINGS.NAMES.GRASSFARMER = "Dark Grass-Farmer"
STRINGS.RECIPE_DESC.GRASSFARMER = crsRecipeDesc
STRINGS.CHARACTERS.GENERIC.DESCRIBE.GRASSFARMER = crsInspectDesc
STRINGS.NAMES.TWIGSFARMER = "Dark Twig-Farmer"
STRINGS.RECIPE_DESC.TWIGSFARMER = crsRecipeDesc
STRINGS.CHARACTERS.GENERIC.DESCRIBE.TWIGSFARMER = crsInspectDesc
STRINGS.NAMES.BERRIESFARMER = "Dark Berry-Farmer"
STRINGS.RECIPE_DESC.BERRIESFARMER = crsRecipeDesc
STRINGS.CHARACTERS.GENERIC.DESCRIBE.BERRIESFARMER = crsInspectDesc
STRINGS.NAMES.REEDSFARMER = "Dark Reed-Farmer"
STRINGS.RECIPE_DESC.REEDSFARMER = crsRecipeDesc
STRINGS.CHARACTERS.GENERIC.DESCRIBE.REEDSFARMER = crsInspectDesc

-- get mod settings
GLOBAL.crsDarkBerryFarmerCollectRadius = GetModConfigData("crsDarkBerryFarmerCollectRadius")
GLOBAL.crsDarkGrassFarmerCollectRadius = GetModConfigData("crsDarkGrassFarmerCollectRadius")
GLOBAL.crsDarkReedFarmerCollectRadius = GetModConfigData("crsDarkReedFarmerCollectRadius")
GLOBAL.crsDarkTwigFarmerCollectRadius = GetModConfigData("crsDarkTwigFarmerCollectRadius")
GLOBAL.crsDarkFarmerCollectInterval = GetModConfigData("crsDarkFarmerCollectInterval")
GLOBAL.crsDarkFarmerFeedValue = GetModConfigData("crsDarkFarmerFeedValue")
GLOBAL.crsDarkBerryFarmerNumFood = GetModConfigData("crsDarkBerryFarmerNumFood")
GLOBAL.crsDarkGrassFarmerNumFood = GetModConfigData("crsDarkBerryFarmerNumFood")
GLOBAL.crsDarkReedFarmerNumFood = GetModConfigData("crsDarkBerryFarmerNumFood")
GLOBAL.crsDarkTwigFarmerNumFood = GetModConfigData("crsDarkBerryFarmerNumFood")

-- add recipes
local crsDarkMote = "images/inventoryimages/darkmote.xml"
local crsDarkBerryFarmerRecipeDarkMotes = Ingredient("darkmote", GetModConfigData("crsDarkBerryFarmerRecipeDarkMotes"))
crsDarkBerryFarmerRecipeDarkMotes.atlas = crsDarkMote
local crsDarkGrassFarmerRecipeDarkMotes = Ingredient("darkmote", GetModConfigData("crsDarkGrassFarmerRecipeDarkMotes"))
crsDarkGrassFarmerRecipeDarkMotes.atlas = crsDarkMote
local crsDarkReedFarmerRecipeDarkMotes = Ingredient("darkmote", GetModConfigData("crsDarkReedFarmerRecipeDarkMotes"))
crsDarkReedFarmerRecipeDarkMotes.atlas = crsDarkMote
local crsDarkTwigFarmerRecipeDarkMotes = Ingredient("darkmote", GetModConfigData("crsDarkTwigFarmerRecipeDarkMotes"))
crsDarkTwigFarmerRecipeDarkMotes.atlas = crsDarkMote
-- berriesfarmer
local berriesfarmer = Recipe("berriesfarmer", {
 crsDarkBerryFarmerRecipeDarkMotes,
}, RECIPETABS.ANCIENT, TECH.SCIENCE_ONE, "berriesfarmer_placer")
berriesfarmer.atlas = "images/inventoryimages/berriesfarmer.xml"
-- grassfarmer
local grassfarmer = Recipe("grassfarmer", {
 crsDarkGrassFarmerRecipeDarkMotes,
}, RECIPETABS.ANCIENT, TECH.SCIENCE_ONE, "grassfarmer_placer")
grassfarmer.atlas = "images/inventoryimages/grassfarmer.xml"
-- reedsfarmer
local reedsfarmer = Recipe("reedsfarmer", {
 crsDarkReedFarmerRecipeDarkMotes,
}, RECIPETABS.ANCIENT, TECH.SCIENCE_ONE, "reedsfarmer_placer")
reedsfarmer.atlas = "images/inventoryimages/reedsfarmer.xml"
-- twigsfarmer
local twigsfarmer = Recipe("twigsfarmer", {
 crsDarkTwigFarmerRecipeDarkMotes,
}, RECIPETABS.ANCIENT, TECH.SCIENCE_ONE, "twigsfarmer_placer")
twigsfarmer.atlas = "images/inventoryimages/twigsfarmer.xml"

-- add tint
local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
	if container.widgetbgimagetint then
		self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
 end
end
AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- get widget position
local crsWidgetPosition = Vector3(GetModConfigData("crsHorizontalPosition"),GetModConfigData("crsVerticalPosition"),0) -- background image position
-- create slots
local crsSlotPos = {}
table.insert(crsSlotPos, Vector3(-40, 80, 0))
table.insert(crsSlotPos, Vector3(40, 80, 0))
table.insert(crsSlotPos, Vector3(80, 0, 0))
table.insert(crsSlotPos, Vector3(0, 0, 0))
table.insert(crsSlotPos, Vector3(-80, 0, 0))
table.insert(crsSlotPos, Vector3(-40, -80, 0))
table.insert(crsSlotPos, Vector3(40, -80, 0))

-- update prefabs
local function crsFarmerPostInit(prefname, gettype)
 local function crsOnOpen(inst)
  inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
 end
 
 local function crsOnClose(inst)
  inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
 end
 
 local function crsOnHit(inst)
  inst.AnimState:PlayAnimation("hit")
  if inst.components.container then
   inst.components.container:Close()
  end
 end

 local function crsOnHammered(inst, worker)
  -- inst.components.lootdropper:DropLoot()
  if inst.components.container then
   inst.components.container:DropEverything()
  end
  if inst.components.workable then
   inst:RemoveComponent("workable")
  end
  inst.SoundEmitter:PlaySound("dontstarve/sanity/shadowhand_snuff")
  inst.AnimState:PlayAnimation("destroyed")
  inst:DoTaskInTime(0.5, function()
   inst:Remove()
  end)
 end
 
 local function crsDarkFarmerPostInit(inst)
  inst.components.container:SetNumSlots(#crsSlotPos)
  inst.components.container.widgetslotpos = crsSlotPos
  if inst.crsDarkFarmerType == "berries" then
   inst.components.container.widgetbgimage = "redcontainer.tex"
   inst.components.container.widgetbgatlas = "images/inventoryimages/redcontainer.xml"
   inst.components.container.widgetbgimagetint = {r=100/255,g=0/255,b=0/255,a=1} -- add tint
  elseif inst.crsDarkFarmerType == "grass" then
   inst.components.container.widgetbgimage = "greencontainer.tex"
   inst.components.container.widgetbgatlas = "images/inventoryimages/greencontainer.xml"
   inst.components.container.widgetbgimagetint = {r=63/255,g=128/255,b=64/255,a=1} -- add tint
  elseif inst.crsDarkFarmerType == "twigs" then
   inst.components.container.widgetbgimage = "yellowcontainer.tex"
   inst.components.container.widgetbgatlas = "images/inventoryimages/yellowcontainer.xml"
   inst.components.container.widgetbgimagetint = {r=152/255,g=110/255,b=0,a=1} -- add tint
  elseif inst.crsDarkFarmerType == "reeds" then
   inst.components.container.widgetbgimage = "orangecontainer.tex"
   inst.components.container.widgetbgatlas = "images/inventoryimages/orangecontainer.xml"
   inst.components.container.widgetbgimagetint = {r=233/255,g=89/255,b=0,a=1} -- add tint
  end
  inst.components.container.widgetpos = crsWidgetPosition
  inst.components.container.onopenfn = crsOnOpen
  inst.components.container.onclosefn = crsOnClose
  inst.components.workable:SetWorkLeft(6)
  inst.components.workable:SetOnFinishCallback(crsOnHammered)
  inst.components.workable:SetOnWorkCallback(crsOnHit)
 end
 AddPrefabPostInit(prefname, crsDarkFarmerPostInit)
end
crsFarmerPostInit("berriesfarmer")
crsFarmerPostInit("grassfarmer")
crsFarmerPostInit("twigsfarmer")
crsFarmerPostInit("reedsfarmer")
