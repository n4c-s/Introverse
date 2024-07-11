// LANGUAGE SUPPORT !!!!11!!!!!1
package options;

import lime.app.Application;
import openfl.Lib;

class LanguageSubState extends MusicBeatSubstate 
{
	public var langs:Array<String> = [
		'English', 'Español', 'Español (Chile)'
	];

	public function new() 
	{
		super();

		#if desktop
		if (FlxG.random.bool(0.2)) 
		{
			Lib.application.window.title = "OK, i understand you don't talk english, but please learn it";
		}
		else if (FlxG.random.bool(0.05))
		{
			Lib.application.window.title = "mira march soy brasileño *gemidos*";
		};
		else
		{
			Lib.application.window.title = "Introverse Mod: Options: Changing Language";
		}
		#end

		var versionShit:FlxText = new FlxText(12, FlxG.height - 512, 1200, "Unfinished menu!!!");
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);

		super();
	}

	override function update(elapsed:Float) 
	{
		if (controls.BACK) {
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			close();
			return;
		}

		super.update(elapsed);
	}
}