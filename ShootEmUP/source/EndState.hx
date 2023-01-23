package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;


class EndState extends FlxState
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	var background = new Array<ParallaxBackground>();
	
	var rectangle_transition : FlxSprite;
	
	var endingText : FlxText;
	
	var pressEnterText : FlxText;
	
	private function transition_out():Void
	{
		function gotoMainMenu(tween:FlxTween):Void
		{
			Main.CURRENT_LEVEL = 1;
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			FlxG.switchState(new MenuState());
		}
		
		FlxTween.tween(rectangle_transition, {alpha : 1.0}, 2.0 , {ease: FlxEase.circIn, onComplete : gotoMainMenu});
	}
	
	
	override public function create():Void
	{
		super.create();
		
		// Audio : 
		if (FlxG.sound.music == null) 
		{
			FlxG.sound.playMusic("assets/music/Gameover.ogg", Main.VOLUME_MUSIC, true);
		}
		
		// Background :
		
		for (i in 0...5+1)
		{
			background[i] = new ParallaxBackground(0, -HEIGHT / 2 + HEIGHT/4, "assets/images/parallax/intro/landscape_000" + (5 - i) + ".png", "right", 
												   50 +(i*50));
			add(background[i]);
			add(background[i].getDuplicateSprite());
		}
		
		
		// Text : 
		endingText = new FlxText(0, 0, 0, "", 26);
		endingText.text = "Congratulations, \n You are a Hero";
		endingText.setPosition(WIDTH / 2 - endingText.width / 2, 40);
		endingText.setFormat(null, 26, FlxColor.BLACK, FlxTextAlign.CENTER);
		add(endingText);
		
		
		pressEnterText = new FlxText(0, 0, 0, "PRESS ENTER", 52);
		pressEnterText.setPosition(WIDTH / 2 - pressEnterText.width / 2, HEIGHT / 2 + 80);
		pressEnterText.setColorTransform(0, 0, 0);
		add(pressEnterText);
		
		rectangle_transition = new FlxSprite();
		rectangle_transition.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
		rectangle_transition.alpha = 0;
		add(rectangle_transition);
		
		
		
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		if (FlxG.keys.justPressed.ENTER)
		{
			transition_out();
		}
	}
}