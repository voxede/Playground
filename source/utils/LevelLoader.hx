package utils;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import states.PlayState;

class LevelLoader
{
	public static function loadLevel(state:PlayState, level:String)
	{
		var tiledMap = new TiledMap("assets/data/" + level + ".tmx");

		var mainLayer:TiledTileLayer = cast tiledMap.getLayer("main");
		var backLayer:TiledTileLayer = cast tiledMap.getLayer("back");

		state.map = new FlxTilemap();
		state.map.loadMapFromArray(mainLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);

		var backMap = new FlxTilemap();
		backMap.loadMapFromArray(backLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);
		backMap.solid = false;

		state.add(backMap);
		state.add(state.map);

		if (tiledMap.getLayer("player") != null)
		{
			var playerLayer:TiledObjectLayer = cast tiledMap.getLayer("player");
			var playerPos:TiledObject = playerLayer.objects[0];
			state.player.setPosition(playerPos.x, playerPos.y - 16);
		}
		else
			trace("Player object layer not found");
	}
}