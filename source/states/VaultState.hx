package states;

import backend.WeekData;
import backend.Achievements;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;

import flixel.input.keyboard.FlxKey;
import lime.app.Application;

import openfl.Lib;

import objects.AchievementPopup;
import states.editors.MasterEditorMenu;
import options.OptionsState;

class VaultState extends MusicBeatState
{
   

    public static var vaultVersion:String = '0.3.8';
    public static var curSelected:Int = 0;

    var menuItems:FlxTypedGroup<FlxSprite>;
    private var camGame:FlxCamera;
    private var camAchievement:FlxCamera;
   
    var optionShit:Array<String> = [
        'funny_variants',
        'good_ol_times',
        'disturbing_secrets',
        'happy_day',
		'depressive_cases',
		'time_traveler',
		'non_canon_or_joke_lol',
		'finale'
    ];

   
    var camFollow:FlxObject;

    override function create()
    {
        #if MODS_ALLOWED
        Mods.pushGlobalMods();
        #end
        Mods.loadTopMod();

        #if desktop
        // Updating Discord Rich Presence
        DiscordClient.changePresence("Going onto the v̷̧̓ả̷̚u̴͋͐l̸͇̉t̷̃̿", null);
        if (FlxG.random.bool(0.2))
        {
            Lib.application.window.title = "nigga what you doin here";
        }
        else
        {
            Lib.application.window.title = "Introverse Mod: The vault...";
        }
        #end

        FlxG.mouse.visible = true;

        camGame = new FlxCamera();
        camAchievement = new FlxCamera();
        camAchievement.bgColor.alpha = 0;

        FlxG.cameras.reset(camGame);
        FlxG.cameras.add(camAchievement, false);
        FlxG.cameras.setDefaultDrawTarget(camGame, true);

        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;

        persistentUpdate = persistentDraw = true;

        var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
        bg.antialiasing = ClientPrefs.data.antialiasing;
        bg.scrollFactor.set(0, yScroll);
        bg.setGraphicSize(Std.int(bg.width * 1.175));
        bg.updateHitbox();
        bg.screenCenter();
        //bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

        camFollow = new FlxObject(0, 0, 1, 1);
        add(camFollow);


        menuItems = new FlxTypedGroup<FlxSprite>();
        add(menuItems);

        var scale:Float = 1;

   
        // UI CODE!
        // cat 1
        var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        var menuItem:FlxSprite = new FlxSprite(450, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/funny_variants');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);                                                                                              
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 0;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        var scr:Float = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 0;
        menuItem.scrollFactor.set(0, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // cat 2
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(1200, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/good_ol_times');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 1;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 1;
        menuItem.scrollFactor.set(1, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // cat 3
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(1850, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/disturbing_secrets');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 2;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 2;
        menuItem.scrollFactor.set(2, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // cat 4
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(2500, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/happy_day');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 3;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 3;
        menuItem.scrollFactor.set(3, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

		// cat 5
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(3150, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/depressive_cases');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 4;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 3;
        menuItem.scrollFactor.set(4, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

		// cat 6
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(3800, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/time_traveler');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 5;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 3;
        menuItem.scrollFactor.set(5, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

		// cat 7
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(4450, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/jokes');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 6;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 3;
        menuItem.scrollFactor.set(6, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

		// cat 8
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(5100, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('vault/finale');
        menuItem.animation.addByPrefix('idle', 'ayo', 24);
        menuItem.animation.addByPrefix('selected', 'ayo', 24);
        menuItem.animation.play('idle');
        menuItem.ID = 7;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 3;
        menuItem.scrollFactor.set(7, scr);
        menuItem.screenCenter(X);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // Version Information
        var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Vault Version " + vaultVersion, 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);
    }  

    var selectedSomethin:Bool = false;

    override function update(elapsed:Float)
    {
        if (FlxG.sound.music.volume < 0.8)
        {
            FlxG.sound.music.volume += 0.5 * elapsed;
            if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
        }
        FlxG.camera.followLerp = FlxMath.bound(elapsed * 9 / (FlxG.updateFramerate / 60), 0, 1);

        if (!selectedSomethin)
        {
            if (controls.UI_LEFT_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(-1);
            }

            if (controls.UI_RIGHT_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(1);
            }

            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new MainMenuState());
            }

            if (controls.ACCEPT)
            {
                if (optionShit[curSelected] == 'donate')
                {
                    CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
                }
                else
                {
                    selectedSomethin = true;
                    FlxG.sound.play(Paths.sound('confirmMenu'));

                   

                    menuItems.forEach(function(spr:FlxSprite)
                    
                    {
                        if (curSelected != spr.ID)
                        {
                            FlxTween.tween(spr, {alpha: 0}, 0.4, {
                                ease: FlxEase.quadOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    spr.kill();
                                }
                            });
                        }
                        else
                        {
                            FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                            {
                                var daChoice:String = optionShit[curSelected];

                                switch (daChoice)
                                {
                                    case 'funny_variants':
                                        MusicBeatState.switchState(new FreeplayState1());
                                    case 'good_ol_times':
                                        MusicBeatState.switchState(new FreeplayState2());
                                    case 'disturbing_secrets':
                                        MusicBeatState.switchState(new FreeplayState3());
									case 'happy_day':
										MusicBeatState.switchState(new FreeplayState4());
									case 'depressive_cases':
										MusicBeatState.switchState(new FreeplayState5());
									case 'time_traveler':
										MusicBeatState.switchState(new FreeplayState6());
									case 'non_canon_or_joke_lol':
										MusicBeatState.switchState(new FreeplayState7());
									case 'finale':
										MusicBeatState.switchState(new FreeplayState8());
                                }
                            });
                        }
                    });
                }
            }
        }

        super.update(elapsed);

        menuItems.forEach(function(spr:FlxSprite)
        {
            //spr.screenCenter(X);
        });
        
    }

    function changeItem(huh:Int = 0)
    {
        curSelected += huh;

        if (curSelected >= menuItems.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = menuItems.length - 1;

        menuItems.forEach(function(spr:FlxSprite)
        {
            spr.animation.play('idle');
            spr.updateHitbox();

            if (spr.ID == curSelected)
            {
                spr.animation.play('selected');
                var add:Float = 0;
                if(menuItems.length > 4) {
                    add = menuItems.length * 8;
                }
                camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
                spr.centerOffsets();
            }
        });
    }
}
