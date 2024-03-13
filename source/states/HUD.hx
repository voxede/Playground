package states;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxSpriteGroup
{
	private var _textScore:FlxText;

	static inline var OFFSET:Int = 4;

	public function new()
	{
		super();

		_textScore = new FlxText(OFFSET, OFFSET, 0);
		add(_textScore);

		_textScore.scrollFactor = new FlxPoint(0, 0);
	}

	override public function update(elapsed:Float)
	{
		_textScore.text = "SCORE\n" + StringTools.lpad(Std.string(Reg.score), "0", 5);
		super.update(elapsed);
	}
}
