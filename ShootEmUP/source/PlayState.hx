package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class PlayState extends FlxState
{
	private var WIDTH = FlxG.width;
	private var HEIGHT = FlxG.height;
	
	
	// Backgrounds : 
	var background = new Array<ParallaxBackground>();
	var grayBackground : FlxSprite;
	
	var star = new Array<Star>();
	
	var rectangle_transition : FlxSprite;
	
	// Ship & stuffs about ships : 
	var ship : Ship;
	var shipShoot : Shoot;
	
	// Enemies : 
	var enemy_type1 = new Array<Enemy>();
	var enemy_type2 = new Array<Enemy>();
	var enemy_type3 = new Array<Enemy>();
	
	var canAddEnemy:Bool = true;
	
	var boss : Boss;
	var bossPlasma : Shoot;
	
	// HUD : 
	var energyBar : FlxSprite; // outline of health
	var energyBarFill = new Array<FlxSprite>(); // inside of health
	var lifeImage = new Array<FlxSprite>();
	var levelText : FlxText;
	
	
	var distanceImage : FlxSprite;
	var verticalBar : FlxSprite;
	var verticalBar_position_x:Float;
	var verticalBar_speed : Float;
	
	// boss
	var hp_bar_line : FlxSprite; // outiline
	var hp_bar_fill : FlxSprite; // fill
	var canPrintHUD : Bool = true; // call hud display
	
	var scoreText : FlxText;
	var score : Int = 0;
	
	// SFX : 
	var getHit_sound : FlxSound;
	var destroy_sound : FlxSound;
	var bossGetHit_sound : FlxSound;
	var bossPlasma_sound : FlxSound;
	
	private function selectLevel(currentLevel:Int):Void
	{
		
		// LEVEL 1 : space
		if (currentLevel == 1)
		{
			// Background :
			
			background[0] = new ParallaxBackground(0, 0, "assets/images/parallax/world1/desert_0005.png", "right", 50);
			add(background[0]);
			add(background[0].getDuplicateSprite());
			
			for (i in 1...5+1)
			{
				background[i] = new ParallaxBackground(0,0 + HEIGHT/5 + 20, "assets/images/parallax/world1/desert_000" + (5 - i) + ".png", "right", 
													   50 +(i * 50));
									   
				add(background[i]);

				add(background[i].getDuplicateSprite());
			}
			
			levelText = new FlxText(0,0,0,"Level : " + Main.CURRENT_LEVEL + " - Desert",18);
			levelText.setFormat(null, 18, FlxColor.WHITE);
			levelText.setPosition(WIDTH - levelText.width - 40, HEIGHT - 60);
			add(levelText);
			
			// Enemy : 
			
			// spawn 10 black enemies
			for (i in 0...15)
			{
				enemy_type1[i] = new Enemy(0, 0, 1);
				enemy_type1[i].setPosition(WIDTH + FlxG.random.int(0, 3000), FlxG.random.int(enemy_type1[i].getTileSizeY(), HEIGHT));
				add(enemy_type1[i]);
			}
			
			// spawn 10 red enemies
			
			for (j in 0...20)
			{
				enemy_type2[j] = new Enemy(0, 0, 2);
				enemy_type2[j].setPosition(WIDTH + FlxG.random.int(0, 5000), FlxG.random.int(enemy_type2[j].getTileSizeY(), HEIGHT));
			}
			
			
			// level speed
			verticalBar_speed = 0.17;
		}
		
		else if (currentLevel == 2)
		{
			
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
			
			levelText = new FlxText(0,0,0,"Level : " + Main.CURRENT_LEVEL + " - Cave",18);
			levelText.setFormat(null, 18, FlxColor.WHITE);
			levelText.setPosition(WIDTH - levelText.width - 40, HEIGHT - 60);
			add(levelText);
			
			
			// 30 enemies spawned
			for (i in 0...30)
			{
				enemy_type1[i] = new Enemy(0, 0, 1);
				enemy_type1[i].setPosition(WIDTH + FlxG.random.int(0, 3000), FlxG.random.int(enemy_type1[i].getTileSizeY(), HEIGHT));
				add(enemy_type1[i]);
			}
			
			// 5 enemies hugger: 
			for (j in 0...5)
			{
				enemy_type3[j] = new Enemy(0, 0, 3);
				enemy_type3[j].setPosition(ship.x, -64-FlxG.random.int(0,2000));
			}
			
			
			// level speed : 
			verticalBar_speed = 0.1;
		}
		
		else if (currentLevel == 3)
		{
			// No background : It's the final boss 
			
			for (i in 0...100)
			{
				star[i] = new Star(FlxG.random.int(0,WIDTH), FlxG.random.int(0, HEIGHT), FlxG.random.int(400, 700));
				add(star[i]);
				
			}			
			
			levelText = new FlxText(0,0,0,"Level : " + Main.CURRENT_LEVEL + " - Dark Eye ",18);
			levelText.setFormat(null, 18, FlxColor.WHITE);
			levelText.setPosition(WIDTH - levelText.width - 40, HEIGHT - 60);
			add(levelText);
			
			// 5 black enemies
			for (i in 0...5)
			{
				enemy_type1[i] = new Enemy(0, 0, 1);
				enemy_type1[i].setPosition(WIDTH + FlxG.random.int(0, 3000), FlxG.random.int(enemy_type1[i].getTileSizeY(), HEIGHT));
				add(enemy_type1[i]);
			}
			
			// spawn 5 red enemies
			for (j in 0...5)
			{
				enemy_type2[j] = new Enemy(0, 0, 2);
				enemy_type2[j].setPosition(WIDTH + FlxG.random.int(0, 5000), FlxG.random.int(enemy_type2[j].getTileSizeY(), HEIGHT));
				add(enemy_type2[j]);
			}
			
			// spawn 8 hugger
			for (k in 0...8)
			{
				enemy_type3[k] = new Enemy(0, 0, 3);
				enemy_type3[k].setPosition(ship.x, -64 - FlxG.random.int(2000, 10000)); // set the positon so player is aware of boss
				add(enemy_type3[k]);
			}
			
			
			// at the end of round boss: 
			boss = new Boss(WIDTH + 2000, HEIGHT / 2);
			add(boss);
			
			// hud
			hp_bar_line = new FlxSprite();
			hp_bar_line.setPosition(WIDTH / 2 - WIDTH/5, 20);
			hp_bar_line.makeGraphic((30 * boss.getTotalHP()), 20, FlxColor.WHITE);
			
			hp_bar_fill = new FlxSprite();
			hp_bar_fill.setPosition((WIDTH / 2 - WIDTH/5) + 2, 20 + 2);
			hp_bar_fill.makeGraphic((30 * boss.getCurrentHP()) - 4, 20 - 4, FlxColor.fromRGB(34, 177, 76));
			
			verticalBar_speed = 0.0;
		}
	}
	
	private function gestionHUD():Void
	{
		energyBar = new FlxSprite(0, 0, "assets/images/hud/Feul.png");
		energyBar.setPosition(20, HEIGHT - energyBar.height - 20);
		add(energyBar);
		
		
		for (i in 0...ship.getTotalHP())
		{
			energyBarFill[i] = new FlxSprite(energyBar.x + 30 + (i*28), energyBar.y+2, "assets/images/hud/FeulBar.png");
	
			add(energyBarFill[i]);
		}
		
		
		for (j in 0...ship.getTotalLife())
		{
			lifeImage[j] = new FlxSprite(energyBar.x + energyBar.width + 20 + (j * (32+4)) , energyBar.y, "assets/images/hud/Life.png");
			add(lifeImage[j]);
		}
		
		
		distanceImage = new FlxSprite();
		distanceImage.makeGraphic(Std.int(WIDTH / 2 )- 80, 4, FlxColor.BLACK);
		distanceImage.setPosition(energyBar.x + WIDTH / 3, energyBar.y+8);
		add(distanceImage);
		
		verticalBar = new FlxSprite();
		verticalBar.makeGraphic(4, 40, FlxColor.BLUE);
		verticalBar_position_x = distanceImage.x;
		verticalBar.setPosition(verticalBar_position_x, distanceImage.y - 20);
		add(verticalBar);
		
		
		scoreText = new FlxText(0, 0, 0, "Score : " + score, 20);
		scoreText.setPosition(20, 40);
		add(scoreText);
		
	}
	
	function gotoGameOver(tween:FlxTween):Void
	{
		FlxG.sound.music.destroy();
		FlxG.sound.music = null;
		FlxG.switchState(new GameOverState());
	}
	
	private function transition_out():Void
	{
		FlxTween.tween(FlxG.sound.music, {volume : 0.0}, 3.0, {ease: FlxEase.linear});
		FlxTween.tween(rectangle_transition, {alpha : 1.0}, 5.0 , {ease: FlxEase.expoOut, onComplete: gotoGameOver});
	}
	
	override public function create():Void
	{
		super.create();
		
		// Audio : 
		if (FlxG.sound.music == null) 
		{
			if (Main.CURRENT_LEVEL == 1) FlxG.sound.playMusic("assets/music/Levels.ogg", Main.VOLUME_MUSIC, true);
			else if (Main.CURRENT_LEVEL == 2) FlxG.sound.playMusic("assets/music/Dark Level.ogg", Main.VOLUME_MUSIC, true);
			else if (Main.CURRENT_LEVEL == 3) FlxG.sound.playMusic("assets/music/Final Boss.ogg", Main.VOLUME_MUSIC, true);
			
		}
		
		ship = new Ship(80, HEIGHT / 2);
		
		selectLevel(Main.CURRENT_LEVEL);
		
		gestionHUD();

		add(ship); // We put the ship bin after HUD management and selectLevel so that it is in the foreground
		
		
		rectangle_transition = new FlxSprite();
		rectangle_transition.makeGraphic(WIDTH, HEIGHT, FlxColor.BLACK);
		rectangle_transition.alpha = 0;
		add(rectangle_transition);
		
		getHit_sound = FlxG.sound.load("assets/sounds/getHit.ogg",Main.VOLUME_SFX);
		destroy_sound = FlxG.sound.load("assets/sounds/destroy.ogg", Main.VOLUME_SFX);
		bossGetHit_sound = FlxG.sound.load("assets/sounds/bossGetHit.ogg", Main.VOLUME_SFX);
		bossPlasma_sound = FlxG.sound.load("assets/sounds/plasma.ogg", Main.VOLUME_SFX);
	}
	
	
	
	function gotoTransitionRoom(tween:FlxTween):Void
	{
		function switchRoom(tween:FlxTween):Void
		{
			FlxG.sound.music.destroy();
			FlxG.sound.music = null;
			FlxG.switchState(new TransitionState());
		}
		
		FlxTween.tween(FlxG.sound.music, {volume : 0.0}, 3.0, {ease: FlxEase.linear, onComplete : switchRoom});
		
	}
	
	public function updateVerticalBar(dt:Float):Void
	{
		verticalBar_position_x += verticalBar_speed;  // Basic value = 0.1
		verticalBar.setPosition(verticalBar_position_x, distanceImage.y - 20);
		
		
		// end of movement = end of round : 
		if (verticalBar_position_x >= (distanceImage.x + distanceImage.width - 15)) 
		{
			verticalBar_position_x = distanceImage.x + distanceImage.width - 15;
			
			ship.setCanMove(false);
			FlxTween.tween(ship, {x : WIDTH + 40}, 2.0, {ease : FlxEase.smootherStepIn, onComplete : gotoTransitionRoom});
		}
		
		
		// special case : adding monsters at certain stages
		
		if (Main.CURRENT_LEVEL == 1 && canAddEnemy && verticalBar_position_x >= distanceImage.x + distanceImage.width / 2)
		{
			for (j in 0...10) add(enemy_type2[j]);
			canAddEnemy = false;
	
		}
		
		if (Main.CURRENT_LEVEL == 2 && canAddEnemy && verticalBar_position_x >= distanceImage.x + distanceImage.width / 2)
		{
			for (j in 0...5) add(enemy_type3[j]);
			canAddEnemy = false;
		}
		
	}

	// Fuction for the boss control
	public function updateBoss(dt:Float):Void
	{
		
		// Hud display shown once 
		if (canPrintHUD)
		{
			add(hp_bar_line);
			add(hp_bar_fill);
			
			canPrintHUD = false;
		}
		
		
		// when shoots hit the boss : 
		if (shipShoot != null && boss.getCurrentHP() > 0)
		{
			if (FlxG.overlap(shipShoot, boss))
			{
				shipShoot.destroy();
				bossGetHit_sound.play(true);
				
				boss.setCurrentHP(boss.getCurrentHP() - 1);
				hp_bar_fill.makeGraphic((30 * boss.getCurrentHP()) - 4, 20 - 4, FlxColor.fromRGB(34, 177, 76));
			}
		}
		
		
		// when the boss fires : 
		
		if (boss.getCurrentHP() > 0)
		{
			if (boss.getCanFirePlasma())
			{
				bossPlasma = new Shoot(boss.x - 10, boss.y + boss.height / 2, "boss");
				boss.setCanFirePlasma(false);
				bossPlasma_sound.play(true);
				add(bossPlasma);
			}
		}
		
		
		if (bossPlasma != null)
		{
			if (bossPlasma.overlaps(ship))
			{
				
				// life bar is decreasing 
				if (ship.getCurrentHP() >= 1 && ship.getCurrentLife() >= 1)
				{
					energyBarFill[ship.getCurrentHP() - 1].destroy();
					energyBarFill[ship.getCurrentHP() - 1] = null;
				}
					
				// digital part is updated
				getHit_sound.play(true);
				ship.setCurrentHP(ship.getCurrentHP() - 1); // decrease health due to damage
				bossPlasma.destroy();
				bossPlasma = null;
			}
		}
		
		
		// death of boss
		if (boss.getCurrentHP() <= 0 && boss.scale.x >= 8.0) 
		{
			boss.destroy();
			boss = null;
			
			ship.setCanMove(false);
			FlxTween.tween(FlxG.sound.music, {volume : 0.0}, 3.0, {ease: FlxEase.linear});
			
			FlxTween.tween(ship, {x : WIDTH + 40}, 2.0, {ease : FlxEase.smootherStepIn, onComplete : gotoEndRoom});
			
		}
	}
	
	function gotoEndRoom(tween:FlxTween):Void
	{
		FlxG.sound.music.destroy();
		FlxG.sound.music = null;
		FlxG.switchState(new EndState());
	}
	
	override public function update(dt:Float):Void
	{
		super.update(dt);
		
		updateVerticalBar(dt);
		
		scoreText.text = "Score : " + score;
		
		// fired shoot update : 
		
		
		if (!ship.getIsDead() && FlxG.keys.justPressed.SPACE)
		{
			shipShoot = new Shoot(ship.x + ship.width, ship.y + ship.height / 2, "player");
			add(shipShoot);

			shipShoot.setCanMove(true);
		}
		
		
		
		// -------------------- Check collisions -------------------- : 
		
		
		// black enemy:
		for (i in 0...enemy_type1.length)
		{
			
			// the enemy collieds with the player : 
			
			if (FlxG.overlap(ship, enemy_type1[i]))
			{
				// if not dead rest ememy positon and shake the camera
			
				enemy_type1[i].resetPositionOfType1();
				camera.shake(0.01, 0.5);
				
				// hp is reduced
				for (j in 0...enemy_type1[i].getDamage())
				{
					// life bar
					if (ship.getCurrentHP() >= 1 && ship.getCurrentLife() >= 1)
					{
						energyBarFill[ship.getCurrentHP() - 1].destroy();
						energyBarFill[ship.getCurrentHP() - 1] = null;
					}
					
				}
				
				
				// sound update
				getHit_sound.play(true);
			
				ship.setCurrentHP(ship.getCurrentHP() - enemy_type1[i].getDamage()); // remove points as a result of damage
				
			}

			
			// shots fired at black enemies: 
			if (shipShoot != null)
			{
				if (FlxG.overlap(shipShoot, enemy_type1[i]))
				{
					shipShoot.destroy();
					destroy_sound.play(true);
					score += 50;
					enemy_type1[i].resetPositionOfType1();
				}
			}
			
		}
		
		// black enemies :
		for (j in 0...enemy_type2.length)
		{
			
			// Les ennemies touchent le player : 
			
			if (FlxG.overlap(ship, enemy_type2[j]))
			{
				// Si on est pas mort, alors on peut reset la position de l'ennemi et shake la caméra
			
				enemy_type2[j].resetPositionOfType2();
				camera.shake(0.01, 0.5);
				
				// On diminue les PV selon les dégats qu'inflige l'ennemi 
				for (k in 0...enemy_type2[j].getDamage())
				{
					// (Ici, c'est pour l'affichage sous forme de barre de vie que l'on diminue)
					if (ship.getCurrentHP() >= 1 && ship.getCurrentLife() >= 1)
					{
						energyBarFill[ship.getCurrentHP() - 1].destroy();
						energyBarFill[ship.getCurrentHP() - 1] = null;
					}
					
				}
				
				// (Ici c'est plutôt pour la parte numérique derrière l'affichage qu'on actualise)
				getHit_sound.play(true);
				ship.setCurrentHP(ship.getCurrentHP() - enemy_type2[j].getDamage()); // on retire des pv équivalent au dégats infligé
			}
			
			// Les tirs touchent les thugs rouge : 
			if (shipShoot != null)
			{
				if (FlxG.overlap(shipShoot, enemy_type2[j]))
				{
					shipShoot.destroy();
					destroy_sound.play(true);
					score += 100;
					enemy_type2[j].resetPositionOfType2();
				}
			}
			
		}
		
		// Hugger :
		for (k in 0...enemy_type3.length)
		{
			
			// Les ennemies touchent le player : 
			
			if (FlxG.overlap(ship, enemy_type3[k]))
			{
				// Si on est pas mort, alors on peut reset la position de l'ennemi et shake la caméra
			
				enemy_type3[k].resetPositionOfType3(ship.x);
				camera.shake(0.01, 0.5);
				
				// On diminue les PV selon les dégats qu'inflige l'ennemi 
				for (l in 0...enemy_type3[k].getDamage())
				{
					// (Ici, c'est pour l'affichage sous forme de barre de vie que l'on diminue)
					if (ship.getCurrentHP() >= 1 && ship.getCurrentLife() >= 1)
					{
						energyBarFill[ship.getCurrentHP() - 1].destroy();
						energyBarFill[ship.getCurrentHP() - 1] = null;
					}
					
				}
				
				// (Ici c'est plutôt pour la parte numérique derrière l'affichage qu'on actualise)
				getHit_sound.play(true);
				ship.setCurrentHP(ship.getCurrentHP() - enemy_type3[k].getDamage()); // on retire des pv équivalent au dégats infligé
			}
			
			// Les tirs touchent les thugs rouge : 
			if (shipShoot != null)
			{
				if (FlxG.overlap(shipShoot, enemy_type3[k]))
				{
					shipShoot.destroy();
					destroy_sound.play(true);
					score += 500;
					enemy_type3[k].resetPositionOfType3_v2();
				}
			}
			
		}
		
		// code for defeat : 
		
		// if there is health left it reduces when shot are a hit
		if (ship.getCurrentHP() < 1) 
		{
			
			// what happens when there is no longer a ship
			if (!ship.isOnScreen())
			{
				// inserted outside the screen due to tween effect
				ship.x = -ship.width;
				ship.y = HEIGHT / 2;
				
				// clear all images player 
				for (j in 0...ship.getCurrentLife())
				{
					lifeImage[j].destroy();
					lifeImage[j] = null;
				}
				
				// reduce the health
				ship.setCurrentLife(ship.getCurrentLife() - 1);
				ship.setCurrentHP(ship.getTotalHP()); // on remet les PV à son nombre maximum 
				
				// ship respawn back to screen if the game is not over
				if (ship.getCurrentLife() >= 1) FlxTween.tween(ship, {x : 80}, 1.0, {ease : FlxEase.sineIn});
				
				// showing remaining life
				for (k in 0...ship.getCurrentLife())
				{
					lifeImage[k] = new FlxSprite(energyBar.x + energyBar.width + 20 + (k * (32+4)) , energyBar.y, "assets/images/hud/Life.png");
					add(lifeImage[k]);
				}
				
				// life bar empty
				for (i in 0...ship.getTotalHP())
				{
					if (ship.getCurrentLife() >= 1)
					{
						energyBarFill[i] = new FlxSprite(energyBar.x + 30 + (i*28), energyBar.y+2, "assets/images/hud/FeulBar.png");
			
						add(energyBarFill[i]);
					}
					
				}
			}
		}
		
		//  transiton for game over
		if (ship.getCurrentLife() < 1)
		{
			transition_out();
		}
		
		
		
		
		// The boss  :
		
		if (Main.CURRENT_LEVEL == 3) 
		{
			
			if (boss != null)
			{
				if (boss.isOnScreen())
				{
					updateBoss(dt);
				}

			}
		
		}
	}
}