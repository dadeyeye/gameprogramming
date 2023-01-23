package;


import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import flixel.text.FlxText;

class GameOverState extends FlxState
{
	
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var rectangle_transition : FlxSprite;
	
	// Texts : 
	var gameoverText : FlxText;
	var gotoMenuText : FlxText;
	var restartText : FlxText;
	
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
		
		gameoverText = new FlxText(0, 0, 0, "GAME OVER", 86);
		gameoverText.setPosition((WIDTH / 2 - gameoverText.width / 2), 40);
		gameoverText.setColorTransform(0.56, 0.3, 0.2);
		
		
		gotoMenuText = new FlxText(0, 0, 0, "Return to Menu", 56);
		gotoMenuText.setPosition(40, HEIGHT / 2);
		
		
		restartText = new FlxText(0, 0, 0, "Retry", 56);
		restartText.setPosition(gotoMenuText.x + WIDTH / 1.5 + 40 , HEIGHT / 2);
		
		// Cursor : 
		cursor_rectangle = new FlxSprite(0, 0);
		cursor_rectangle.makeGraphic(Std.int(gotoMenuText.width)+20, 100, FlxColor.fromRGB(63, 72, 210));
		cursor_rectangle.setPosition(gotoMenuText.x - 10, gotoMenuText.y - 10);
		add(cursor_rectangle);
		
		add(gameoverText);
		add(gotoMenuText);
		add(restartText);
		
		rectangle_transition = new FlxSprite();
		rectangle_transition.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
		rectangle_transition.alpha = 0;
		add(rectangle_transition);
	}
	
	
	function changeSizeRectangle(tween:FlxTween):Void
	{
		if (position == 1) cursor_rectangle.makeGraphic(Std.int(gotoMenuText.width)+20, 100, FlxColor.fromRGB(63, 72, 210));
		
		else if (position == 2) cursor_rectangle.makeGraphic(Std.int(restartText.width) + 20, 100, FlxColor.fromRGB(63, 72, 210));
		
	}
	
	function switchRoom(tween:FlxTween):Void
	{
		
		FlxTween.tween(FlxG.sound.music, {volume : 0.0}, 3.0, {ease: FlxEase.linear});
		
	
		if (position == 1)
		{
			
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			FlxG.switchState(new MenuState());
			
		}
		
		else if (position == 2)
		{
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			FlxG.switchState(new PlayState());
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
			FlxTween.tween(cursor_rectangle, {x : restartText.x - 10}, 0.5, {ease: FlxEase.smootherStepIn, onComplete : changeSizeRectangle });
			
			
		}
		
		else if (FlxG.keys.justPressed.LEFT && position == 2)
		{
			position = 1;
			
			FlxTween.tween(cursor_rectangle, {x : gotoMenuText.x - 10}, 0.5, {ease: FlxEase.smootherStepIn, onComplete : changeSizeRectangle});

			
		}
		
		if (FlxG.keys.justPressed.ENTER) transition_out();
		
	}
}