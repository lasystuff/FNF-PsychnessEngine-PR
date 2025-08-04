package flixel.system.ui;

#if FLX_SOUND_SYSTEM
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
#if flash
import openfl.text.AntiAliasType;
import openfl.text.GridFitType;
#end
import flixel.math.FlxMath;
import openfl.media.Sound;

/**
 * The flixel sound tray, the little volume meter that pops down sometimes.
 */
class FlxSoundTray extends Sprite
{
	// Static variables for sound effects
	public static var volumeChangeSFX:Sound = null;
	public static var volumeMaxChangeSFX:Sound = null;
	public static var volumeUpChangeSFX:Sound = null;
	public static var volumeDownChangeSFX:Sound = null;
	public static var silent:Bool = false;

	// Instance variables
	public var text:TextField = new TextField();

	var _dtf:TextFormat;

	public var active:Bool;

	var _timer:Float;
	var _bars:Array<Bitmap>;
	var _bx:Int = 10;
	var _by:Int = 14;

	public var barsAmount(default, set):Int = 10;

	@:dox(hide) public function set_barsAmount(value:Int):Int
	{
		barsAmount = value;
		return value;
	}

	public var background:Bitmap;
	public var meter:Bitmap;

	@:isVar var _width(get, set):Int = 80;
	@:isVar var _height(get, set):Int = 30;

	@:dox(hide) public function get__width():Int
	{
		if (background != null)
			_width = Math.round(background.width); // Must round this to an Int to keep backwards compatibility  - Nex
		return _width;
	}

	@:dox(hide) public function set__width(value:Int):Int
	{
		if (background != null)
			background.width = value;
		return _width = value;
	}

	@:dox(hide) public function get__height():Int
	{
		if (background != null)
			_height = Math.round(background.height); // Must round this to an Int to keep backwards compatibility  - Nex
		return _height;
	}

	@:dox(hide) public function set__height(value:Int):Int
	{
		if (background != null)
			background.height = value;
		return _height = value;
	}

	var _defaultScale:Float = 2.0;
	var isFront:Bool = false;
	var isHolding:Bool = false;

	// Constructor

	@:keep
	public function new()
	{
		super();
		background = new Bitmap(new BitmapData(_width, _height, true, FlxColor.BLACK));
		background.alpha = 0.5;
		addChild(background);

		var meterBG:Bitmap = new Bitmap(new BitmapData(_width - 10, 5, true, 0x50000000));
		meterBG.x = 5;
		meterBG.y = background.y + background.height - meterBG.height - 5;
		addChild(meterBG);

		meter = new Bitmap(new BitmapData(Std.int(meterBG.width), Std.int(meterBG.height), true, 0xFFFFFFFF));
		meter.x = meterBG.x;
		meter.y = meterBG.y;
		addChild(meter);

		reloadText(false);
		screenCenter();
		y = -height;
		active = true;
		isFront = false;
	}

	// Reloads the text of the sound tray
	public function reloadText(checkIfNull:Bool = true, reloadDefaultTextFormat:Bool = true, displayTxt:String = "VOLUME", y:Float = 16):Void
	{
		if (checkIfNull && text != null)
		{
			removeChild(text);
			@:privateAccess text.__cleanup();
		}

		text = new TextField();
		text.width = _width;
		text.height = _height;
		text.multiline = true;
		text.wordWrap = true;
		text.selectable = false;

		#if flash
		text.embedFonts = true;
		text.antiAliasType = AntiAliasType.NORMAL;
		text.gridFitType = GridFitType.PIXEL;
		#end
		if (reloadDefaultTextFormat)
			reloadDtf();

		text.defaultTextFormat = _dtf;
		addChild(text);
		text.text = displayTxt;
		text.y = 3.5;
	}

	// Reloads the default text format
	public function reloadDtf():Void
	{
		_dtf = new TextFormat(openfl.utils.Assets.getFont(Paths.font('HackGenConsoleNF-Regular.ttf')).fontName, 8, 0xffffff);
		_dtf.align = TextFormatAlign.CENTER;
	}

	// Regenerates the bars array
	public function regenerateBarsArray():Void
	{
		if (_bars == null)
		{
			_bars = new Array();
		}
		else
		{
			for (bar in _bars)
			{
				_bars.remove(bar);
				removeChild(bar);
				bar.bitmapData.dispose();
			}
		}
	}

	// Updates the sound tray
	public function update(MS:Float):Void
	{
		_timer -= MS / 1000;

		if (_timer < 0)
		{
			isFront = false;
		}

		if (isFront)
		{
			y = FlxMath.lerp(10, y, Math.exp(-FlxG.elapsed * 6));
			alpha = FlxMath.lerp(1, alpha, Math.exp(-FlxG.elapsed * 6));
		}
		else
		{
			y = FlxMath.lerp(-height, y, Math.exp(-FlxG.elapsed * 6));
			alpha = FlxMath.lerp(0, alpha, Math.exp(-FlxG.elapsed * 6));
		}

		if (_timer < 0.5)
		{
			if (FlxG.keys.anyPressed(FlxG.sound.volumeUpKeys))
			{
				isFront = true;
				FlxG.sound.volume += 0.01;
				_timer = 0.5;
			}

			if (FlxG.keys.anyPressed(FlxG.sound.volumeDownKeys))
			{
				isFront = true;
				FlxG.sound.volume -= 0.01;
				_timer = 0.5;
			}

			if (FlxG.keys.anyJustReleased(FlxG.sound.volumeUpKeys))
			{
				_timer = 1;
				saveSoundPreferences();
			}

			if (FlxG.keys.anyJustReleased(FlxG.sound.volumeDownKeys))
			{
				_timer = 1;
				saveSoundPreferences();
			}
		}

		meter.scaleX = FlxMath.lerp(FlxG.sound.volume, meter.scaleX, Math.exp(-FlxG.elapsed * 6));
		meter.alpha = FlxG.sound.muted ? 0.5 : 1;
	}

	// Saves the sound preferences
	public function saveSoundPreferences():Void
	{
		FlxG.save.data.mute = FlxG.sound.muted;
		FlxG.save.data.volume = FlxG.sound.volume;
		FlxG.save.flush();
	}

	// Shows the sound tray
	public function show(up:Bool = false):Void
	{
		var globalVolume:Int = FlxG.sound.muted ? 0 : Math.round(FlxG.sound.volume * barsAmount);

		_timer = 1;
		isFront = true;

		if (!silent)
		{
			var sound = up ? (globalVolume >= barsAmount
				&& volumeMaxChangeSFX != null ? volumeMaxChangeSFX : volumeUpChangeSFX) : volumeDownChangeSFX;
			if (sound == null)
				sound = volumeChangeSFX;
			if (sound != null)
				FlxG.sound.load(sound).play();
			else
				FlxG.sound.load(FlxAssets.getSound('flixel/sounds/beep')).play();
		}

		saveSoundPreferences();
	}

	// Centers the sound tray on the screen
	public function screenCenter():Void
	{
		scaleX = _defaultScale;
		scaleY = _defaultScale;
		x = (0.5 * (Lib.current.stage.stageWidth - _width * _defaultScale) - FlxG.game.x);
	}
}
#end
