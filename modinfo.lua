name = "Dark Farmer"
description = "Adds Dark Farmers to the game."
author = "cr4shmaster"
version = "1.1.4"
forumthread = ""
api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"

local crsPosition = {
 {description = "500", data = 500},
 {description = "475", data = 475},
 {description = "450", data = 450},
 {description = "425", data = 425},
 {description = "400", data = 400},
 {description = "375", data = 375},
 {description = "350", data = 350},
 {description = "325", data = 325},
 {description = "300", data = 300},
 {description = "275", data = 275},
 {description = "250", data = 250},
 {description = "225", data = 225},
 {description = "200", data = 200},
 {description = "175", data = 175},
 {description = "150", data = 150},
 {description = "125", data = 125},
 {description = "100", data = 100},
 {description = "75", data = 75},
 {description = "50", data = 50},
 {description = "25", data = 25},
 {description = "0", data = 0},
 {description = "-25", data = -25},
 {description = "-50", data = -50},
 {description = "-75", data = -75},
 {description = "-100", data = -100},
 {description = "-125", data = -125},
 {description = "-150", data = -150},
 {description = "-175", data = -175},
 {description = "-200", data = -200},
 {description = "-225", data = -225},
 {description = "-250", data = -250},
 {description = "-275", data = -275},
 {description = "-300", data = -300},
 {description = "-325", data = -325},
 {description = "-350", data = -350},
 {description = "-375", data = -375},
 {description = "-400", data = -400},
 {description = "-425", data = -425},
 {description = "-450", data = -450},
 {description = "-475", data = -475},
 {description = "-500", data = -500},
}
local crsRadius = {
 {description = "1", data = 1},
 {description = "2", data = 2},
 {description = "3", data = 3},
 {description = "5", data = 5},
 {description = "10", data = 10},
 {description = "15", data = 15},
 {description = "20", data = 20},
}
local crsDarkMotes = {
 {description = "100", data = 100},
 {description = "150", data = 150},
 {description = "200", data = 200},
 {description = "250", data = 250},
 {description = "300", data = 300},
 {description = "350", data = 350},
 {description = "400", data = 400},
 {description = "450", data = 450},
 {description = "500", data = 500},
}
local crsCount = {
 {description = "1", data = 1},
 {description = "2", data = 2},
 {description = "3", data = 3},
 {description = "4", data = 4},
 {description = "5", data = 5},
 {description = "6", data = 6},
 {description = "7", data = 7},
 {description = "8", data = 8},
 {description = "9", data = 9},
 {description = "10", data = 10},
}
local crsValue = {
 {description = "50", data = 50},
 {description = "60", data = 60},
 {description = "70", data = 70},
 {description = "80", data = 80},
 {description = "90", data = 90},
 {description = "100", data = 100},
 {description = "125", data = 125},
 {description = "150", data = 150},
 {description = "200", data = 200},
 {description = "250", data = 250},
 {description = "300", data = 300},
 {description = "350", data = 350},
 {description = "400", data = 400},
 {description = "450", data = 450},
 {description = "500", data = 500},
}

configuration_options = {
 {
		name = "crsDarkBerryFarmerRecipeDarkMotes",
		label = "DBF Dark Motes",
		options = crsDarkMotes,
		default = 350,
	},
 {
		name = "crsDarkGrassFarmerRecipeDarkMotes",
		label = "DGF Dark Motes",
		options = crsDarkMotes,
		default = 350,
	},
 {
		name = "crsDarkReedFarmerRecipeDarkMotes",
		label = "DRF Dark Motes",
		options = crsDarkMotes,
		default = 100,
	},
 {
		name = "crsDarkTwigFarmerRecipeDarkMotes",
		label = "DTF Dark Motes",
		options = crsDarkMotes,
		default = 350,
	},
 {
		name = "crsDarkBerryFarmerCollectRadius",
		label = "DBF Collect Radius",
		options = crsRadius,
		default = 10,
	},
 {
		name = "crsDarkGrassFarmerCollectRadius",
		label = "DGF Collect Radius",
		options = crsRadius,
		default = 10,
	},
 {
		name = "crsDarkReedFarmerCollectRadius",
		label = "DRF Collect Radius",
		options = crsRadius,
		default = 10,
	},
 {
		name = "crsDarkTwigFarmerCollectRadius",
		label = "DTF Collect Radius",
		options = crsRadius,
		default = 10,
	},
 {
		name = "crsDarkFarmerCollectInterval",
		label = "Collect Interval",
		options = crsCount,
		default = 5,
	},
 {
		name = "crsDarkFarmerFeedValue",
		label = "Food Value",
		options = crsValue,
		default = 100,
	},
 {
		name = "crsDarkBerryFarmerNumFood",
		label = "DBF Food Used",
		options = crsCount,
		default = 1,
	},
 {
		name = "crsDarkGrassFarmerNumFood",
		label = "DGF Food Used",
		options = crsCount,
		default = 1,
	},
 {
		name = "crsDarkReedFarmerNumFood",
		label = "DRF Food Used",
		options = crsCount,
		default = 1,
	},
 {
		name = "crsDarkTwigFarmerNumFood",
		label = "DTF Food Used",
		options = crsCount,
		default = 1,
	},
 {
		name = "crsHorizontalPosition",
		label = "UI x Position",
		options = crsPosition,
		default = -300,
	},
 {
		name = "crsVerticalPosition",
		label = "UI y Position",
		options = crsPosition,
		default = -100,
	},
}
