package;


import flixel.FlxG;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var type : Int;
	// TYPE 1 = black enemies  ; TYPE 2 = red enemies
	
	var animation_state = "increment";
	
	// movement for the black enemies (Type 2)
	var yMovement_state:String = null;
	var amplitude_y:Int = null;
	
	var speed : Float;
	
	var TILE_SIZE_X : Int;
	var TILE_SIZE_Y : Int;
	
	var damage : Int;
	
	
	var x_debut:Float; var y_debut:Float;
	
	public function new(X:Float, Y:Float,type:Int)
	{
		super(X, Y);
	
		this.type = type;
		
		x_debut = X;
		y_debut = Y;
		
		
		if (this.type == 1) // black enemy
		{
			this.loadGraphic("assets/images/enemy/Thug.png");
			this.speed = 600 + FlxG.random.int(0, 400);
			
			this.TILE_SIZE_X = 80;
			this.TILE_SIZE_Y = 52;
			
			this.damage = 1; //1 damage point is inflicted
		}
		
		else if (this.type == 2) // red enemy
		{
			this.loadGraphic("assets/images/enemy/RedThug.png");
			this.speed = 700 + FlxG.random.int(0, 400);
			
			this.TILE_SIZE_X = 80;
			this.TILE_SIZE_Y = 52;
			
			this.damage = 1; // 1 point damage
			
			this.yMovement_state = "decrement";
			
			this.amplitude_y = FlxG.random.int(100, 400);
		}
		
		else if (this.type == 3) // Hugger
		{
			this.loadGraphic("assets/images/enemy/Hugger.png", true, 192, 192);
			this.speed = 100 + FlxG.random.int(0, 200);
			
			this.TILE_SIZE_X = 192;
			this.TILE_SIZE_Y = 192;
			
			this.damage = 1; // 1 point damage
			
			this.animation.add("move", [0, 1, 2], 10, true);
			this.animation.play("move");
		}
		
		
	}
	
	// Accessors : 
	
	public function getTileSizeX():Int return this.TILE_SIZE_X;
	public function getTileSizeY():Int return this.TILE_SIZE_Y;
	
	public function getDamage():Int return this.damage;
	
	private function animation_floating():Void
	{
		if (this.animation_state == 'increment')
		{
			this.scale.x += 0.002;
			this.scale.y += 0.002;
			
			if (this.scale.x > 1.2) this.animation_state = 'decrement';
		}
		
		
		else if (this.animation_state == 'decrement')
		{
			this.scale.x -= 0.002;
			this.scale.y -= 0.002;
			
			if (this.scale.x < 1) this.animation_state = 'increment';
		}
	}
	
	public function resetPositionOfType1():Void
	{
		this.x = WIDTH + FlxG.random.int(this.TILE_SIZE_X, 3000);
		this.y = FlxG.random.int(0, HEIGHT - this.TILE_SIZE_Y);
		this.speed = 600 + FlxG.random.int(0,400);
	}
	
	public function resetPositionOfType2():Void
	{
		this.x = WIDTH + FlxG.random.int(this.TILE_SIZE_X, 5000);
		this.y = FlxG.random.int(0, HEIGHT - this.TILE_SIZE_Y);
		this.speed = 700 + FlxG.random.int(0, 400);
		this.amplitude_y = FlxG.random.int(100, 400);
	}
	
	public function resetPositionOfType3(positionX:Float):Void
	{
		this.x = positionX;
		this.y = -64 - FlxG.random.int(0, 4000);
		this.speed = 100 + FlxG.random.int(0, 200);
	}
	
	public function resetPositionOfType3_v2():Void
	{
		this.x = WIDTH - FlxG.random.int(this.TILE_SIZE_X,WIDTH);
		this.y = -64 - FlxG.random.int(0, 4000);
		this.speed = 100 + FlxG.random.int(0, 200);
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		animation_floating();
		
		// black enemy: 
		
		if (this.type == 1)
		{
			this.x -= this.speed * dt;
			
			// reset the total speed.
			if (this.x < - 40) 
			{
				resetPositionOfType1();
			}
		}
		
		
		
		// black enemey : 
		
		else if (this.type == 2)
		{
			this.x -= this.speed * dt;
			
			
			if (this.yMovement_state == "decrement")
			{
				this.y += (this.speed / 2) * dt;
				
				if (this.y >= (this.y_debut + (this.amplitude_y*2)))
				{
					this.yMovement_state = "increment";
				}
			}
			
			else if (this.yMovement_state == "increment")
			{
				this.y -= (this.speed / 2) * dt;
				
				if (this.y < (this.y_debut - (this.amplitude_y*2)))
				{
					this.yMovement_state = "decrement";
				}
			}
			
			
			if (this.x < - 40) 
			{
				resetPositionOfType2();
			}
		}
		
		// Hugger : 
		
		else if (this.type == 3)
		{
			this.y += this.speed * dt;
			
			
			if (this.y > HEIGHT + 20) resetPositionOfType3_v2();
		}
		
	}
}