package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	
	public static var VOLUME_MUSIC = 0.5;
	public static var VOLUME_SFX = 0.5;
	
	public static var CURRENT_LEVEL = 1;
	
	
	
	public function new()
	{
		super();
		
		addChild(new FlxGame(1366, 768, MenuState));
	}
}