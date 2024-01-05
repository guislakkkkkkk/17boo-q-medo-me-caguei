function onEvent(n, v1, v2)
if n == 'icon change' and v2 == 'black' then
setProperty('iconP2.visible', false)
setProperty('icon3.alpha', 1)
setProperty('icon4.visible', false)
end
if n == 'icon change' and v2 == 'white' then
setProperty('iconP2.visible', true)
setProperty('icon3.alpha', 0)
setProperty('icon4.visible', false)
end
if n == 'icon change' and v2 == 'both' then
setProperty('iconP2.visible', false)
setProperty('icon3.alpha', 0)
setProperty('icon4.visible', true)
end
end
function onCreate()
	if not hideHud then
	makeAnimatedLuaSprite('icon3', nil, getProperty('iconP2.x'), getProperty('iconP2.y'))
	loadGraphic('icon3', 'icons/icon-black', 150)
	addAnimation('icon3', 'icons/icon-black', {0, 1}, 0, true)
	addAnimation('icon3', 'icons/icon-black', {1, 0}, 0, true)
	addLuaSprite('icon3', true)
	--setProperty('icon3.antialiasing', false)
	setObjectOrder('icon3', getObjectOrder('iconP2') - 1)
	setObjectCamera('icon3', 'hud')
	setProperty('icon3.alpha', 0)
	end

	if not hideHud then
	makeAnimatedLuaSprite('icon4', nil, getProperty('iconP2.x'), getProperty('iconP2.y'))
	loadGraphic('icon4', 'icons/icon-whiteblack', 150)
	addAnimation('icon4', 'icons/icon-whiteblack', {0, 1}, 0, true)
	addAnimation('icon4', 'icons/icon-whiteblack', {1, 0}, 0, true)
	addLuaSprite('icon4', true)
	setProperty('icon4.visible', false)
	setObjectOrder('icon4', getObjectOrder('iconP2') - 1)
	setObjectCamera('icon4', 'hud')
	end
end

function onUpdatePost()
	if not hideHud then
	setProperty('icon3.y', getProperty('iconP2.y') - 0)
	setProperty('icon3.x', getProperty('iconP2.x') - 9)
	setProperty('icon3.scale.x', getProperty('iconP2.scale.x') - 0.15)
	setProperty('icon3.scale.y', getProperty('iconP2.scale.y') - 0.15)
	setObjectOrder('icon3', getObjectOrder('iconP2') - 1)
	setProperty('icon3.angle', getProperty('iconP2.angle'))
	end
	if getProperty('health') > 1.6 then
		setProperty('icon3.animation.curAnim.curFrame', '1')
	else
		setProperty('icon3.animation.curAnim.curFrame', '0')
	end

	if not hideHud then
	setProperty('icon4.y', getProperty('iconP2.y') - 0)
	setProperty('icon4.x', getProperty('iconP2.x') - 0)
	setProperty('icon4.scale.x', getProperty('iconP2.scale.x') - 0.15)
	setProperty('icon4.scale.y', getProperty('iconP2.scale.y') - 0.15)
	setObjectOrder('icon4', getObjectOrder('iconP2') - 1)
	setProperty('icon4.angle', getProperty('iconP2.angle'))
	end
	if getProperty('health') > 1.6 then
		setProperty('icon4.animation.curAnim.curFrame', '1')
	else
		setProperty('icon4.animation.curAnim.curFrame', '0')
	end
end