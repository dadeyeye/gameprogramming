package;

import flixel.FlxSprite;
import flixel.FlxG;

class ParallaxBackground extends FlxSprite
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var direction : String;
	
	var speed : Float;
	
	
	var duplicateSprite : FlxSprite;
	
	public function getDuplicateSprite():FlxSprite return duplicateSprite;
	
	public function new(X:Float, Y:Float,path:String,direction:String,speed:Float)
	{
		super(X, Y);
		
		loadGraphic(path);
		
		this.direction = direction;
		this.speed = speed;
		
		
		duplicateSprite = new FlxSprite(this.x + this.width, this.y, path);
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		if (this.direction == "right")
		{
			this.x -= speed * dt;
			
			if ( this.x + this.width < 0)
			{
				this.x = WIDTH;
			
			}
			
			
			duplicateSprite.x -= speed * dt;
			
			if (duplicateSprite.x + duplicateSprite.width < 0)
			{
				duplicateSprite.x = WIDTH;
			}
			
		}
		
		if (this.direction == "left")
		{
			this.x += speed * dt;
		}
		
	}
}