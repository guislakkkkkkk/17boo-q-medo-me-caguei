import StringTools;

var walkin = false;
var jank_start = 710;
var jank = new Character(jank_start, -80, "jank", true);
game.startCharacterPos(jank, true);
game.add(jank);

var RBLXCYC = new Character(950, -200, "RBLXCYC", true);
game.startCharacterPos(RBLXCYC, true);
game.add(RBLXCYC);

var krollge = new Character(920, -230, "krollge", true);
game.startCharacterPos(krollge, true);
game.add(krollge);

var zomb = new Character(1490, 30, "zomb", true);
game.startCharacterPos(zomb, true);
game.add(zomb);

var chars = [
	"char_jank" => jank,
	"char_RBLXCYC" => RBLXCYC,
	"char_krollge" => krollge,
	"char_zomb" => zomb
];

for (name in chars.keys()) {
	game.variables.set(name, chars[name]);
}

function onCreatePost() {
	for (note in game.unspawnNotes) {
		for (name in chars.keys()) {
			if (note.noteType == name) {
				note.noAnimation = true;
				note.noMissAnimation = true;
			}
		}
	}
}

function onCountdownStarted() {
	new FlxTimer().start(Conductor.crochet / 1000 / game.playbackRate, function(tmr) {
		for (char in chars) {
			if (tmr.loopsLeft % char.danceEveryNumBeats == 0 && char.animation.curAnim != null && !StringTools.startsWith(char.animation.curAnim.name, "sing") && !char.stunned) {
				char.dance();
			}
		}
	}, 5);
}

function onBeatHit(){
	for (char in chars) {
		if (curBeat % char.danceEveryNumBeats == 0 && char.animation.curAnim != null && !StringTools.startsWith(char.animation.curAnim.name, "sing") && !char.stunned) {
			if (char != jank) {
				char.dance();
			} else if (!walkin) {
				char.dance();
			}
		}
	}
}

function goodNoteHit(note) {
	if (chars[note.noteType] != null) {
		var char = chars[note.noteType];
		var anim = ["singLEFT", "singDOWN", "singUP", "singRIGHT"][note.noteData % 4];
		char.playAnim(anim, true);
		char.holdTimer = 0;
		
		if (char == jank) {
			walkin = false;
			
			jank.flipX = false;
			
			if (anim == "singRIGHT") {
				jank.velocity.x = 500;
			} else {
				jank.velocity.x = 0;
			}
		}
	}
}

function noteMiss(note) {
	if (chars[note.noteType] != null) {
		var char = chars[note.noteType];
		var anim = ["singLEFT", "singDOWN", "singUP", "singRIGHT"][note.noteData % 4] + "miss";
		if (!char.animOffsets.exists(anim)) {
			char.playAnim("idle", true);
		} else {
			char.playAnim(anim, true);
		}
		
		char.holdTimer = 0;
		
		if (char == jank) {
			walkin = false;
			
			jank.flipX = false;
			jank.velocity.x = 0;
		}
	}
}

function onUpdatePost() {
	if (game.generatedMusic && !game.inCutscene && game.startedCountdown) {
		for (char in chars) {
			if (!char.stunned && char.animation.curAnim != null && char.holdTimer > Conductor.stepCrochet * (0.0011 / FlxG.sound.music.pitch) * char.singDuration && StringTools.startsWith(char.animation.curAnim.name, "sing") && !StringTools.endsWith(char.animation.curAnim.name, "miss")) {
				if (char != jank) {
					char.dance();
				} else if (!walkin) {
					char.dance();
				}
			}
		}
		
		if (jank.x < jank_start) {
			walkin = false;
			
			jank.playAnim("idle", true);
			
			jank.flipX = false;
			jank.velocity.x = 0;
			jank.x = jank_start;
		} else if (jank.x > jank_start && jank.animation.curAnim.name == "idle") {
			walkin = true;
			
			jank.playAnim("singRIGHT", true);
			
			jank.flipX = true;
			jank.velocity.x = -500;
		}
	}
}
