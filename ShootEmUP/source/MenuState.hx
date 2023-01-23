package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;


class MenuState extends FlxState
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var background = new Array<ParallaxBackground>();
	
	// Curseur : 
	var cursor : Cursor;
	
	// Texts : 
	var titleText : FlxText;
	var playText : FlxText;
	var settingsText : FlxText;
	var exitText : FlxText;
	
	// Sound : 
	var validate_sound : FlxSound;
	
	// Other : 
	var rectangle_transition : FlxSprite;
	
	private function transition_in():Void
	{
		FlxTween.tween(titleText, {y : 40 }, 1.0, {ease: FlxEase.sineIn});
		FlxTween.tween(playText, {y : HEIGHT/2 - 80 + (100 * 0) }, 1.1, {ease: FlxEase.sineIn});
		FlxTween.tween(settingsText, {y : HEIGHT/2 - 80 + (100 * 1) }, 1.2, {ease: FlxEase.sineIn});
		FlxTween.tween(exitText, {y : HEIGHT/2 - 80 + (100 * 2) }, 1.3, {ease: FlxEase.sineIn});
	}
	
	function gotoNextRoom(tween:FlxTween):Void
	{
		
		if (this.cursor.getCursorPosition() == 1 ) 
		{
			FlxTween.tween(FlxG.sound.music, {volume : 0}, 2.0, {ease: FlxEase.linear});
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			FlxG.switchState(new IntroState());
		}
		if (this.cursor.getCursorPosition() == 2 ) FlxG.switchState(new SettingsState());
		
	}
	
	private function transition_out():Void
	{
		
		FlxTween.tween(rectangle_transition, {alpha : 1.0}, 2.0 , {ease: FlxEase.circIn, onComplete : gotoNextRoom});
	}
	
	
	private function setAllColor():Void
	{
		
		playText.setColorTransform(0.3, 0.3, 0.4);
		settingsText.setColorTransform(0.3, 0.3, 0.4);
		exitText.setColorTransform(0.3, 0.3, 0.4);
	}
	
	override public function create():Void
	{
		super.create();
		
		FlxG.mouse.visible = false;
		
		// Audio : 
		if (FlxG.sound.music == null) 
		{
			FlxG.sound.playMusic("assets/music/Main Menu.ogg", Main.VOLUME_MUSIC, true);
		}
		
		validate_sound = FlxG.sound.load("assets/sounds/validate.ogg", Main.VOLUME_SFX);
		
	
		// Background :
		
		for (i in 0...5+1)
		{
			background[i] = new ParallaxBackground(0, -HEIGHT / 2 + HEIGHT/4, "assets/images/parallax/intro/landscape_000" + (5 - i) + ".png", "right", 
												   50 +(i*50));
			add(background[i]);
			add(background[i].getDuplicateSprite());
		}
		
		
		
		// Texts : 
		titleText = new FlxText(0, 0, 0, "SHOOT EM UP", 84);
		titleText.setColorTransform(0.35, 0.21, 0.7);
		titleText.setPosition((WIDTH - titleText.width) / 2, -HEIGHT / 4);
		add(titleText);
		
		playText = new FlxText(0, 0, 0, "Play", 56);
		playText.setColorTransform(0.3, 0.3, 0.4);
		playText.setPosition((WIDTH - playText.width) / 2, -HEIGHT / 4);
		add(playText);
		
		settingsText = new FlxText(0, 0, 0, "Instructions", 56);
		settingsText.setColorTransform(0.3, 0.3, 0.4);
		settingsText.setPosition((WIDTH - settingsText.width) / 2, -HEIGHT / 4);
		add(settingsText);
		
		exitText = new FlxText(0, 0, 0, "Exit", 56);
		exitText.setPosition((WIDTH - exitText.width) / 2, -HEIGHT / 4);
		exitText.setColorTransform(0.3, 0.3, 0.4);
		add(exitText);
		
		
		cursor = new Cursor( -WIDTH, -HEIGHT); 
		add(cursor);
		
		transition_in();
		
		rectangle_transition = new FlxSprite();
		rectangle_transition.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
		rectangle_transition.alpha = 0;
		add(rectangle_transition);
		
	
	}
	
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		if (this.cursor.getCursorPosition() == 1)
		{
			setAllColor();
			playText.setColorTransform(0.9, 0.4, 0.1);
			
			if (FlxG.keys.justPressed.ENTER)
			{
				cursor.setCanMove(false);
				
				validate_sound.play(true);
				
				transition_out();
				
			}
			
		}
		
		else if (this.cursor.getCursorPosition() == 2)
		{
			setAllColor();
			settingsText.setColorTransform(0.9, 0.4, 0.1);
			
			if (FlxG.keys.justPressed.ENTER)
			{
					
				cursor.setCanMove(false);
				
				validate_sound.play(true);
				
				transition_out();
				
			}
		}
		
		else if (this.cursor.getCursorPosition() == 3) 
		{
		
			setAllColor();
			exitText.setColorTransform(0.9, 0.4, 0.1);
			
			if (FlxG.keys.justPressed.ENTER)
			{
				
				validate_sound.play(true);
				
				#if neko
					Sys.exit(0);
				#end
				
				#if flash
					Lib.fscommand("quit");
				#end
			}
			

		}
	}
}