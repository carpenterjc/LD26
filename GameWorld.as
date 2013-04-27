package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	/**
	 * @author jamescarpenter
	 */
	public class GameWorld extends World
	{
		public function GameWorld()
		{
			
		}
		
		override public function begin():void
		{
			var cross:Cross = new Cross();
			add(cross);
			add(new Nought(cross));
		}

	}
}
