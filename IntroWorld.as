package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * @author jamescarpenter
	 */
	public class IntroWorld extends World
	{
		private var waited:Boolean = false;

		public function IntroWorld()
		{
			
		}
		
		override public function begin():void
		{
			var statusentity:Entity = new Entity();
			var statusstring:Text = new Text("Your a x, you don't like the o's they multiply, mess up the place, and spoil the otherwise spotles world. Rid the world of them.");
			statusentity.graphic = statusstring;
			add(statusentity);
			FP.alarm(2, timeout);
		}

		override public function update():void
		{
			if(Input.check(Key.SPACE) && waited)
			{
				//FP.world = new EditorWorld();
			}
		}
		public function timeout() :void
		{
			waited = true;
		}
	}
}
