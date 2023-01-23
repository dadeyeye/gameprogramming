package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;


class IntroState extends FlxState
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	// Background :
	var background = new Array<ParallaxBackground>();
	var grayBackground : FlxSprite;
	
	// Sprites : 
	var rectangle_box : FlxSprite;
	
	// Texts Message box : 
	var text = new Array<FlxText>();
	
	// Other : 
	var rectangle_transition : FlxSprite;
	
	
	function gotoNextRoom(tween:FlxTween):Void
	{
		
		FlxG.sound.music.destroy();
		FlxG.sound.music = null;
		FlxG.switchState(new PlayState());
		
	}
	
	private function transition_out():Void
	{
		FlxTween.tween(FlxG.sound.music, {volume : 0}, 2.0, {ease: FlxEase.linear});
		FlxTween.tween(rectangle_transition, {alpha : 1.0}, 2.0 , {ease: FlxEase.circIn, onComplete : gotoNextRoom});
	}
	
	override public function create():Void
	{
		super.create();
		
		// Audio : 
		if (FlxG.sound.music == null) 
		{
			
			FlxG.sound.playMusic("assets/music/Crisis.ogg", Main.VOLUME_MUSIC, true);
			
		}
		
		// Background :
		
		grayBackground = new FlxSprite(0, 0, "assets/images/parallax/cinematique/cave_0003.png");
		
		add(grayBackground);
		
		for (i in 0...2+1)
		{
			background[i] = new ParallaxBackground(0, 0, "assets/images/parallax/cinematique/cave_000" +(2-i) + ".png", "right", 
												20 + (i * 20));							
			add(background[i]);
	
			add(background[i].getDuplicateSprite());
		}
		
		
		// Texts :
		
		rectangle_box = new FlxSprite(0,HEIGHT - HEIGHT/4 - 10);
		rectangle_box.makeGraphic(WIDTH, Std.int(HEIGHT/4), FlxColor.BLACK);
		rectangle_box.alpha = 0.4;
		add(rectangle_box);
		
		text[0] = new FlxText(rectangle_box.x + 4, rectangle_box.y + 4, WIDTH - 4,
							  "Eleminate all incoming target.\nOtherwise face death\nComplete the level and become an Hero\n\nPRESS [ENTER] TO CONTINUE.\n\n",
							  18);
		add(text[0]);
		
		
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