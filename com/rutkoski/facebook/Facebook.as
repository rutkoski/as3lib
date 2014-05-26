package com.rutkoski.facebook
{
	import flash.external.ExternalInterface;
	import com.rutkoski.util.Console;

	public class Facebook
	{

		private static var instance:Facebook;

		private var _cb:Function;
		
		public var accessToken:String;

		public var userID:String;

		public static function getInstance():Facebook
		{
			if (instance == null) {
				instance = new Facebook  ;
			}
			return instance;
		}

		public function init(app_id:String, params:Object = null):void
		{
			ExternalInterface.addCallback('onLogin', this.onLogin);
			ExternalInterface.addCallback('onApi', this.onApi);

			params.appId = app_id;

			ExternalInterface.call('FBAS.init', params || {});
		}

		public function login(params:Object = null, cb:Function = null):void
		{
			_cb = cb;
			ExternalInterface.call('FBAS.login', params || {});
		}

		public function api(path:String, method:String = 'GET', params:Object = null, cb:Function = null):void
		{
			_cb = cb;
			ExternalInterface.call('FBAS.api', path, method, params || {});
		}
		
		public function canvasSetSize(width:uint, height:uint):void
		{
			ExternalInterface.call('FBAS.canvasSetSize', width, height);
		}

		/////////////////;

		public static const STATUS_NOT_AUTHORIZED:String = 'not_authorized';

		public static const STATUS_CONNECTED:String = 'connected';

		private function onLogin(result:*):void
		{
			if (result.authResponse != undefined) {
				accessToken = result.authResponse.accessToken || '';
				userID = result.authResponse.userID || '';

				/*var signedRequest:Array = result.authResponse.signedRequest.split('.', 2);
				var encoded_sig:String = signedRequest[0];
				var payload:String = signedRequest[1];
				
				encoded_sig = encoded_sig.replace(/-/, '+').replace('_', '/');
				
				while (encoded_sig.match(/-/)) {
				payload = encoded_sig.replace(/-/, '+');//.replace(/_/, '/');
				}
				
				while (encoded_sig.match(/_/)) {
				payload = encoded_sig.replace(/_/, '/');//.replace(/_/, '/');
				}
				
				
				//var sig:* = Base64.decode(encoded_sig);
				
				var data:* = JSON.decode(Base64.decode(payload));
				//= json_decode(base64_decode(strtr($payload, '-_', '+/'), true));
				//$signedRequest = $data;
				Console.log(data);return;*/
			}

			if (_cb is Function) {
				_cb.call(this, result);
			}
		}

		private function onApi(result:*):void
		{
			if (_cb is Function) {
				_cb.call(this, result);
			}
		}

	}

}