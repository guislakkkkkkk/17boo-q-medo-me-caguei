local bgYdef = -650
local bgYmove = 200
local bgYscaleDef = 10.81
local bgYscaleAdd = 1.5

local shaderName = "bloom"

local oppNotes = false
local middle = false

function onCreatePost()
	
	setProperty('dad.skipDance', true)

	setProperty('healthBar.alpha', tonumber(0))
    setProperty('iconP1.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))
	
	
	makeLuaSprite('vignette','home/alive',0,0)
	addLuaSprite('vignette',true)
	setScrollFactor('vignette',0,0)
	setObjectCamera('vignette','other')
	screenCenter('vignette')
	
	makeLuaSprite('bartop','',0,-30)
    makeGraphic('bartop',1280,100,'000000')
    addLuaSprite('bartop',false)
    setScrollFactor('bartop',0,0)
	setObjectCamera('bartop','hud')

    makeLuaSprite('barbot','',0,650)
    makeGraphic('barbot',1280,100,'000000')
    addLuaSprite('barbot',false)
    setScrollFactor('barbot',0,0)
	setObjectCamera('barbot','hud')
	
	makeLuaSprite('bg','home/sky',-550,bgYdef-bgYmove)
	setProperty('bg.angle',-10)
	setProperty('bg.antialiasing',false)
	scaleObject('bg',bgYscaleDef,bgYscaleDef-bgYscaleAdd)
	
	addLuaSprite('bg')
	
	makeLuaSprite('floor','home/floor',-1050,310)
	scaleObject('floor',1.5,1.5)
	addLuaSprite('floor')
	
	makeLuaSprite('light','home/light',-700,-100) 
	addLuaSprite('light', true)
	setBlendMode('light', 'lighten')
	scaleObject('light', 1.2,1.2)
	setProperty('light.alpha',0.2)
	
	
	doTweenAngle('tripAng10','bg',10,6,'sineInOut')
	doTweenY('tripDown','bg',bgYdef+bgYmove,10.5,'quadInOut')
	doTweenY('tripMore','bg.scale',bgYscaleDef+bgYscaleAdd,7,'quadInOut')
	
	
	setProperty('dad.skipDance', true)
	setTextString("botplayTxt", " ")
	setProperty('timeBar.visible', false)
	setProperty('timeTxt.visible', false)
	setProperty('showRating', false)
	setProperty('showComboNum', false)
	setProperty('healthBar.alpha', tonumber(0))
	setProperty('iconP1.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))


	setProperty('scoreTxt.visible', false)
	if middle == true then
		setPropertyFromGroup('playerStrums','0','x', 92 );
    	setPropertyFromGroup('playerStrums','1','x', 204 );
    	setPropertyFromGroup('playerStrums','2','x', 956 );
    	setPropertyFromGroup('playerStrums','3','x', 1068 );
	end
	
	
	for i = 0, 3 do
		setPropertyFromGroup('opponentStrums', i, 'x', -1000);
	end
	
	if not middlescroll then
			setPropertyFromGroup('playerStrums', 0, 'x', 420);
			setPropertyFromGroup('playerStrums', 1, 'x', 530);
			setPropertyFromGroup('playerStrums', 2, 'x', 640);
			setPropertyFromGroup('playerStrums', 3, 'x', 750);
end


function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag
	if tag == 'tripAng10' then
		doTweenAngle('tripAng-10','bg',-10,6,'sineInOut')
	end
	if tag == 'tripAng-10' then
		doTweenAngle('tripAng10','bg',10,6,'sineInOut')
	end
	if tag == 'tripDown' then
		doTweenY('tripUp','bg',bgYdef-bgYmove,4,'quadInOut')
	end
	if tag == 'tripUp' then
		doTweenY('tripDown','bg',bgYdef+bgYmove,4.5,'quadInOut')
	end
	if tag == 'tripMore' then
		doTweenY('tripLess','bg.scale',bgYscaleDef-bgYscaleAdd,7,'quadInOut')
	end
	if tag == 'tripLess' then
		doTweenY('tripMore','bg.scale',bgYscaleDef+bgYscaleAdd,7,'quadInOut')
	end
end

function onCountdownStarted()
	if oppNotes == false then
		setPropertyFromGroup('opponentStrums', 0, 'x', -1000);
		setPropertyFromGroup('opponentStrums', 1, 'x', -1000);
		setPropertyFromGroup('opponentStrums', 2, 'x', -1000);
		setPropertyFromGroup('opponentStrums', 3, 'x', -1000);
	end
end

		makeLuaSprite('dead','home/empty',0,0)
		addLuaSprite('dead',true)
		setScrollFactor('dead',0,0)
		setObjectCamera('dead','other')
		screenCenter('dead')
	end