package debug;

import flixel.FlxG;
import openfl.text.TextField;
import openfl.text.TextFormat;
import lime.system.Clipboard;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
class FPSCounter extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	/**
		The current memory usage (WARNING: this is NOT your total program memory usage, rather it shows the garbage collector memory)
	**/
	public var memoryMegas(get, never):Float;

	/**
		アプリの最大のメモリ使用量
	**/
	public var maxMemoryMegas:Float;

	/**
		Windowsの最大メモリ (搭載RAM容量)
	**/
	var maxWindowsMemory:Float;

	/**
		Windowsのバージョン
	**/
	var windowsVersion:String;

	/**
		WindowsのCPUの名前
	**/
	var windowsCPU:String;

	/**
		WindowsのGPUの名前
	**/
	var windowsGPU:String;

	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = true;
		mouseEnabled = true;
		defaultTextFormat = new TextFormat("_sans", 14, color);
		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		times = [];

		if (FlxG.save.data.displayDebugType != null)
			curDisplay = FlxG.save.data.displayDebugType;

		maxWindowsMemory = Main.getMaxWindowsMemory();
		windowsVersion = Main.getWindowsVersion();
		windowsCPU = Main.getCpuName();
		windowsGPU = Main.getGpuName();
	}

	var deltaTimeout:Float = 0.0;

	// Event Handlers
	private override function __enterFrame(deltaTime:Float):Void
	{
		#if desktop
		if (Controls.instance.justPressed('debug_3'))
		{
			curDisplay = FlxMath.wrap(curDisplay + 1, 0, 2);

			FlxG.save.data.displayDebugType = curDisplay;
			FlxG.save.flush();
		}			
		#end
		
		final now:Float = haxe.Timer.stamp() * 1000;
		times.push(now);
		while (times[0] < now - 1000)
			times.shift();
		// prevents the overlay from updating every frame, why would you need to anyways @crowplexus
		if (deltaTimeout < 50)
		{
			deltaTimeout += deltaTime;
			return;
		}

		currentFPS = times.length < FlxG.updateFramerate ? times.length : FlxG.updateFramerate;
		updateText();
		deltaTimeout = 0.0;

		if (FlxG.mouse.x >= x && FlxG.mouse.x <= x + width && FlxG.mouse.y >= y && FlxG.mouse.y <= y + height)
			alpha = 1;
		else
			alpha = 0.75;
	}

	public static var curDisplay:Int = 0;

	public dynamic function updateText():Void
	{
		// so people can override it in hscript
		switch (curDisplay)
		{
			case 0:
				text = 'FPS: ${currentFPS}'
					+ '\nMemory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)} / ${flixel.util.FlxStringUtil.formatBytes(maxMemoryMegas)}'
					+ '\nState: ${Type.getClassName(Type.getClass(FlxG.state))}'
					+ '\n'
					+ '\nMax Caption Memory: ${flixel.util.FlxStringUtil.formatBytes(maxWindowsMemory)}'
					+ '\nCaption: ${windowsVersion}'
					+ '\n'
					+ '\nCPU: ${windowsCPU}'
					+ '\nGPU: ${windowsGPU}';
			case 1:
				text = 'FPS: ${currentFPS}'
					+ '\nMemory: ${flixel.util.FlxStringUtil.formatBytes(memoryMegas)} / ${flixel.util.FlxStringUtil.formatBytes(maxMemoryMegas)}';
			case 2:
				text = '';
		}

		textColor = 0xFFFFFFFF;
		if (currentFPS < FlxG.drawFramerate * 0.5)
			textColor = 0xFFFF0000;

		if (memoryMegas > maxMemoryMegas)
			maxMemoryMegas = memoryMegas;
	}

	inline function get_memoryMegas():Float
		return cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
}
