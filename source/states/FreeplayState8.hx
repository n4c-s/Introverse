package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import objects.HealthIcon;
import objects.MusicPlayer;

import openfl.Lib;

import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

import flixel.math.FlxMath;

class FreeplayState8 extends MusicBeatState
{
    private var songs:Array<SongMetadata8> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var lerpSelected:Float = 0;
	var curDifficulty:Int = -1;
	private static var lastDifficultyName:String = Difficulty.getDefault();

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxSprite;
	var intendedColor:Int;
	var colorTween:FlxTween;

	var missingTextBG:FlxSprite;
	var missingText:FlxText;

	var bottomString:String;
	var bottomText:FlxText;
	var bottomBG:FlxSprite;

	var player:MusicPlayer;

        override function create()
        {
            //Paths.clearStoredMemory();
		    //Paths.clearUnusedMemory();
		
		    #if desktop
		    Lib.application.window.title = 'Introverse Mod: Vault: F1N?L3';
		    #end

            bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		    bg.antialiasing = ClientPrefs.data.antialiasing;
		    add(bg);
		    bg.screenCenter();

			var versionShit:FlxText = new FlxText(12, FlxG.height - 512, 1250, "F1N4L3333??????????????????");
        	versionShit.scrollFactor.set();
        	versionShit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        	add(versionShit);
        }

		var instPlaying:Int = -1;
		public static var vocals:FlxSound = null;
		override function update(elapsed:Float)
        {
            if (controls.BACK)
                /* commenting this until finishing vault
                {
                    if (player.playingMusic)
                    {
                        FlxG.sound.music.stop();
                        destroyFreeplayVocals();
                        FlxG.sound.music.volume = 0;
                        instPlaying = -1;
        
                        player.playingMusic = false;
                        player.switchPlayMusic();
        
                        FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
                        FlxTween.tween(FlxG.sound.music, {volume: 1}, 1);
                    }
                    else*/ 
                    {
                        persistentUpdate = false;
                        if(colorTween != null) {
                            colorTween.cancel();
                        }
                        FlxG.sound.play(Paths.sound('cancelMenu'));
                        MusicBeatState.switchState(new VaultState());
                    
                }
                
                
                super.update(elapsed);
        }

		public static function destroyFreeplayVocals() {
			if(vocals != null) {
				vocals.stop();
				vocals.destroy();
			}
			vocals = null;
		}
        
}

class SongMetadata8
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";
	public var lastDifficulty:String = null;

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Mods.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}
 