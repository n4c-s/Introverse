package options;

import openfl.Lib;

import objects.Note;
import objects.StrumNote;
import objects.Alphabet;

class LanguageSubState extends BaseOptionsMenu
{

	public var langs:Array<String> = [
		'English', 'Español', 'Español (Chile)'
	];

	var curSelected:Int = 0;

	public function new()
	{
		title = 'Language';
		#if desktop
		if (FlxG.random.bool(0.2)) 
		{
			Lib.application.window.title = "OK, i understand you don't talk english, but please learn it";
		}
		else if (FlxG.random.bool(0.05))
		{
			rpctitle = 'holaaaa';
			Lib.application.window.title = "mira march soy brasileño";
		}
		else
		{
			rpctitle = 'Changing Language';
			Lib.application.window.title = "Introverse Mod: Options: Changing Language";
		}
		#end
		
		var idiomasPutos:Array<String> = Mods.mergeAllTextsNamed('data/langs.txt');
		if(idiomasPutos.length > 0)
		{
			if(!idiomasPutos.contains(ClientPrefs.data.laPutaVariableDelIdioma))
				ClientPrefs.data.laPutaVariableDelIdioma = ClientPrefs.defaultData.laPutaVariableDelIdioma;

			idiomasPutos.insert(0, ClientPrefs.defaultData.laPutaVariableDelIdioma);
			var englishOption:Option = new Option('Language:',
				"Select your preferred or native language if you want.",
				'laPutaVariableDelIdioma',
				'string',
				idiomasPutos);

			var spanishOption:Option = new Option('Idioma:',
				"Selecciona tu idioma de preferencia o nativo.",
				'laPutaVariableDelIdioma',
				'string',
				idiomasPutos);

			var chileOption:Option = new Option('Idioma:',
				"Deja tu idioma preferio' o elije el de chilito el mejor pais de chile.",
				'laPutaVariableDelIdioma',
				'string',
				idiomasPutos);

			var selectorIdioma:String = idiomasPutos[curSelected];

			switch (selectorIdioma) {
				case "english":
					addOption(englishOption);
				case "spanish":
					addOption(spanishOption);
				case "spanishChile":
					addOption(chileOption);
			};
		}

		super();
	}

	override function changeSelection(change:Int = 0)
	{
		super.changeSelection(change);
		
		if(noteOptionID < 0) return;

		for (i in 0...Note.colArray.length)
		{
			var note:StrumNote = notes.members[i];
			if(notesTween[i] != null) notesTween[i].cancel();
			if(curSelected == noteOptionID)
				notesTween[i] = FlxTween.tween(note, {y: noteY}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
			else
				notesTween[i] = FlxTween.tween(note, {y: -200}, Math.abs(note.y / (200 + noteY)) / 3, {ease: FlxEase.quadInOut});
		}
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.data.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic && !OptionsState.onPlayState) FlxG.sound.playMusic(Paths.music('freakyMenu'), 1, true);
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.data.showFPS;
	}
	#end
}
