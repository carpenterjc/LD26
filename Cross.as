package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import mx.utils.ObjectUtil;
	import net.flashpunk.Sfx;
	
	// States
	// Drawing up/down, Drawing left/right,
	// freemoving

	public class Cross extends Entity
	{
		[Embed(source = 'graphics/cross.png')] private const SPRITE:Class;
		public var sprite:Spritemap = new Spritemap(SPRITE, 16, 16);

		private var drawing:Boolean = false; 
		private var drawingDirection:Point = new Point(0,0);
		private var _velocity:Point;

		public function Cross()
		{
			sprite.add("stand", [0], 10, true);
			setHitbox(14,14,1,1);
			sprite.x = -8;
			sprite.y = -8;
			width = 14
			height = 14;
			type = "cross";
			x = 640/4;
			y = 480/4;
			originX = 8;
			originY = 8;
			_velocity = new Point;

			graphic = sprite;

		}

		// Returns true if your only moving in an x or y direction
		private function isSingleDirection(p: Point) : Boolean
		{
			return ( p.y ==0 && p.x != 0 ) || (p.y != 0 && p.y == 0);
		}

        override public function update():void
		{

			var movement:Point = new Point;
			if (Input.check(Key.UP)) movement.y--;
			if (Input.check(Key.DOWN)) movement.y++;
			if (Input.check(Key.LEFT)) movement.x--;
			if (Input.check(Key.RIGHT)) movement.x++;
			if(Input.check(Key.SPACE) && isSingleDirection(movement))
			{


			}

			_velocity.x = 100 * FP.elapsed * movement.x;
			_velocity.y = 100 * FP.elapsed * movement.y;			

			x += _velocity.x;

			y += _velocity.y;
			super.update();
		}

	}
}