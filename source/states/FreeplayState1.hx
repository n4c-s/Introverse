package states;

import backend.WeekData;
import backend.Highscore;
import backend.Song;

import openfl.Lib;

import objects.HealthIcon;
import objects.MusicPlayer;

import substates.GameplayChangersSubstate;
import substates.ResetScoreSubState;

import flixel.math.FlxMath;

class FreeplayState1 extends MusicBeatState
{
    private var songs:Array<SongMetadata1> = [];

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
		    Lib.application.window.title = 'Introverse Mod: Vault: Funny Variants';
		    #end

            bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		    bg.antialiasing = ClientPrefs.data.antialiasing;
		    add(bg);
		    bg.screenCenter();

			var versionShit:FlxText = new FlxText(12, FlxG.height - 512, 1250, "Funny Variants");
        	versionShit.scrollFactor.set();
        	versionShit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        	add(versionShit);

			grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(90, 320, songs[i].songName, true);
			songText.targetY = i;
			grpSongs.add(songText);

			songText.scaleX = Math.min(1, 980 / songText.width);
			songText.snapToPosition();

			Mods.currentModDirectory = songs[i].folder;
			var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
			icon.sprTracker = songText;

			
			// too laggy with a lot of songs, so i had to recode the logic for it
			songText.visible = songText.active = songText.isMenuItem = false;
			icon.visible = icon.active = false;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);

			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
			WeekData.setDirectoryFromWeek();

			addSong('ickkck', 0, 'pene', 0xFF000000);
        }

		override function closeSubState() {
			persistentUpdate = true;
			super.closeSubState();
		}

		function changeSelection(change:Int = 0, playSound:Bool = true)
			{
				_updateSongLastDifficulty();
				if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		
				var lastList:Array<String> = Difficulty.list;
				curSelected += change;
		
				if (curSelected < 0)
					curSelected = songs.length - 1;
				if (curSelected >= songs.length)
					curSelected = 0;
					
				var newColor:Int = songs[curSelected].color;
				if(newColor != intendedColor) {
					if(colorTween != null) {
						colorTween.cancel();
					}
					intendedColor = newColor;
					colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
						onComplete: function(twn:FlxTween) {
							colorTween = null;
						}
					});
				}
		
				// selector.y = (70 * curSelected) + 30;
			}

		public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
			{
				songs.push(new SongMetadata1(songName, weekNum, songCharacter, color));
			}

		inline private function _updateSongLastDifficulty()
			{
				songs[curSelected].lastDifficulty = Difficulty.getString(curDifficulty);
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

class SongMetadata1
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


 