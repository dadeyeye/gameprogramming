package;

import flixel.FlxSprite;
import flixel.system.FlxSound;

import flixel.FlxG;

class Shoot extends FlxSprite
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var type:String;
	
	private var speed : Float;
	
	var canMove:Bool = false;
	
	var damage:Int;
	
	var sound_shoot : FlxSound;
	
	public function new(X:Float, Y:Float, type:String) 
	{
		super(X, Y);
		
		//  "player" or "enemy" damage
		
		if (type == "player")
		{
			this.loadGraphic("assets/images/shoot/Bullet2.png", true, 32, 32);
			this.animation.add("fire", [0, 1, 2, 3, 4], 10, true);
			
			this.type = type;
			this.speed = 800;
			this.damage = 1;
			
			this.animation.play("fire");
			
			this.sound_shoot = FlxG.sound.load("assets/sounds/shoot01.ogg", Main.VOLUME_SFX);
			
		}
		
		else if (type == "enemy")
		{
			this.loadGraphic("assets/images/shoot/Bullet3.png", true, 32, 32);
			this.animation.add("fire", [0, 1, 2, 3], 10, true);
			
			this.type = type;
			this.speed = 1200;
			this.damage = 2;
			
			this.animation.play("fire");
		
			this.sound_shoot = FlxG.sound.load("assets/sounds/shoot01.ogg", Main.VOLUME_SFX);
		}
		
		else if (type == "boss")
		{
			this.loadGraphic("assets/images/shoot/plasmaball.png", true, 128, 128);
			this.animation.add("fire", [0, 1, 2, 3], 10, true);
			
			this.type = type;
			this.speed = 1500;
			this.damage = 4;
			
			this.animation.play("fire");
		}
		
	}
	
	public function getCanMove():Bool return this.canMove;
	public function setCanMove(canMove:Bool):Void this.canMove = canMove;
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		
		// shooting command : 
		
		
		if (this.type == "player")
		{
			if (FlxG.keys.justPressed.SPACE)
			{
				
				this.canMove = true;
				sound_shoot.play(true);
		
			}
		}
		
		if (this.type == "boss")
		{
			this.canMove = true;
		}
		
		// shoot speed : 
		
		if (canMove) 
		{
			if (this.type == "player") this.x += this.speed * dt;
			
			else if (this.type == "enemy") this.x -= this.speed * dt;
			
			else if (this.type == "boss") this.x -= this.speed * dt;
		}
		
		
		// destruction due to shot : 
		
		if (this.x > WIDTH + 20) this.destroy();
		
		if (this.x < - 20) this.destroy;
	}
}