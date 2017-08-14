package 
{
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.text.modules.MySprite;
	
	import com.luaye.console.C;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import com.myflashlab.air.extensions.nativePermissions.PermissionCheck;
	
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 6/7/2016 4:38 PM
	 */
	public class Main extends Sprite 
	{
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function Main():void 
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
			
			stage.addEventListener(Event.RESIZE, onResize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			C.startOnStage(this, "`");
			C.commandLine = false;
			C.commandLineAllowed = false;
			C.x = 20;
			C.width = 250;
			C.height = 150;
			C.strongRef = true;
			C.visible = true;
			C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;
			
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.antiAliasType = AntiAliasType.ADVANCED;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.embedFonts = false;
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>Permission Check ANE V"+PermissionCheck.VERSION+"</b></font>";
			_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			this.addChild(_txt);
			
			_body = new Sprite();
			this.addChild(_body);
			
			_list = new List();
			_list.holder = _body;
			_list.itemsHolder = new Sprite();
			_list.orientation = Orientation.VERTICAL;
			_list.hDirection = Direction.LEFT_TO_RIGHT;
			_list.vDirection = Direction.TOP_TO_BOTTOM;
			_list.space = BTN_SPACE;
			
			onInit();
			onResize();
		}
		
		private function onInvoke(e:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
		}
		
		private function handleActivate(e:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(e:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
		}
		
		private function handleKeys(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK)
            {
				e.preventDefault();
				NativeApplication.nativeApplication.exit();
            }
		}
		
		private function onResize(e:*=null):void
		{
			if (_txt)
			{
				_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				
				C.x = 0;
				C.y = _txt.y + _txt.height + 0;
				C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
			}
			
			if (_list)
			{
				_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
				_list.row = _numRows;
				_list.itemArrange();
			}
			
			if (_body)
			{
				_body.y = stage.stageHeight - _body.height;
			}
		}
		
		private var _ex:PermissionCheck;
		private function onInit():void
		{
			_ex = new PermissionCheck();
			
			
			var btn0:MySprite = createBtn("check permissions", 0xFF9900);
			btn0.addEventListener(MouseEvent.CLICK, checkPermissions);
			_list.add(btn0);
			
			function checkPermissions(e:MouseEvent):void
			{
				var permissionState:int;
				
				C.log("");
				
				// ----------------------------------------------------------------------- on both platforms
				permissionState = _ex.check(PermissionCheck.SOURCE_CAMERA);
				C.log("PermissionCheck.SOURCE_CAMERA = " + prettify(permissionState));
				
				permissionState = _ex.check(PermissionCheck.SOURCE_MIC);
				C.log("PermissionCheck.SOURCE_MIC = " + prettify(permissionState));
				
				permissionState = _ex.check(PermissionCheck.SOURCE_CONTACTS);
				C.log("PermissionCheck.SOURCE_CONTACTS = " + prettify(permissionState));
				
				permissionState = _ex.check(PermissionCheck.SOURCE_CALENDAR);
				C.log("PermissionCheck.SOURCE_CALENDAR = " + prettify(permissionState));
				
				// ----------------------------------------------------------------------- on iOS ONLY
				if (_ex.os == PermissionCheck.IOS)
				{
					permissionState = _ex.check(PermissionCheck.SOURCE_PHOTOS);
					C.log("PermissionCheck.SOURCE_PHOTOS = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_REMINDER);
					C.log("PermissionCheck.SOURCE_REMINDER = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_LOCATION_ALWAYS);
					C.log("PermissionCheck.SOURCE_LOCATION_ALWAYS = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_LOCATION_WHEN_IN_USE);
					C.log("PermissionCheck.SOURCE_LOCATION_WHEN_IN_USE = " + prettify(permissionState));
				}
				
				// ----------------------------------------------------------------------- on Android ONLY
				if (_ex.os == PermissionCheck.ANDROID)
				{
					permissionState = _ex.check(PermissionCheck.SOURCE_PHONE);
					C.log("PermissionCheck.SOURCE_PHONE = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_STORAGE);
					C.log("PermissionCheck.SOURCE_STORAGE = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_LOCATION);
					C.log("PermissionCheck.SOURCE_LOCATION = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_SENSORS);
					C.log("PermissionCheck.SOURCE_SENSORS = " + prettify(permissionState));
					
					permissionState = _ex.check(PermissionCheck.SOURCE_SMS);
					C.log("PermissionCheck.SOURCE_SMS = " + prettify(permissionState));
				}
				
				C.log("");
				C.log("----------------");
			}
			
			var btn00:MySprite = createBtn("Open Settings", 0xFF9900);
			btn00.addEventListener(MouseEvent.CLICK, openSettings);
			_list.add(btn00);
			
			function openSettings(e:MouseEvent):void
			{
				_ex.openSettings();
			}
			
			// -------------------------------------------------------------------- on both platforms
			
			var btn1:MySprite = createBtn("request CAMERA");
			btn1.addEventListener(MouseEvent.CLICK, requestCamera);
			_list.add(btn1);
			
			function requestCamera(e:MouseEvent):void
			{
				_ex.request(PermissionCheck.SOURCE_CAMERA, onRequestResult);
			}
			
			var btn2:MySprite = createBtn("request MIC");
			btn2.addEventListener(MouseEvent.CLICK, requestMic);
			_list.add(btn2);
			
			function requestMic(e:MouseEvent):void
			{
				_ex.request(PermissionCheck.SOURCE_MIC, onRequestResult);
			}
			
			var btn4:MySprite = createBtn("request CONTACTS");
			btn4.addEventListener(MouseEvent.CLICK, requestCONTACTS);
			_list.add(btn4);
			
			function requestCONTACTS(e:MouseEvent):void
			{
				_ex.request(PermissionCheck.SOURCE_CONTACTS, onRequestResult);
			}
			
			var btn5:MySprite = createBtn("request CALENDAR");
			btn5.addEventListener(MouseEvent.CLICK, requestCALENDAR);
			_list.add(btn5);
			
			function requestCALENDAR(e:MouseEvent):void
			{
				_ex.request(PermissionCheck.SOURCE_CALENDAR, onRequestResult);
			}
			
			// ----------------------------------------------------------------------- on iOS ONLY
			if (_ex.os == PermissionCheck.IOS)
			{
				var btn3:MySprite = createBtn("request PHOTOS");
				btn3.addEventListener(MouseEvent.CLICK, requestPHOTOS);
				_list.add(btn3);
				
				function requestPHOTOS(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_PHOTOS, onRequestResult);
				}
				
				var btn6:MySprite = createBtn("request REMINDER");
				btn6.addEventListener(MouseEvent.CLICK, requestREMINDER);
				_list.add(btn6);
				
				function requestREMINDER(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_REMINDER, onRequestResult);
				}
				
				var btn20:MySprite = createBtn("request LOCATION when in use");
				btn20.addEventListener(MouseEvent.CLICK, requestLocationWhenInUse);
				_list.add(btn20);
				
				function requestLocationWhenInUse(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_LOCATION_WHEN_IN_USE, onRequestResult);
				}
				
				var btn21:MySprite = createBtn("request LOCATION always access");
				btn21.addEventListener(MouseEvent.CLICK, requestLocationAlways);
				_list.add(btn21);
				
				function requestLocationAlways(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_LOCATION_ALWAYS, onRequestResult);
				}
			}
			
			// ----------------------------------------------------------------------- on Android ONLY
			if (_ex.os == PermissionCheck.ANDROID)
			{
				var btn7:MySprite = createBtn("request PHONE");
				btn7.addEventListener(MouseEvent.CLICK, requestPHONE);
				_list.add(btn7);
				
				function requestPHONE(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_PHONE, onRequestResult);
				}
				
				var btn8:MySprite = createBtn("request STORAGE");
				btn8.addEventListener(MouseEvent.CLICK, requestSTORAGE);
				_list.add(btn8);
				
				function requestSTORAGE(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_STORAGE, onRequestResult);
				}
				
				var btn9:MySprite = createBtn("request LOCATION");
				btn9.addEventListener(MouseEvent.CLICK, requestLOCATION);
				_list.add(btn9);
				
				function requestLOCATION(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_LOCATION, onRequestResult);
				}
				
				var btn10:MySprite = createBtn("request SENSORS");
				btn10.addEventListener(MouseEvent.CLICK, requestSENSORS);
				_list.add(btn10);
				
				function requestSENSORS(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_SENSORS, onRequestResult);
				}
				
				var btn11:MySprite = createBtn("request SMS");
				btn11.addEventListener(MouseEvent.CLICK, requestSMS);
				_list.add(btn11);
				
				function requestSMS(e:MouseEvent):void
				{
					_ex.request(PermissionCheck.SOURCE_SMS, onRequestResult);
				}
			}
		}
		
		private function onRequestResult($state:int):void
		{
			C.log("permission result = " + prettify($state));
		}
		
		private function prettify($state:int):String
		{
			var str:String;
			
			switch($state)
			{
				case PermissionCheck.PERMISSION_UNKNOWN:
					
					str = "UNKNOWN";
					
					break;
				case PermissionCheck.PERMISSION_DENIED:
					
					str = "DENIED";
					
					break;
				case PermissionCheck.PERMISSION_GRANTED:
					
					str = "GRANTED";
					
					break;
				case PermissionCheck.PERMISSION_OS_ERR:
					
					str = "Not available on this OS!";
					
					break;
			}
			
			return str;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function createBtn($str:String, $bgColor:uint=0xDFE4FF):MySprite
		{
			var sp:MySprite = new MySprite();
			sp.addEventListener(MouseEvent.MOUSE_OVER,  onOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT,  onOut);
			sp.addEventListener(MouseEvent.CLICK,  onOut);
			sp.bgAlpha = 1;
			sp.bgColor = $bgColor;
			sp.drawBg();
			sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
			sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;
			
			function onOver(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xFFDB48;
				sp.drawBg();
			}
			
			function onOut(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = $bgColor;
				sp.drawBg();
			}
			
			var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
			
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.mouseEnabled = false;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
			txt.defaultTextFormat = format;
			txt.text = $str;
			
			txt.y = sp.height - txt.height >> 1;
			sp.addChild(txt);
			
			return sp;
		}
	}
	
}