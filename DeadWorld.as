package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;


	/**
	 * @author jamescarpenter
	 */
	public class DeadWorld extends World
	{
		private var waited:Boolean = false;
		[Embed(source = 'graphics/nought.png')] private const SPRITE:Class;
		public var sprite:Spritemap = new Spritemap(SPRITE, 32, 16);


		[Embed(source = 'audio/lotsbubbles.mp3')] private const BUBBLE:Class;
		public var bubble:Sfx = new Sfx(BUBBLE);	

		private var level: int;

		public function DeadWorld(l: int)
		{
			level = l;
		}
		
		override public function begin():void
		{
			sprite.add("deadworld - waiting", [0], 5, true);		
			FP.log("begin");
			bubble.play();
			FP.alarm(0.1, moreNoughts);
			FP.alarm(5, timeout);
			
		}


		public function moreNoughts():void
		{
			FP.log("deadworld - moreNoughts");
			if(waited == false)
			{
				for(var  i:int = 0 ; i < 10; i++)
				{
					var nought:Entity = new Entity();
					nought.graphic = sprite;
					
					nought.x = Math.random()*((640/2)-24)
					nought.y = Math.random()*((480/2)-8)+8;
					FP.world.add(nought);
				}
				FP.alarm(0.1, moreNoughts);
			}
		}


		override public function update():void
		{

			if(Input.check(Key.SPACE) && waited)
			{
				FP.log("deadworld - space");
				FP.world = new IntroWorld(level);
			}
		}
		public function timeout() :void
		{
			FP.log("deadworld - timout");
			waited = true;
		}
	}
}
