function onCreatePost()
    makeLuaText('funnyHahas','',999,120,640)
    addLuaText('funnyHahas')
    setTextSize('funnyHahas',35)
    setTextAlignment('funnyHahas','left')
end
function makeLuaIcon(tag, image, x, y) -- thanks skry soda
    makeLuaSprite(tag,image,x,y)
    setProperty(tag..'.antialiasing',false)
    loadGraphic(tag,image,getProperty(tag..'.width')/2,getProperty(tag..'.height'))
    addAnimation(tag,'static',{0},true)
    playAnim(tag,'static')
    setObjectCamera(tag,'hud')
    addLuaSprite(tag)
end

local strang = 'haha!'
local textCol = 'FFFFFF'
local icunt = 'icon-face'
local prevIcunt = 'icon-face'
function onEvent(n,v1,v2)
    if n == 'subtitlesFNF' then
        if v2 == 'purple' then 
            v2 = 'a349a3'
            icunt = 'icon-shadWiz'
        elseif v2 == 'green' then 
            v2 = '23b14d'
            icunt = 'icon-greenWiz'
        elseif v2 == 'yellow' then 
            v2 = 'fef200'
            icunt = 'icon-yelWiz'
        else 
            v2 = 'FFFFFF'
            icunt = 'icon-face'
        end

        if v1 == null or v1 == '' then
            v1 = strang
            v2 = textCol
            icunt = prevIcunt

            doTweenY('textOut','funnyHahas',750,1,'quadInOut')
            doTweenAlpha('textFadeOut','funnyHahas',0,1,'quadInOut')
            doTweenY('icunOut','funnyIcon',700,1,'quadInOut')
            doTweenAlpha('icunFadeOut','funnyIcon',0,1,'quadInOut')
        else
            strang = v1
            textCol = v2
            prevIcunt = icunt
            
            setTextString('funnyHahas',' ~ '..v1)
            setTextColor('funnyHahas',v2)

            setProperty('funnyHahas.y',640)
            setProperty('funnyHahas.alpha',1)
            setProperty('funnyIcon.y',0)
            setProperty('funnyIcon.alpha',1)
            makeLuaIcon('funnyIcon', 'icons/'..icunt, 0, 590)
        end
    end
end

function opponentNoteHit(id,noteData,noteType,isSustainNote)
    if getProperty('funnyIcon.alpha') == 1 and not isSustainNote then
        setProperty('funnyIcon.scale.x',1.1)
        setProperty('funnyIcon.scale.y',1.1)
        doTweenX('funnyTwenX','funnyIcon.scale',1,0.3,'quadInOut')
        doTweenY('funnyTwenY','funnyIcon.scale',1,0.3,'quadInOut')
    end
end