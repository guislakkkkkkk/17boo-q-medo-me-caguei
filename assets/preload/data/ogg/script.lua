function onCreate()
    setProperty('skipCountdown',true)
end

function onCreatePost()
    makeLuaSprite('blacker', '', 0, 0);
    makeGraphic('blacker',1280,720,'000000')
    addLuaSprite('blacker', true);
    setObjectCamera('blacker', 'other');

    makeLuaSprite('computer_boarder', 'home/ending/computer_boarder', 0, 0);
    addLuaSprite('computer_boarder', true);
    setObjectCamera('computer_boarder', 'other');
    doTweenX('computer_boarder.scalex','computer_boarder.scale',1.5,19.5,'linear')
    doTweenY('computer_boarder.scaley','computer_boarder.scale',1.5,19.5,'linear')

    makeLuaSprite('blackerr', '', 0, 0);
    makeGraphic('blackerr',1280,720,'000000')
    addLuaSprite('blackerr', true);
    setObjectCamera('blackerr', 'other');
       
   makeLuaSprite('blackscreen', '', 0, 0);
   makeGraphic('blackscreen',1280,720,'000000')
   addLuaSprite('blackscreen', true);
   setObjectCamera('blackscreen', 'other');
   setProperty('blackscreen.alpha', 1);
   doTweenAlpha('black','blackscreen',0,19.5,'linear')

   for i = 1,3 do
    makeLuaSprite('image'..i, 'home/flash/image'..i, 0, 0);
    addLuaSprite('image'..i, true);
    setObjectCamera('image'..i, 'other');
    setProperty('image'..i..'.alpha', 0.00001);
   end

   makeLuaSprite('cursor','home/mouse',getMouseX('other')-70,getMouseY('other')-70)
   addLuaSprite('cursor',true)
   setObjectCamera('cursor', 'other')
   scaleObject('cursor', 0.25, 0.25)
end

function onUpdatePost(elapsed)
    setProperty('cursor.x',getMouseX('other')-70);
	setProperty('cursor.y',getMouseY('other')-70);


    if getHealth() <= 0.0001 then
        if curBeat > 72 then
            openCustomSubstate('gameover',true)
        else
            setProperty('health',1)
        end
    end
end

function onGameOver()
    return Function_Stop
end


function onCustomSubstateCreatePost(n)
    makeLuaSprite('dc','home/ending/roblox_dissconnected',0,0)
    addLuaSprite('dc',true)
    setObjectCamera('dc','other')
    setObjectOrder('dc', getObjectOrder('cursor') -1 )
    setObjectOrder('blackscreen', getObjectOrder('dc') -1 )
    stopTween('black')
    setProperty('blackscreen.alpha', 0.8);
    playSound('ringing',1,'ringing')
end

function onCustomSubstateUpdate(n,elapsed)
    setProperty('cursor.x',getMouseX('other')-70);
	setProperty('cursor.y',getMouseY('other')-70);

    if mouseClicked('left') then
        if getProperty('cursor.x') > 425 and getProperty('cursor.x') < 597 and getProperty('cursor.y') > 389 and getProperty('cursor.y') < 423 then
            exitSong(false)
        end
        if getProperty('cursor.x') > 611 and getProperty('cursor.x') < 782 and getProperty('cursor.y') > 389 and getProperty('cursor.y') < 423 then
            restartSong(false)
            
             setProperty('blackscreen.alpha', 1);
             setObjectOrder('blackscreen', getObjectOrder('dc') +1 )
             stopSound('ringing')
        end
    end
end

function onSoundFinished(t)
    if t == 'ringing' then
        playSound('ringing',1,'ringing')
    end
end

function onUpdate()
    if getProperty('blacker.alpha') < 1 then
        if curBeat < 488 then
            setProperty('blacker.alpha',getRandomInt(0,6)/100)
        elseif curBeat >= 488 and curBeat < 512 then 
            setProperty('blacker.alpha',getRandomInt(0,3)/10)
        elseif curBeat >= 512 and curBeat < 524 then 
            setProperty('blacker.alpha',getRandomInt(0,3)/10)
        elseif curBeat >= 524 and curBeat < 533 then 
            setProperty('blacker.alpha',getRandomInt(0,8)/10)
        end
    end
    if luaSpriteExists('blackerr') then
        setProperty('blackerr.alpha',getRandomInt(0,3)/10)
    end
end

function onBeatHit()
    if curBeat == 533 then
        setProperty('blacker.alpha',1)
        doTweenAlpha('blackerrr','blacker',0,10,'quadInOut')
    end
    if curBeat == 64 then
        removeLuaSprite('computer_boarder')
        setProperty('blacker.alpha',0)
        setObjectCamera('blacker', 'hud');
        setObjectOrder('blacker', getObjectOrder('healthBar') -2 )
        removeLuaSprite('blackerr')
    end
    if curBeat == 254 then
        setProperty('image1.alpha',1)
    end
    if curBeat == 255 then
        removeLuaSprite('image1')
    end
    if curBeat == 271 then
        setProperty('image2.alpha',1)
    end
    if curBeat == 272 then
        removeLuaSprite('image2')
    end
    if curBeat == 291 then
        setProperty('image3.alpha',1)
    end
    if curBeat == 292 then
        removeLuaSprite('image3')
    end
    if curBeat == 380 then
        if getHealth() > 0.0001 then
            setProperty('blackscreen.alpha',1)
        end
    end
    if curBeat == 384 then
        if getHealth() > 0.0001 then
            setProperty('blackscreen.alpha',0)
        end
    end
end
