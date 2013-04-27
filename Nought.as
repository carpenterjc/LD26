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
			sprite.x = 0; 
			sprite.y = 0;
			height = 16;
			width = 32;
			setHitbox(16, 16, 16, 0);
			type = "nought";
			state = "waiting";


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
