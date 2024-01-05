function onCreatePost()
	makeLuaSprite("white", "", -3000, -3000)
	makeGraphic("white", 5000, 5000, "ffffff")
	addLuaSprite("white", false)
	
	makeLuaSprite("bg", "joner_ref", -1050, -932)
	scaleObject("bg", 1.45, 1.45)
	addLuaSprite("bg", false)
	setProperty("bg.alpha", 1)
end