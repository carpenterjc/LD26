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
	
	public class Nought extends Entity
	{
		[Embed(source = 'graphics/nought.png')] private const SPRITE:Class;
		public var sprite:Spritemap = new Spritemap(SPRITE, 32, 16);


		// States: moving, breeding, waiting, dieing 
		private var state: String; 
		private var desiredLocation: Point; // Where it wants to move to

		public function Nought(cross:Cross)
		{
			sprite.add("waiting", [0], 5, true);
			sprite.x = -16; 
			sprite.y = -8;
			height = 14;
			width = 14;
			originX = -8;
			originY = -8;

			type = "nought";
			state = "waiting";
			graphic = sprite;
			var pos:Point = findNewPosition();
			x = pos.x;
			y = pos.y;
		}

		public function findNewPosition() : Point
		{
			return new Point(Math.random()*640/2, Math.random()*480/2);
		}

		public function enterMovingState() : void
		{
			state = "moving";
			desiredLocation = findNewPosition();
		}

	}

}
