local faded = false
local fadetime = 0.05

-- hi lily

function onCreate()


  makeLuaSprite('blakk', '', 0, 0);
  makeGraphic('blakk',1280,720,'000000')
  addLuaSprite('blakk', true);
  setLuaSpriteScrollFactor('blakk',0,0)
  setProperty('blakk.scale.x',2)
  setProperty('blakk.scale.y',2)
  setProperty('blakk.alpha', 0)
end

function onEvent(name,value1,value2)
    if name == 'fadefx' and faded == false then

      doTweenAlpha('camhud', 'camHUD', 0, fadetime, 'linear');
      doTweenAlpha('I CANT SEE','blakk', 1, fadetime, 'linear')
      faded = true
    elseif name == 'fadefx' and faded == true then
      doTweenAlpha('camhud', 'camHUD', 1, fadetime, 'linear');
      doTweenAlpha('I CAN SEE','blakk', 0, fadetime, 'linear')
      faded = false
    end
end