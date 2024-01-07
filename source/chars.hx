import StringTools;

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