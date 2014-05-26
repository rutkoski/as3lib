package com.rutkoski.util
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;

	public class Console
	{

		public static function log(o:*)
		{
			if (isBrowser) {
				ExternalInterface.call('console.log', o);
			} else {
				trace(o);
			}
		}

		protected static function get isBrowser():Boolean
		{
			var type:String = Capabilities.playerType;
			return (type == 'ActiveX' || type == 'PlugIn');
		}

	}

}