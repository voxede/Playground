package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{
	private static inline var ACCELERATION:Int = 320;
	private static inline var DRAG:Int = 320;
	private static inline var GRAVITY:Int = 600;
	private static inline var JUMP_FORCE:Int = -280;
	private static inline var WALK_SPEED:Int = 80;
	private static inline var RUN_SPEED:Int = 140;
	private static inline var FALLING_SPEED:Int = 300;

	public var direction:Int = 1;

	public function new()
	{
		super();
		loadGraphic(AssetPaths.player__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [1, 2, 3, 2], 12);
		animation.add("skid", [4]);
		animation.add("jump", [5]);
		animation.add("fall", [5]);
		animation.add("dead", [12]);

		setSize(8, 12);
		offset.set(4, 4);

		drag.x = DRAG;
		acceleration.y = GRAVITY;
		maxVelocity.set(WALK_SPEED, FALLING_SPEED);
	}

	override public function update(elapsed:Float)
	{
		if (!Reg.pause)
			move();

		animate();

		super.update(elapsed);
	}

	private function move()
	{
		acceleration.x = 0;

		if (x < 0)
			x = 0;

		if (FlxG.keys.pressed.LEFT)
		{
			flipX = true;
			direction = -1;
			acceleration.x -= ACCELERATION;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			flipX = false;
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0)
		{
			if (FlxG.keys.justPressed.C && isTouching(FLOOR))
				jump();

			if (FlxG.keys.pressed.X)
				maxVelocity.x = RUN_SPEED;
			else
				maxVelocity.x = WALK_SPEED;
		}

		if ((velocity.y < 0) && (FlxG.keys.justReleased.C))
			velocity.y = velocity.y * 0.5;

		if (y > Reg.PS.map.height - height)
			kill();
	}

	private function animate()
	{
		if (!alive)
			animation.play("dead");
		else if ((velocity.y <= 0) && (!isTouching(FLOOR)))
			animation.play("jump");
		else if (velocity.y > 0)
			animation.play("fall");
		else if (velocity.x == 0)
			animation.play("idle");
		else
		{
			if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction))
				animation.play("skid");
			else
				animation.play("walk");
		}
	}

	public function jump()
	{
		if (FlxG.keys.pressed.C)
			velocity.y = JUMP_FORCE;
		else
			velocity.y = JUMP_FORCE / 2;
	}

	override public function kill()
	{
		if (alive)
		{
			alive = false;
			velocity.set(0, 0);
			acceleration.set(0, 0);
			Reg.lives -= 1;
			Reg.pause = true;
			new FlxTimer().start(2.0, function(_)
			{
				acceleration.y = GRAVITY;
				jump();
			}, 1);
			new FlxTimer().start(6.0, function(_)
			{
				FlxG.resetState();
			});
		}
	}
}
