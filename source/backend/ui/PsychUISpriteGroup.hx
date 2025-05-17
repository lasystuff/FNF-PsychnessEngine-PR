package backend.ui;

class PsychUISpriteGroup extends FlxSpriteGroup
{
	public var descriptionBox:PsychUIDescription;
	public var description(default, set):String = '';

	public function new(x:Float, y:Float)
	{
		super(x, y);

		descriptionBox = new PsychUIDescription(0, 0, description);
		descriptionBox.visible = false;
		states.editors.ChartingState.instance.descriptionGroup.add(descriptionBox);
	}

	var _overlapTimer:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this, camera))
			_overlapTimer += elapsed;
		else
			_overlapTimer = 0;

		if (_overlapTimer > 0.4 && !(FlxG.mouse.overlaps(this, camera) && FlxG.mouse.justPressed))
		{
			if (description.length < 1)
				return;

			if (!descriptionBox.visible)
			{
				descriptionBox.x = FlxG.stage.mouseX + 15;
				descriptionBox.y = FlxG.stage.mouseY + 15;
			}

			descriptionBox.visible = true;
		}
		else
			descriptionBox.visible = false;
	}

	function set_description(v:String)
	{
		descriptionBox.description = v;
		return (description = v);
	}
}
