package  
{
	
	import com.bit101.components.PushButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author umhr
	 */
	public class EmbedDemo extends Sprite 
	{
		[Embed(source="デモファイル.pptx", mimeType="application/octet-stream")] 
		private const EmbedClass:Class;
		
		public function EmbedDemo() 
		{
			var textField:TextField = new TextField();
			textField.defaultTextFormat = new TextFormat("_sans", 12, 0x666666);
			textField.text = "コンパイル時にEmbedしたファイルをダウンロードします。";
			textField.width = 400;
			textField.height = 25;
			textField.x = 10;
			textField.y = 0;
			addChild(textField);
			
			new PushButton(this, 10, 25, "Save Embeded file", onEmbed);
		}
		
		private function onEmbed(event:Event):void 
		{
			var byteArray:ByteArray = new EmbedClass();
			
			var fileReference:FileReference = new FileReference();
			fileReference.save(byteArray, "デモファイル.pptx");
			fileReference.addEventListener(Event.COMPLETE, save_complete);
		}
		
		private function save_complete(event:Event):void 
		{
			trace("save_complete");
		}
		
	}
	
}