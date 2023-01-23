package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import flixel.text.FlxText;

class TransitionState extends FlxState
{
	
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var rectangle_transition : FlxSprite;
	
	
	// Texts : 
	var congratulationText : FlxText;
	var levelCompleteText : FlxText;
	var yesText : FlxText;
	var noText : FlxText;
	
	
	// Cursor : 
	var cursor_rectangle : FlxSprite;
	var position : Int = 1;
	
	
	override public function create():Void
	{
		super.create();
		
		// Audio : 
		if (FlxG.sound.music == null) 
		{
			
			FlxG.sound.playMusic("assets/music/Gameover.ogg", Main.VOLUME_MUSIC, true);
			
		}
		
		// Texts : 
		congratulationText = new FlxText(0, 0, 0, "CONGRATULATIONS!");
		congratulationText.setFormat(null, 58, FlxColor.CYAN);
		congratulationText.setPosition(WIDTH / 2 - congratulationText.width / 2, 40);
		add(congratulationText);
		
		levelCompleteText = new FlxText(0, 0, 0, "Level " + Main.CURRENT_LEVEL + " complete\nGo to next level?");
		levelCompleteText.setFormat(null, 46,FlxColor.fromRGB(170,50,79));
		levelCompleteText.setPosition(WIDTH / 2 - levelCompleteText.width / 2, congratulationText.y+80);
		add(levelCompleteText);
		
		yesText = new FlxText(0, 0, 0, "Yes");
		yesText.setFormat(null, 48,FlxColor.WHITE);
		yesText.setPosition(WIDTH/4, HEIGHT/2 + 80);
		
		
		noText = new FlxText(0, 0, 0, "No");
		noText.setFormat(null, 48,FlxColor.WHITE);
		noText.setPosition(WIDTH/4 + WIDTH/2, HEIGHT/2 + 80);
		
		
		// Cursor : 
		cursor_rectangle = new FlxSprite(0, 0);
		cursor_rectangle.makeGraphic(Std.int(yesText.width)+20, 100, FlxColor.fromRGB(63, 72, 210));
		cursor_rectangle.setPosition(yesText.x - 10, yesText.y - 10);
		add(cursor_rectangle);
		
		rectangle_transition = new FlxSprite();
		rectangle_transition.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
		rectangle_transition.alpha = 0;
		add(rectangle_transition);
		
		
		add(yesText);
		add(noText);
	}
	
	
	function switchRoom(tween:FlxTween):Void
	{
		
		FlxTween.tween(FlxG.sound.music, {volume : 0.0}, 3.0, {ease: FlxEase.linear});
		
	
		if (position == 1)
		{
			
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			Main.CURRENT_LEVEL++;
			FlxG.switchState(new PlayState());
			
		}
		
		else if (position == 2)
		{
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			Main.CURRENT_LEVEL++;
			FlxG.switchState(new MenuState());
		}
	}
	
	private function transition_out():Void
	{
		FlxTween.tween(rectangle_transition, {alpha : 1.0}, 2.0 , {ease: FlxEase.circIn, onComplete : switchRoom});
	}
	
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		
		if (FlxG.keys.justPressed.RIGHT && position == 1)
		{
			position = 2;
			FlxTween.tween(cursor_rectangle, {x : noText.x - 10}, 0.5, {ease: FlxEase.smootherStepIn });
			
			
		}
		
		else if (FlxG.keys.justPressed.LEFT && position == 2)
		{
			position = 1;
			
			FlxTween.tween(cursor_rectangle, {x : yesText.x - 10}, 0.5, {ease: FlxEase.smootherStepIn});

			
		}
		
		if (FlxG.keys.justPressed.ENTER) transition_out();
	}
}