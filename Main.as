package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	public class Main extends Engine
	{
		public function Main()
		{
			super(640, 480, 60, false);
			FP.world = new IntroWorld(1);
			//FP.console.enable();
			FP.screen.scale = 2;
			FP.screen.color = 0xFFF7EA;
		}


	}
}