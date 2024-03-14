package states;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	static inline var OFFSET:Int = 4;

	private var _textScore:FlxText;
	private var _bg:FlxSprite;
	private var _cursor:FlxSprite;
	private var _selected:Int = 0;

	private static var _menuEntries:Array<String> = ["NEW GAME", "EXIT"];
	private static var _menuPos:FlxPoint = new FlxPoint(123, 112);
	private static var _menuSpacing:Int = 16;

	override public function create()
	{
		_bg = new FlxSprite(0, 0);
		_bg.loadGraphic(AssetPaths.title__png, false, 320, 180);

		_cursor = new FlxSprite(_menuPos.x - _menuSpacing, _menuPos.y);
		_cursor.loadGraphic(AssetPaths.hud__png, true, 8, 8);
		_cursor.animation.add("cursor", [1]);
		_cursor.animation.play("cursor");
		_cursor.offset.set(0, -4);

		add(_bg);
		add(_cursor);

		for (i in 0..._menuEntries.length)
		{
			var entry:FlxText = new FlxText(_menuPos.x, _menuPos.y + _menuSpacing * i);
			entry.text = _menuEntries[i];
			add(entry);
		}

		forEachOfType(FlxText, function(member)
		{
			member.setFormat(AssetPaths.pixel_font__ttf, 8, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, 0xff005784);
		});

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP)
			_selected -= 1;

		if (FlxG.keys.justPressed.DOWN)
			_selected += 1;

		_selected = FlxMath.wrap(_selected, 0, _menuEntries.length - 1);

		_cursor.y = _menuPos.y + _menuSpacing * _selected;

		if (FlxG.keys.justPressed.ENTER)
		{
			switch (_selected)
			{
				case 0:
					FlxG.switchState(new PlayState());

				case 1:
					System.exit(0);
			}
		}
	}
}
