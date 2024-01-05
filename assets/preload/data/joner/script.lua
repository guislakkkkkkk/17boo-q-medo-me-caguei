local function pause(sec, func)
	local unpause = os.clock() + sec
	while os.clock() < unpause do end -- freezes the game lmao
end

local beat_events = {
	[140] = function()
		runTimer("pause", 0.01)
		
		makeLuaSprite("glitch", "", -1, -1)
		makeGraphic("glitch", 1282, 722, "ff0000")
		setObjectCamera("glitch", "other")
		setBlendMode("glitch", "multiply")
		addLuaSprite("glitch", true)
	end,
	
	[141] = function()
		removeLuaSprite("glitch", true)
	end
}

function onCreatePost()
	setObjectOrder("boyfriendGroup", getObjectOrder("char_RBLXCYC") + 1)
	setObjectOrder("char_krollge", getObjectOrder("boyfriendGroup") + 1)
	setObjectOrder("char_zomb", getObjectOrder("char_krollge") + 1)
end

function onBeatHit()
	if beat_events[curBeat] then
		beat_events[curBeat]()
	end
end

function onTimerCompleted(tag)
	if tag == "pause" then
		pause(crochet / 1000)
	end
end