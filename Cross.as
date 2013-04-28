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
	import net.flashpunk.utils.Draw;
	import flash.geom.Rectangle;


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
		private var graphicList:Graphiclist;
		private var state:String = "normal";
		private var startPos:Point = new Point(0,0);
		private var selectImage:Image = Image.createRect(1,1,0x5A1D33, 0.5);

		[Embed(source = 'audio/click.mp3')] private const CLICK:Class;
		public var clicksound:Sfx = new Sfx(CLICK);	


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
			trailEmitter.setMotion("trail", 0,0,2);
			trailEmitter.setColor("trail", 0x5A1D33);
			graphicList = new Graphiclist(sprite, trailEmitter, selectImage);
			selectImage.visible = false;
			graphic = graphicList;

		}

		public override function render():void 
		{
			super.render();
			if(FP.console.paused)
			{
				if(state == "selecting")
				{
					var selectRect:Rectangle = new Rectangle(takeIfNegativeDelta(x, selectImage.scaleX), takeIfNegativeDelta(y, selectImage.scaleY), Math.abs(selectImage.scaleX), Math.abs(selectImage.scaleY));
					Draw.rectPlus(selectRect.x, selectRect.y, selectRect.width, selectRect.height, 0xFF0000, 1, false);
				}
				var possibilities:Vector.<Nought> = new Vector.<Nought>();
				world.getType("nought", possibilities);
				for(var i:int = 0; i < possibilities.length; ++i)
				{

					var possrect:Rectangle = new Rectangle(possibilities[i].x-8, possibilities[i].y-8, possibilities[i].width, possibilities[i].height);
					Draw.rectPlus(possrect.x, possrect.y, possrect.width, possrect.height, 0xFF0000, 1, false);

				}
			
			}
		}

		// Returns true if your only moving in an x or y direction
		private function isSingleDirection(p: Point) : Boolean
		{
			return ( p.y ==0 && p.x != 0 ) || (p.y != 0 && p.x == 0) || (p.x==0 && p.y==0) ;
		}

		private function takeIfNegativeDelta(n:Number, d: Number) : Number
		{
			if(d < 0)
			{
				return n + d;
			}
			return n;
		}

		private function getSelectedNoughts() : Vector.<Nought>
		{
			var possibilities:Vector.<Nought> = new Vector.<Nought>();
			var actuals:Vector.<Nought> = new Vector.<Nought>();
			var selectRect:Rectangle = new Rectangle(takeIfNegativeDelta(x, selectImage.scaleX), takeIfNegativeDelta(y, selectImage.scaleY), Math.abs(selectImage.scaleX), Math.abs(selectImage.scaleY));
			world.getType("nought", possibilities);
			for(var i:int = 0; i < possibilities.length; ++i)
			{

				var possrect:Rectangle = new Rectangle(possibilities[i].x-8, possibilities[i].y-8, possibilities[i].width, possibilities[i].height);

				if(selectRect.containsRect(possrect))
				{
					actuals.push(possibilities[i])
				}	
			}

			return actuals;
		}

		private function killNoughts():void
		{
			var possibilities:Vector.<Nought> = getSelectedNoughts();
			if(possibilities.length == 1)
			{
				possibilities[0].die();
			}
		}


        override public function update():void
		{

			var movement:Point = new Point;
			if (Input.check(Key.UP) && !stunned) movement.y--;
			if (Input.check(Key.DOWN) && !stunned) movement.y++;
			if (Input.check(Key.LEFT) && !stunned) movement.x--;
			if (Input.check(Key.RIGHT) && !stunned) movement.x++;
			if(Input.check(Key.SPACE) && !stunned )
			{

				if(isSingleDirection(movement))
				{
					if(state!="selecting")
					{				
						startPos.x = x;
						startPos.y = y;
						state = "selecting";					
						selectImage.visible = true;
						clicksound.play(0.5, (x-160)/160.0)
					}				
					selectImage.scaleX = startPos.x - x;
					selectImage.scaleY = startPos.y - y;
					if(getSelectedNoughts().length != 1)
					{
						selectImage.alpha = 0.2;
					} 
					else
					{
						selectImage.alpha = 0.7;
					}

				}
				else 
				{
					movement.x = 0; 
					movement.y = 0;
				}


			}
			else
			{
				if(state == "selecting")
				{
					selectImage.visible = false;
					state= "normal";
					killNoughts();
				}
			}
			trailEmitter.emit("trail", x, y);

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