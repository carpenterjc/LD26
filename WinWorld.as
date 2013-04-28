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
	public class WinWorld extends World
	{
		private var waited:Boolean = false;
		[Embed(source = 'graphics/win.png')] private const WIN:Class;
		public var win:Image = new Image(WIN);


		public function WinWorld()
		{
	
		}
		
		override public function begin():void
		{

			var statusentity:Entity = new Entity();
			statusentity.graphic = win;
			add(statusentity);
			

		}

	}
}
