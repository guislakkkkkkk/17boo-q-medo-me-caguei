-- script by ItsCapp don't steal, it's dumb <--- fuck this guy
-- https://gamebanana.com/tools/8427 


-- simply, offsets. they're the numbers in the top left of the character editor
idleOffsets = {'0', '0'}        -- I recommend you have your idle offset at 0
leftOffsets = {'27', '-23'}
downOffsets = {'25', '-35'}
upOffsets = {'0', '13'}
rightOffsets = {'-28', '-6'}

leftMissOffsets = {'0', '0'}    -- use as required
downMissOffsets = {'0', '0'}
upMissOffsets = {'0', '0'}
rightMissOffsets = {'0', '0'}

leftAltOffsets = {'0', '0'}     -- use as required
downAltOffsets = {'0', '0'}
upAltOffsets = {'0', '0'}
rightAltOffsets = {'0', '0'}

-- change all of these to the name of the animation in your character's xml file including the leading 0. Caps Sensitive.
idle_xml_name = 'IDLE'
left_xml_name = 'LEFT'
down_xml_name = 'DOWN'
up_xml_name = 'UP'
right_xml_name = 'RIGHT'

left_miss_xml_name = 'MISS'   -- use as required
down_miss_xml_name = 'MISS'
up_miss_xml_name = 'MISS'
right_miss_xml_name = 'MISS'

left_alt_xml_name = 'left alt0'     -- use as required
down_alt_xml_name = 'down alt0'
up_alt_xml_name = 'up alt0'
right_alt_xml_name = 'right alt0'

-- horizontal and vertical positions
x_position = 1150
y_position = -330

-- scales your character (set to 1 by default)
xScale = 0.8
yScale = 0.8

-- pretty self-explanitory
name_of_character_xml = 'RBLXCYC'
name_of_character = 'RBLXCYC'
charNote = 'RBLXCYC'
--charNote2 = ''    -- to distinguish between multiple characters singing at the same time (uncomment to use)
--altCharNote = ''          -- this is used for alt animations (uncomment to use)
--altCharNote2 = ''         -- this is used for alt animations and singing at the same time (uncomment to use)


playableCharacter = true     -- change to 'true' if you want to the character on teamDad
flipX = false       -- most likely change to 'true' if using a BF sided character
useIdle = true      -- Use idle code or Dance code (EG: Skid&Pump, GF)
invisible = false   -- invisible character (if you want to use the change character event, you need to make the second character invisible first)
teamplay = false     -- Should character simply sing all notes on their side
layer = 1           --[[ Usable values:
0 : Behind stage
1 : Behind all
2 : In front of GF, behind Opponent and Player
3 : In front of GF and Opponent, behind Player
4 : In front of All
5+: Free Real Estate                      --]]

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

doIdle = true;
seriouslyDontIdle = false;      -- if you want to play a longer animation you can use this when necessary to temporarily override doIdle.

function onCreate()
    makeAnimatedLuaSprite(name_of_character, 'characters/' .. name_of_character_xml, x_position, y_position);

    --addAnimationByIndices(name_of_character, 'danceLeft', idle_xml_name, '8,10,12,14' , 12);
    --addAnimationByIndices(name_of_character, 'danceRight', idle_xml_name, '0,2,4,6', 12);
    addAnimationByPrefix(name_of_character, 'singLEFT', left_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singDOWN', down_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singUP', up_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singRIGHT', right_xml_name, 24, false);

    addAnimationByPrefix(name_of_character, 'singLEFTmiss', left_miss_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singDOWNmiss', down_miss_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singUPmiss', up_miss_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singRIGHTmiss', right_miss_xml_name, 24, false);

    addAnimationByPrefix(name_of_character, 'singLEFT-alt', left_alt_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singDOWN-alt', down_alt_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singUP-alt', up_alt_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singRIGHT-alt', right_alt_xml_name, 24, false);

    setPropertyLuaSprite(name_of_character, 'flipX', flipX);
    setPropertyLuaSprite(name_of_character, 'alpha', not invisible);
    scaleObject(name_of_character, xScale, yScale);
    setObjectOrder(name_of_character, layer, false);

    addAnimationByPrefix(name_of_character, 'idle', idle_xml_name, 24, false);
end

function onCountdownTick(counter)
    idleDance(counter);
end

function onEvent(name, value1, value2)
    if name == "CharacterPlayAnimation" then
        doIdle = false;
        seriouslyDontIdle = true;
        addAnimationByPrefix(value2, value1, value1, 24, false);
        objectPlayAnimation(value2, value1, true);
    elseif name == "ToggleTeamplay" then
        local case = {["true"] = true, ["1"] = true, ["false"] = false, ["0"] = false, [""] = not teamplay};
        if name_of_character == value1 then
            teamplay = case[string.lower(value2)];
        end
    end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"};
local singOffsets = {leftOffsets, downOffsets, upOffsets, rightOffsets};
local altAnims = {"singLEFT-alt", "singDOWN-alt", "singUP-alt", "singRIGHT-alt"};
local altOffsets = {leftAltOffsets, downAltOffsets, upAltOffsets, rightAltOffsets};
local missAnims = {"singLEFTmiss", "singDOWNmiss", "singUPmiss", "singRIGHTmiss"};
local missOffsets = {leftMissOffsets, downMissOffsets, upMissOffsets, rightMissOffsets};


-- I know this is messy, but it's the only way I know to make it work on both sides.
-- Don't worry bro I cleaned it up -Scarab

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not playableCharacter then
        if noteType == charNote or noteType == charNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        elseif noteType == altCharNote or noteType == altCharNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, altAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', altOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', altOffsets[direction + 1][2]);
        elseif teamplay then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if playableCharacter then
        if noteType == charNote or noteType == charNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        elseif noteType == altCharNote or noteType == altCharNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, altAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', altOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', altOffsets[direction + 1][2]);
        elseif teamplay then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        end
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if playableCharacter then
        if noteType == 'mimi' then
            objectPlayAnimation(name_of_character, 'singLEFTmiss', true);
            setProperty(name_of_character .. '.offset.x' -60);
            doIdle = false;
        end
    end
end

function onBeatHit()
    if doIdle then
        idleDance(curBeat);
    end
    if seriouslyDontIdle then
        if getProperty(name_of_character .. '.animation.curAnim.finished') then
            doIdle = true;
            seriouslyDontIdle = false;
        end
    else
        doIdle = true;
    end
end

function idleDance(beat)
    if useIdle then
        if beat % 2 == 1 then
            objectPlayAnimation(name_of_character, 'idle', false);
            setProperty(name_of_character .. '.offset.x', idleOffsets[1]);
            setProperty(name_of_character .. '.offset.y', idleOffsets[2]);
        end
    end
end

steveBanned = true