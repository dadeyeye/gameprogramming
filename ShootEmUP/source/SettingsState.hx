package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

class SettingsState extends FlxState
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	
	
	// Background : 
	var background = new Array<ParallaxBackground>();
	
	// Curseur : 
	var cursor : Cursor;
	
	// Sound : 
	var validate_sound : FlxSound;
	var select_sound : FlxSound;
	
	// Texts : 
	var instructionsText : FlxText;
	var controlsText : FlxText;
	
	var returnText : FlxText;

	
	// Other : 
	var rectangle_transition : FlxSprite;
	
	private function transition_in():Void
	{
		FlxTween.tween(instructionsText, {y : 40}, 1.0, {ease: FlxEase.sineIn});
		FlxTween.tween(returnText, {y : HEIGHT/2 - 100 + (100 * 3)}, 1.4, {ease:FlxEase.sineIn});
	}
	
	
	
	private function transition_out():Void
	{
		function gotoMenuState(tween:FlxTween):Void
		{
			FlxG.switchState(new MenuState());
		}	
		
		FlxTween.tween(rectangle_transition, {alpha : 1.0}, 1.0 , {ease: FlxEase.circIn,onComplete : gotoMenuState});
	}
	
	
	private function setAllColor():Void
	{
		controlsText.setColorTransform(0.3, 0.3, 0.4);
		returnText.setColorTransform(0.3, 0.3, 0.4);
	}
	
	override public function create():Void
	{
		super.create();
		
		// Audio : 
		if (FlxG.sound.music == null) 
		{
		
			FlxG.sound.playMusic("assets/music/Main Menu.ogg", Main.VOLUME_MUSIC, true);
			
		}
		
		validate_sound = FlxG.sound.load("assets/sounds/validate.ogg", Main.VOLUME_SFX);
		select_sound = FlxG.sound.load("assets/sounds/select.ogg", Main.VOLUME_SFX);
		
		// Background :
		for (i in 0...5+1)
		{
			background[i] = new ParallaxBackground(0, -HEIGHT / 2 + HEIGHT/4, "assets/images/parallax/intro/landscape_000" + (5 - i) + ".png", "right", 50 +(i*50));
			add(background[i]);
			add(background[i].getDuplicateSprite());
		}
		
		
		// Texts :
		
		instructionsText = new FlxText(0, 0, "Instructions", 84); //positon is center
		instructionsText.setPosition((WIDTH - instructionsText.width) / 2, -HEIGHT / 4);
		instructionsText.setColorTransform(0.35, 0.21, 0.7);
		add(instructionsText);
		
		controlsText = new FlxText(0, 0, "[Up Arrow] to move up \n[Down Arrow] to move down\n [Left Arrow] to move left\n[Right Arrow] to move down\n[SPACE] to shoot \n[ENTER] to continue ", 48);
		controlsText.setPosition((WIDTH - controlsText.width) / 2, (instructionsText.height /2)+ instructionsText.height  );
		add(controlsText);
		
		returnText = new FlxText(0, 0, "Return to the menu", 48);
		returnText.setPosition((WIDTH - returnText.width) / 2, - HEIGHT / 4 );
		add(returnText);
		
		cursor = new Cursor( -WIDTH, -HEIGHT);
		cursor.setCursorCurrentState("SettingsState");
		add(cursor);
		
		rectangle_transition = new FlxSprite();
		rectangle_transition.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
		rectangle_transition.alpha = 0;
		add(rectangle_transition);
		
		transition_in();
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
						
		if (this.cursor.getCursorPosition() == 1)
		{
			setAllColor();
			controlsText.setColorTransform(0.9, 0.4, 0.1);
			
			if (FlxG.keys.justPressed.ENTER)
			{
				select_sound.play(true);
			}
			}
				
				
		else if (this.cursor.getCursorPosition() == 2)
		{
			
			setAllColor();
			returnText.setColorTransform(0.9, 0.4, 0.1);
			
			
			if (FlxG.keys.justPressed.ENTER)
			{
				validate_sound.play(true);
				
				transition_out();
				
			}
			
			
		}
	}
}