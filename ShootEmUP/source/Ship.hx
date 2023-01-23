package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Ship extends FlxSprite
{
	
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var animation_state = "increment"; // or reduce
	
	var speed : Float = 300;
	
	var x_debut : Float ; var y_debut : Float;
	
	// number of health of ship : 
	var totalLife : Int = 3;
	var current_life : Int = 3;
	
	// number of health of player: 
	var total_HP : Int = 8;
	var current_HP : Int = 8;

	var nbShoot:Int = 0;
	
	// state : 
	var isDead:Bool = false;
	var canMove:Bool = true;
	
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		
		x_debut = this.x;
		y_debut = this.y;
		
		this.loadGraphic("assets/images/ship/IDLE.png");
		
		
	}
	
	
	// assesor : 
	
	public function getCurrentLife():Int return this.current_life;
	public function setCurrentLife(life:Int):Void this.current_life = life;
	
	public function getTotalLife():Int return this.totalLife;
	public function setTotalLife(totallife:Int):Void this.totalLife = totallife;
	
	
	public function getNbShoot():Int return nbShoot;
	public function setNbShoot(nb:Int):Void this.nbShoot = nb;
	
	public function getTotalHP():Int return this.total_HP;
	public function getCurrentHP():Int return this.current_HP;
	
	public function setTotalHP(totalHP:Int):Void this.total_HP = totalHP;
	public function setCurrentHP(currentHP:Int):Void this.current_HP = currentHP;
	
	public function getIsDead():Bool return this.isDead;
	
	public function getCanMove():Bool return this.canMove;
	public function setCanMove(move:Bool):Void this.canMove = move;
	
	//  functions : 
	private function animation_floatingShip():Void
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
	
	private function move_ship(dt:Float):Void
	{
		if (!this.isDead || !this.canMove)
		{
			if (FlxG.keys.pressed.RIGHT && this.x+this.width < WIDTH)
			{
				this.x += this.speed * dt;
			}
			
			if (FlxG.keys.pressed.LEFT && this.x > 0)
			{
				this.x -= this.speed * dt;
			}
			
			if (FlxG.keys.pressed.UP && this.y > 0)
			{
				this.y -= this.speed * dt;
			}
			
			if (FlxG.keys.pressed.DOWN && this.y + this.height < HEIGHT)
			{
				this.y += this.speed * dt;
			}
		}
		
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		// functions for the player : 
		
		animation_floatingShip(); // amiation of ship
		
		move_ship(dt); // Déplacement du vaisseau 	
		
		
		if (this.current_HP <= 0) this.isDead = true;
		else if (this.current_HP > 0) this.isDead = false;
		
		if (this.isDead)
		{
			this.y += (this.speed*2) * dt;
			
			this.angle++;
		}
		
		if (!this.isOnScreen()) this.angle = 0;
	
	}
}