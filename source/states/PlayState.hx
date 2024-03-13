package states;

import Reg;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import objects.Coin;
import objects.Enemy;
import objects.Player;
import utils.LevelLoader;

class PlayState extends FlxState
{
	public var player(default, null):Player;

	public var map:FlxTilemap;

	public var items(default, null):FlxTypedGroup<FlxSprite>;
	public var enemies(default, null):FlxTypedGroup<Enemy>;

	private var _hud:HUD;

	override public function create()
	{
		Reg.pause = false;
		Reg.time = 300;

		Reg.PS = this;

		Reg.pause = false;

		player = new Player();

		items = new FlxTypedGroup<FlxSprite>();
		enemies = new FlxTypedGroup<Enemy>();

		_hud = new HUD();

		LevelLoader.loadLevel(this, "playground");

		add(player);

		add(items);
		add(enemies);

		add(_hud);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (player.alive)
		{
			FlxG.collide(map, player);
			FlxG.overlap(items, player, collideItems);
			FlxG.overlap(enemies, player, collideEnemies);
		}

		FlxG.collide(map, enemies);
		FlxG.collide(enemies, enemies);

		updateTime(elapsed);
	}

	function collideItems(coin:Coin, player:Player)
	{
		coin.collect();
	}

	function collideEnemies(enemy:Enemy, player:Player)
	{
		enemy.interact(player);
	}

	private function updateTime(elapsed:Float)
	{
		if (Reg.time > 0)
			Reg.time -= elapsed;
		else
		{
			Reg.time = 0;
			player.kill();
		}
	}
}
