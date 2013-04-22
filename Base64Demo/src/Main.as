package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 300, backgroundColor = 0xDDDDDD, frameRate = 30)]
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			addChild(new Canvas());
			
			addChild(new Stats()).x = stage.stageWidth - 70;
		}
		
	}
	
}