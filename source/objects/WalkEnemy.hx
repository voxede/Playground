package objects;

class WalkEnemy extends Enemy
{
	private static var WALK_SPEED:Int = 40;
	private static var SCORE_AMOUNT:Int = 100;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.enemyA__png, true, 16, 16);
		animation.add("walk", [0, 1], 12);
		animation.add("dead", [2], 12);
		animation.play("walk");

		setSize(12, 12);
		offset.set(2, 4);
	}

	override private function move()
	{
		velocity.x = _direction * WALK_SPEED;
	}
}
