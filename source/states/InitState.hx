package states;

class InitState extends MusicBeatState
{
	override function create()
	{
		FlxG.sound.playMusic(Paths.music(MainMenuState.menuSong), 0);

		ClientPrefs.loadPrefs();
		Language.reloadPhrases();
		MusicBeatState.resetStateMap();

		if (FlxG.save.data != null && FlxG.save.data.fullscreen)
		{
			FlxG.fullscreen = FlxG.save.data.fullscreen;
			// trace('LOADED FULLSCREEN SETTING!!');
		}
		persistentUpdate = true;
		persistentDraw = true;

		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;

		FlxG.mouse.visible = false;

		initScripts(Paths.getSharedPath(), 'scripts/');
		initScripts(Paths.getSharedPath(), 'scripts/states/InitState/');

		MusicBeatState.switchState(MusicBeatState.getClassFromStateMap("TitleState"));

		super.create();

		callOnScripts('onCreatePost');
	}

	override function update(elapsed:Float)
	{
		callOnScripts('onUpdate', [elapsed]);
		super.update(elapsed);
		callOnScripts('onUpdatePost', [elapsed]);
	}
}
