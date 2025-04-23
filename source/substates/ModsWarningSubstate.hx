package substates;

class ModsWarningSubstate extends MusicBeatSubstate
{
	var modList:Array<String>;
	var onYes:Void->Void;

	public function new(modList:Array<String>, onYes:Void->Void)
	{
		super();
		this.modList = modList;
		this.onYes = onYes;
	}

	var yesTxt:Alphabet;
	var noTxt:Alphabet;

	var curSelect:Int = 1;
	var canControl:Bool = false;

	override function create()
	{
		var bg:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		bg.scale.set(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var warningTxt:Alphabet = new Alphabet(FlxG.width / 2, 50, 'WARNING!');
		for (letter in warningTxt.letters)
			letter.color = FlxColor.RED;
		warningTxt.alignment = CENTERED;
		warningTxt.alpha = 0;
		add(warningTxt);

		var descriptionTxt:Alphabet = new Alphabet(FlxG.width / 2, 150,
			'These mods are not recommended' + '\nto be run with other mods.' + '\nDo you want to force them to run?');
		descriptionTxt.setScale(0.6, 0.6);
		descriptionTxt.alignment = CENTERED;
		descriptionTxt.alpha = 0;
		add(descriptionTxt);

		var str:String = '';
		for (i in 0...modList.length)
			if (i == modList.length - 1)
				str += modList[i];
			else
				str += modList[i] + ', ';

		var modTxt:FlxText = new FlxText(0, 0, FlxG.width - 100, str);
		modTxt.setFormat('vcr.ttf', 24, FlxColor.YELLOW, CENTER);
		modTxt.screenCenter(X);
		modTxt.alpha = 0;
		modTxt.y = 430 - modTxt.height / 2;
		add(modTxt);

		yesTxt = new Alphabet(FlxG.width / 2, 575, 'YES');
		yesTxt.alignment = CENTERED;
		yesTxt.alpha = 0;
		yesTxt.x -= 200;
		add(yesTxt);

		noTxt = new Alphabet(FlxG.width / 2, 575, 'NO');
		noTxt.alignment = CENTERED;
		noTxt.alpha = 0;
		noTxt.x += 200;
		add(noTxt);

		FlxG.sound.play(Paths.sound('cancelMenu'));

		FlxTween.tween(bg, {alpha: 0.6}, 0.5, {ease: FlxEase.quartInOut});
		FlxTween.tween(warningTxt, {alpha: 1}, 0.5, {ease: FlxEase.quartInOut});
		FlxTween.tween(descriptionTxt, {alpha: 1}, 0.5, {ease: FlxEase.quartInOut});
		FlxTween.tween(modTxt, {alpha: 1}, 0.5, {ease: FlxEase.quartInOut});
		FlxTween.tween(yesTxt, {alpha: 0.5}, 0.5, {ease: FlxEase.quartInOut, startDelay: 1});
		FlxTween.tween(noTxt, {alpha: 1}, 0.5, {ease: FlxEase.quartInOut, startDelay: 1});

		new FlxTimer().start(1.5, function(_)
		{
			canControl = true;
		});

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (canControl)
		{
			if (controls.UI_LEFT_P)
			{
				changeValue(-1);
			}

			if (controls.UI_RIGHT_P)
			{
				changeValue(-1);
			}

			function _close()
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));

				FlxG.state.persistentUpdate = true;
				close();
			}

			if (controls.BACK)
			{
				_close();
			}

			if (controls.ACCEPT)
			{
				if (curSelect == 0)
				{
					FlxG.state.persistentUpdate = true;
					close();
					onYes();
				}
				else
				{
					_close();
				}
			}
		}

		super.update(elapsed);
	}

	function changeValue(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		curSelect = FlxMath.wrap(curSelect + change, 0, 1);

		if (curSelect == 0)
		{
			yesTxt.alpha = 1;
			noTxt.alpha = 0.5;
		}
		else
		{
			yesTxt.alpha = 0.5;
			noTxt.alpha = 1;
		}
	}
}
