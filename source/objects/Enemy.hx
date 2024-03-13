package objects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Enemy extends FlxSprite
{
	private static inline var GRAVITY:Int = 420;
	private static inline var WALK_SPEED:Int = 40;
	private static inline var FALLING_SPEED:Int = 200;
	private static inline var SCORE_AMOUNT:Int = 100;

	private var _direction:Int = -1;
	private var _appeared:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		acceleration.y = GRAVITY;
		maxVelocity.y = FALLING_SPEED;

		flipX = true;
		_direction = -1;
	}

	override public function update(elapsed:Float)
	{
		if (!inWorldBounds())
			exists = false;

		if (isOnScreen())
			_appeared = true;

		if (_appeared && alive)
		{
			move();

			if (justTouched(WALL))
				flipDirection();
		}

		if (!Reg.pause)
			super.update(elapsed);
	}

	private function flipDirection()
	{
		flipX = !flipX;
		_direction = -_direction;
	}

	private function move() {}

	public function interact(player:Player)
	{
		if (!alive)
			return;

		FlxObject.separateY(this, player);

		if ((player.velocity.y > 0) && (isTouching(UP)))
		{
			kill();
			player.jump();
		}
		else
			player.kill();
	}

	override public function kill()
	{
		alive = false;
		Reg.score += SCORE_AMOUNT;

		velocity.x = 0;
		acceleration.x = 0;
		animation.play("dead");

		new FlxTimer().start(1.0, function(_)
		{
			exists = false;
			visible = false;
		}, 1);
	}
}
