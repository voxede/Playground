import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;

class LevelLoader
{
	public function new()
	{
		var tiledMap = new TiledMap("assets/data/playground.tmx");

		var mainLayer:TiledTileLayer = cast tiledMap.getLayer("main");

		trace(mainLayer.tileArray.length);
	}
}
