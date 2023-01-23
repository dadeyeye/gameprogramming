package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Star extends FlxSprite
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var speed : Float;
	var size : Int;
	
	public function new(X:Float, Y:Float, speed:Float )
	{
		super(X, Y);
		
		this.size = FlxG.random.int(0, 2);
		
		this.makeGraphic(1 + size, 1 + size, FlxColor.WHITE);
		this.angle += 45;
		this.speed = speed;
	}
	
	
	function resetPosition():Void
	{
		this.size = FlxG.random.int(0, 2);
		this.x = WIDTH + FlxG.random.int(0, 200);
		this.y = FlxG.random.int(0, HEIGHT);
		this.speed = FlxG.random.int(400, 700);
		this.makeGraphic(1 + size, 1 + size, FlxColor.WHITE);
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		this.x -= this.speed * dt;
		
		
		if (this.x < -1)
		{
			resetPosition();
		}
	}
}