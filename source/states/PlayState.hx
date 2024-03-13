package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import objects.Coin;
import objects.Player;
import utils.LevelLoader;

class PlayState extends FlxState
{
	public var player(default, null):Player;

	public var map:FlxTilemap;

	public var items(default, null):FlxTypedGroup<FlxSprite>;

	override public function create()
	{
		player = new Player();

		LevelLoader.loadLevel(this, "playground");

		add(player);

		items = new FlxTypedGroup<FlxSprite>();
		add(items);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(map, player);
		FlxG.overlap(items, player, collideItems);
	}

	function collideItems(coin:Coin, player:Player)
	{
		coin.collect();
	}
}