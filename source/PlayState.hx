package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;

	public var map:FlxTilemap;

	override public function create()
	{
		player = new Player(64, 16);

		LevelLoader.loadLevel(this, "playground");

		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(map, player);
	}
}
