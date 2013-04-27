package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import mx.utils.ObjectUtil;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import flash.display.BitmapData;

	// States
	// Drawing up/down, Drawing left/right,
	// freemoving

	public class Cross extends Entity
	{
		[Embed(source = 'graphics/cross.png')] private const SPRITE:Class;
		public var sprite:Spritemap = new Spritemap(SPRITE, 16, 16);
		[Embed(source = 'graphics/crossmask.png')] private const MASK:Class;
		public var spritemask:Image = new Image(MASK);

		private var drawing:Boolean = false; 
		private var drawingDirection:Point = new Point(0,0);
		private var _velocity:Point;
		private var stunned:Boolean = false; // We have been stunned by a Nought
		private var	trailEmitter:Emitter;

		public function Cross()
		{
			sprite.add("stand", [0], 10, true);
			sprite.add("die", [4,8], 10, false);
			mask=new Pixelmask(MASK, -8, -8);
			//setHitbox(14,14,1,1);
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

			trailEmitter = new Emitter(new BitmapData(1,1),1, 1);
			trailEmitter.newType("trail", [0]);
			trailEmitter.relative = false;
			trailEmitter.setAlpha("trail", 1, 0);
			trailEmitter.setMotion("trail", 0,0,10);
			trailEmitter.setColor("trail", 0x5A1D33);
			
			graphic = new Graphiclist(sprite, trailEmitter);

		}

		// Returns true if your only moving in an x or y direction
		private function isSingleDirection(p: Point) : Boolean
		{
			return ( p.y ==0 && p.x != 0 ) || (p.y != 0 && p.y == 0);
		}



        override public function update():void
		{

			var movement:Point = new Point;
			if (Input.check(Key.UP) && !stunned) movement.y--;
			if (Input.check(Key.DOWN) && !stunned) movement.y++;
			if (Input.check(Key.LEFT) && !stunned) movement.x--;
			if (Input.check(Key.RIGHT) && !stunned) movement.x++;
			if(Input.check(Key.SPACE) && !stunned && isSingleDirection(movement))
			{
				trailEmitter.emit("trail", x, y);
			}

			_velocity.x = 100 * FP.elapsed * movement.x;
			_velocity.y = 100 * FP.elapsed * movement.y;			

			x += _velocity.x;

			y += _velocity.y;
			super.update();
		}

		public function stun() : void
		{
			stunned = true;
		}

		public function die() : void
		{
			sprite.play("die");

		}
	}
}