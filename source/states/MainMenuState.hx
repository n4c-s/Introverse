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

class MainMenuState extends MusicBeatState
{
    public static var hoveringNow:Bool = false;

    // discarded code
    var starData:Array<Dynamic> = [SaveVariables.storySave[0], SaveVariables.storySave[1]];

    public static var introverseVersion:String = ' 0.7.2 build 103';
    public static var psychEngineVersion:String = '0.7.INTROVERSE';
    public static var curSelected:Int = 0;

    // sum discarded shit too
    public var menuLevelPostions:Array<Dynamic> = [
        0 => '450, 300',
        1 => '300, 300',
        2 => '650, 300'
    ];

    var menuItems:FlxTypedGroup<FlxSprite>;
    private var camGame:FlxCamera;
    private var camAchievement:FlxCamera;
   
    var optionShit:Array<String> = [
        'story_mode',
        //'freeplay',
        'vault',
        'credits',
        'options'
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
        DiscordClient.changePresence("Checking What to do", null);
        if (FlxG.random.bool(0.2))
            {
                Lib.application.window.title = "so, ya explorin the mod? good, i like dat";
            }
            else
            {
                Lib.application.window.title = "Introverse Mod: Menu";
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
        // Story Mode
        var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        var menuItem:FlxSprite = new FlxSprite(300, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_play');
        menuItem.animation.addByPrefix('idle', "PLAY", 24);
        menuItem.animation.addByPrefix('selected',  "YALP", 24);
        menuItem.animation.play('idle');
        menuItem.ID = 0;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        var scr:Float = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 0;
        menuItem.scrollFactor.set(0, scr);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // FreePlay Mode
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(650, 300);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[1]);
        menuItem.animation.addByPrefix('idle', "white", 24);
        menuItem.animation.addByPrefix('selected', "idle", 24);
        menuItem.animation.play('idle');
        menuItem.ID = 1;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 1;
        menuItem.scrollFactor.set(1, scr);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // Credits
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(250, 400);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[2]);
        menuItem.animation.addByPrefix('idle', optionShit[2] + " basic", 24);
        menuItem.animation.addByPrefix('selected', optionShit[2] + " white", 24);
        menuItem.animation.play('idle');
        menuItem.ID = 2;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 2;
        menuItem.scrollFactor.set(2, scr);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();

        // Options
        offset = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
        menuItem = new FlxSprite(650, 400);
        menuItem.scale.x = scale * 2;
        menuItem.scale.y = scale * 2;
        menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[3]);
        menuItem.animation.addByPrefix('idle', optionShit[3] + " basic", 24);
        menuItem.animation.addByPrefix('selected', optionShit[3] + " white", 24);
        menuItem.animation.play('idle');
        menuItem.ID = 3;
        menuItem.setGraphicSize(Std.int(menuItem.width * 0.70));
        menuItems.add(menuItem);
        scr = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6) scr = 3;
        menuItem.scrollFactor.set(3, scr);
        //menuItem.antialiasing = ClientPrefs.globalAntialiasing;
        menuItem.updateHitbox();




        // Version Information
        var versionShit:FlxText = new FlxText(12, FlxG.height - 64, 0, "Introverse v" + introverseVersion, 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);

        var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);

        var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
        versionShit.scrollFactor.set();
        versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(versionShit);  
        changeItem();
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

            #if optionShit = 'vault' (controls.UI_DOWN_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(optionShit['options']);
            }
            #end
            
            #if optionShit = 'story_mode' (controls.UI_DOWN_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(optionShit['credits']);
            }
            #end

            #if optionShit = 'options' (controls.UI_UP_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(optionShit['vault']);
            }
            #end

            #if optionShit = 'credits' (controls.UI_UP_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeItem(optionShit['story_mode']);
            }
            #end

            if (controls.BACK)
            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new TitleState());
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
                                    case 'story_mode':
                                        MusicBeatState.switchState(new StoryMenuState());
                                    case 'vault':
                                        MusicBeatState.switchState(new VaultState());
                                    case 'credits':
                                        MusicBeatState.switchState(new CreditsState());
                                    case 'options':
                                        LoadingState.loadAndSwitchState(new OptionsState());
                                        OptionsState.onPlayState = false;
                                        if (PlayState.SONG != null)
                                        {
                                            PlayState.SONG.arrowSkin = null;
                                            PlayState.SONG.splashSkin = null;
                                        }
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
