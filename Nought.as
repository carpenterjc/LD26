package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import mx.utils.ObjectUtil;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.tweens.motion.LinearMotion;


	public class Nought extends Entity
	{
		[Embed(source = 'graphics/nought.png')] private const SPRITE:Class;
		public var sprite:Spritemap = new Spritemap(SPRITE, 32, 16, onAmimationFinished);
		[Embed(source = 'graphics/noughtmask.png')] private const MASK:Class;
		public var spritemask:Image = new Image(MASK);


		// States: moving, breeding, waiting, dieing, eatcross
		private var state: String; 
		private var desiredLocation: Point; // Where it wants to move to
		private var cross: Cross;
		private var alarm:Alarm = new Alarm(1, onWakeup);
		private var positiontween:LinearMotion = new LinearMotion(onFinshiedMoving);



		public function Nought(c:Cross)
		{
			cross = c;
			sprite.add("waiting", [0], 5, true);
			sprite.add("moving", [0, 1, 2, 3], 5, true);
			sprite.add("breeding",[0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 5, false);
			sprite.x = -16; 
			sprite.y = -8;
			mask=new Pixelmask(MASK, -8, -8);
			height = 14;
			width = 14;
			originX = 8;
			originY = 8;

			type = "nought";
			state = "waiting";
			graphic = sprite;
			var pos:Point = findNewPosition();
			x = pos.x;
			y = pos.y;
			positiontween.x = pos.x;
			positiontween.y = pos.y;
			
			addTween(positiontween, true);
			addTween(alarm, true);
			wait();



		}

		public override function update() : void
		{
			x = positiontween.x;
			y = positiontween.y;

			if(x == cross.x && y == cross.y)
			{
				cross.die();
			}

			if(collide("cross", x, y))
			{
				eatCross();
			}

		}

		public function onFinshiedMoving():void
		{
			if(state != "eatcross")
			{
				wait();
			}
		}

		public function onAmimationFinished():void
		{
			if(state == "breeding")
			{
				var nought:Nought = new Nought(cross);
				nought.x = x + 8;
				nought.y = y;
				world.add(nought);
				x = x - 8;

				wait();
			}	
		}

		public function onWakeup() : void
		{
			decideWhatToDoNext();
		}


		private function decideWhatToDoNext():void
		{
			var chance:Number = Math.random()*10;
			if(chance > 6)
			{
				decidedToBreed();
			} 
			else
			{
				decidedToMove();
			}
		}

		private function decidedToBreed():void
		{
			sprite.play("breeding");
			state = "breeding";
		}

		private function decidedToMove() : void
		{
			state = "moving";
			desiredLocation = findNewPosition();
			sprite.play("moving");
			var pos:Point = findNewPosition();
			positiontween.setMotion(x, y, pos.x, pos.y, 5);
			

		}

		private function wait() : void
		{
			state = "waiting";
			alarm.reset((Math.random()*10)+1);
			sprite.play("waiting");
		}



		private function eatCross(): void
		{
			if(state != "eatcross")
			{
				cross.stun();
				state = "eatcross";

				sprite.play("moving");
				
				positiontween.setMotion(x, y, cross.x, cross.y, 0.5);
			}
		}

		public function findNewPosition() : Point
		{
			return new Point(Math.random()*((640/2)-24)+24, Math.random()*((480/2)-8)+8);
		}

	}

}
