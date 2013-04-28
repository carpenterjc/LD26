package {
	import net.flashpunk.World;
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * @author jamescarpenter
	 */
	public class GameWorld extends World
	{
		public var level:int;
		public function GameWorld(l:int)
		{
			level = l;
		}
		
		override public function begin():void
		{
			var cross:Cross = new Cross(level);
			add(cross);

			if(level == 1)
			{
				add(new Nought(cross));
			}
			if(level == 2)
			{
				add(new Nought(cross));

				add(new Nought(cross));
				add(new Nought(cross));
			}
			if(level == 3)
			{
				add(new Nought(cross));

				add(new Nought(cross));
				add(new Nought(cross));

				add(new Nought(cross));
				add(new Nought(cross));
				add(new Nought(cross));
			}
			if(level == 4)
			{
				add(new Nought(cross));

				add(new Nought(cross));
				add(new Nought(cross));

				add(new Nought(cross));
				add(new Nought(cross));
				add(new Nought(cross));

				add(new Nought(cross));
				add(new Nought(cross));
				add(new Nought(cross));
				add(new Nought(cross));
			}

		}

	}
}
