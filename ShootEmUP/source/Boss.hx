package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;


class Boss extends FlxSprite
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var TILE_SIZE : Int = 128;
	
	var speed_x : Float = 90;
	var speed_y : Float = 700;
	
	
	var total_HP : Int = 30;
	var current_HP : Int = 30;
	
	var scaleBase : Float = 1.0;
	
	var animation_state : String = "increment";
	
	
	// Plasma : 
	var sound_plasma : FlxSound;

	var timerPlasmaMax:Float = 1.0;
	var timerPlasma:Float = 1.0;
	var canFirePlasma:Bool = false;
	
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		this.loadGraphic("assets/images/boss/Godfather.png", true, this.TILE_SIZE, this.TILE_SIZE);
		
		this.animation.add("move", [0, 1, 2, 3, 4], 7, true);
		
		this.animation.play("move");
		
		
		
		//sound settings
		this.sound_plasma = FlxG.sound.load("assets/sounds/plasma.ogg", Main.VOLUME_SFX);
	}
	
	// health control : 
	
	public function getTotalHP():Int return  this.total_HP;
	public function getCurrentHP():Int return this.current_HP;
	
	
	public function setCurrentHP(hp:Int):Void this.current_HP = hp;
	
	public function getCanFirePlasma():Bool return this.canFirePlasma;
	public function setCanFirePlasma(can:Bool):Void this.canFirePlasma = can;
	
	// main funtion Functions :
	private function moveUpAndDown(dt:Float):Void
	{
		if (this.animation_state == "increment")
		{
			this.y -= this.speed_y * dt;
			
			if (this.y <= 0) this.animation_state = "decrement";
		}
		
		else if (this.animation_state == "decrement")
		{
			this.y += this.speed_y * dt;
			
			if (this.y + this.height > HEIGHT) this.animation_state = "increment";
		}
	}
	
	
	private function launch_deathAnimation():Void
	{
		scaleBase += 0.1;
		this.scale.set(scaleBase, scaleBase);
		
		if (scaleBase > 8.0) scaleBase = 8.0;
		
	}
	
	private function updateTimer(dt:Float):Void
	{
		timerPlasma -= dt;
		
		if (timerPlasma < 0)
		{
			this.canFirePlasma = true;
			timerPlasma = timerPlasmaMax;
		}
	}
	
	
	// Update functioin: 
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		if (this.x > WIDTH - WIDTH / 10) this.x -= this.speed_x * dt;
		
		if (this.isOnScreen())
		{
			moveUpAndDown(dt);
			updateTimer(dt);
		}
		
		if (this.current_HP <= 0) launch_deathAnimation();
	}
}