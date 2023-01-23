package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxSound;


class Cursor extends FlxSprite
{
	private var position:Int = 1;
	
	private var canMove:Bool = true;
		
	private var select_sound : FlxSound;
	
	private var currentState = "MenuState";
	
	public function new(x:Float,y:Float)
	{
		super(x,y);
		
		select_sound = FlxG.sound.load("assets/sounds/select.ogg",Main.VOLUME_SFX);

	}
	
	// Assessors : 
	
	public function getCursorPosition():Int
	{
		return position;
	}
	
	public function setCursorPosition(pos:Int):Void
	{
		this.position = pos;
	}
	
	public function setCanMove(possibility:Bool):Void
	{
		this.canMove = possibility;
	}
	
	public function getCursorCurrentState() return currentState;
	
	public function setCursorCurrentState(state:String) currentState = state;
	
	// Private methods : 

	
	
	// Override method : 
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		

		select_sound.volume = Main.VOLUME_SFX;

		
		if (FlxG.keys.justPressed.DOWN && canMove)
		{
			
			if (this.currentState == "MenuState")
			{
				canMove = false;
				if (this.position == 1 || this.position == 2)
				{
					this.position++;
					
					select_sound.play(true);
					
					canMove = true;
		
				}
				
				else canMove = true;
				
			}
			
			
			else if (this.currentState == "SettingsState")
			{
				canMove = false;
				if (this.position == 1 || this.position == 2 || this.position == 3)
				{
					
					this.position++;
					
					select_sound.play(true);
		
					canMove = true;
				}
				
				else canMove = true;
				
			}
			
			
			
		}
		
		if (FlxG.keys.justPressed.UP && canMove)
		{
			
			if (this.currentState == "MenuState")
			{
				canMove = false;
				if (this.position == 3 || this.position == 2)
				{
					this.position--;
					
				
					select_sound.play(true);
					
					canMove = true;
				
				}
				
				else canMove = true;
				
			}
			
			else if (this.currentState == "SettingsState")
			{
				canMove = false;
				if (this.position == 4 || this.position == 3 || this.position == 2)
				{
	
					this.position--;

					select_sound.play(true);
				
					canMove = true;
				}
				
				else canMove = true;
			}
			
		}
		
	}
	
	
	
	
}