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

		[Embed(source = 'graphics/select.png')] private const SELECT:Class;
		public var select:Image = new Image(SELECT);


		[Embed(source = 'audio/introwaltz.mp3')] private const WALTZ:Class;
		public var waltz:Sfx = new Sfx(WALTZ);	

		public var level: int;


		public function IntroWorld(l: int)
		{
			level = l;	
		}
		
		override public function begin():void
		{
			FP.log("IntroWorld.begin");

			if(level == 5)
			{
				FP.world = new WinWorld();
				return;
			}
			var statusentity:Entity = new Entity();
			statusentity.graphic = intro;
			add(statusentity);

			var selectentity:Entity = new Entity();
			selectentity.graphic = select;
			selectentity.y = 146 + (level-1)*25;
			add(selectentity);
			waltz.loop(0.8);
			FP.alarm(2, timeout);
		}


		override public function update():void
		{
			
			if(Input.check(Key.SPACE) && waited)
			{
				waltz.stop();
				FP.world = new GameWorld(level);
			}
		}
		public function timeout() :void
		{
			waited = true;
		}
	}
}
