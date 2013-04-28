package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;

	/**
	 * @author jamescarpenter
	 */
	public class IntroWorld extends World
	{
		private var waited:Boolean = false;
		[Embed(source = 'graphics/intro.png')] private const INTRO:Class;
		public var intro:Image = new Image(INTRO);
		public var level: int;


		public function IntroWorld(l: int)
		{
			level = l;	
		}
		
		override public function begin():void
		{

			var statusentity:Entity = new Entity();
			statusentity.graphic = intro;
			add(statusentity);
			FP.alarm(2, timeout);
		}


		override public function update():void
		{
			if(Input.check(Key.SPACE) && waited)
			{
				FP.world = new GameWorld(level);
			}
		}
		public function timeout() :void
		{
			waited = true;
		}
	}
}
