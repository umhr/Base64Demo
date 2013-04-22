package  
{
	
	import com.bit101.components.PushButton;
	import com.hurlant.util.Base64;
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
	public class LoadSaveDemo extends Sprite 
	{
		private var _fileReference:FileReference = new FileReference();
		private var _str:String;
		private var _fileName:String;
		private var _saveButton:PushButton;
		private var _base64TextField:TextField = new TextField();
		
		public function LoadSaveDemo() 
		{
			var textField:TextField = new TextField();
			textField.defaultTextFormat = new TextFormat("_sans", 12, 0x666666);
			textField.text = "Load Fileで取得したデータをBase64でエンコードし、Stringにします。\n";
			textField.appendText("Save Loaded FileでStringをBase64でデコードして、ByteArrayに戻します。");
			textField.width = 400;
			textField.height = 40;
			textField.x = 10;
			textField.y = 105;
			addChild(textField);
			
			_base64TextField.defaultTextFormat = new TextFormat("_sans", 12, 0x666666);
			_base64TextField.border = true;
			_base64TextField.width = 445;
			_base64TextField.height = 120;
			_base64TextField.wordWrap = true;
			_base64TextField.multiline = true;
			_base64TextField.x = 10;
			_base64TextField.y = 170;
			
			addChild(_base64TextField);
			
			new PushButton(this, 10, 145, "Load File", onLoad);
			_saveButton = new PushButton(this, 120, 145, "Save Loaded File", onSave);
			_saveButton.enabled = false;
		}
		
		private function onLoad(event:Event):void 
		{
			_fileReference.addEventListener(Event.SELECT, fileReference_select);
			_fileReference.browse();
		}
		
		private function fileReference_select(event:Event):void 
		{
			_fileReference.removeEventListener(Event.SELECT, fileReference_select);
			_fileReference.addEventListener(Event.COMPLETE, fileReference_complete);
			_fileName = _fileReference.name;
			_fileReference.load();
		}
		
		private function fileReference_complete(event:Event):void 
		{
			_fileReference.removeEventListener(Event.COMPLETE, fileReference_complete);
			
			var byteArray:ByteArray = event.target.data as ByteArray;
			byteArray.compress();
			
			_str = Base64.encodeByteArray(byteArray);
			
			if (_str.length < 1000 * 1000) {
				_base64TextField.text = _str;
			}else {
				_base64TextField.text = "大きすぎるので表示はしません。Stringにはなっている、ハズ";
			}
			
			_saveButton.enabled = true;
		}
		
		private function onSave(event:Event):void 
		{
			var byteArray:ByteArray = Base64.decodeToByteArray(_str);
			byteArray.uncompress();
			
			var fileReference:FileReference = new FileReference();
			fileReference.save(byteArray, "clone_" + _fileName);
			fileReference.addEventListener(Event.COMPLETE, save_complete);
		}
		
		private function save_complete(event:Event):void 
		{
			trace("save_complete");
		}
		
	}
	
}