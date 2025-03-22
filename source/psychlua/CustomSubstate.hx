package psychlua;

import flixel.FlxObject;

class CustomSubstate extends MusicBeatSubstate
{
	public static var name:String = 'unnamed';
	public static var instance:CustomSubstate;

	#if LUA_ALLOWED
	public static function implement(funk:FunkinLua)
	{
		var lua = funk.lua;
		Lua_helper.add_callback(lua, "openCustomSubstate", openCustomSubstate);
		Lua_helper.add_callback(lua, "closeCustomSubstate", closeCustomSubstate);
		Lua_helper.add_callback(lua, "insertToCustomSubstate", insertToCustomSubstate);
	}
	#end
	
	public static function openCustomSubstate(name:String, ?pauseGame:Bool = false)
	{
		if(pauseGame)
		{
			FlxG.camera.followLerp = 0;
			MusicBeatState.instance.persistentUpdate = false;
			MusicBeatState.instance.persistentDraw = true;
			if (PlayState.instance != null)
			{
				PlayState.instance.paused = true;
				if(FlxG.sound.music != null) {
					FlxG.sound.music.pause();
					PlayState.instance.vocals.pause();
				}
			}
		}
		if (PlayState.instance != null)
			PlayState.instance.openSubState(new CustomSubstate(name));
		else
			MusicBeatState.instance.openSubState(new CustomSubstate(name));
	}

	public static function closeCustomSubstate()
	{
		if(instance != null)
		{
			if (PlayState.instance != null)
				PlayState.instance.closeSubState();
			else
				MusicBeatState.instance.closeSubState();
			return true;
		}
		return false;
	}

	public static function insertToCustomSubstate(tag:String, ?pos:Int = -1)
	{
		if(instance != null)
		{
			var tagObject:FlxObject = cast (MusicBeatState.getVariables().get(tag), FlxObject);

			if(tagObject != null)
			{
				if(pos < 0) instance.add(tagObject);
				else instance.insert(pos, tagObject);
				return true;
			}
		}
		return false;
	}

	override function create()
	{
		instance = this;
		MusicBeatState.instance.setOnHScript('customSubstate', instance);


		MusicBeatState.instance.callOnScripts('onCustomSubstateCreate', [name]);
		super.create();
		MusicBeatState.instance.callOnScripts('onCustomSubstateCreatePost', [name]);
	}
	
	public function new(name:String)
	{
		CustomSubstate.name = name;
		MusicBeatState.instance.setOnHScript('customSubstateName', name);
		super();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}
	
	override function update(elapsed:Float)
	{
		MusicBeatState.instance.callOnScripts('onCustomSubstateUpdate', [name, elapsed]);
		super.update(elapsed);
		MusicBeatState.instance.callOnScripts('onCustomSubstateUpdatePost', [name, elapsed]);
	}

	override function destroy()
	{
		MusicBeatState.instance.callOnScripts('onCustomSubstateDestroy', [name]);
		instance = null;
		name = 'unnamed';

		MusicBeatState.instance.setOnHScript('customSubstate', null);
		MusicBeatState.instance.setOnHScript('customSubstateName', name);
		super.destroy();
	}
}
