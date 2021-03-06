package com.rutkoski.util
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Rodrigo Rutkoski Rodrigues
	 */
	public class Resize
	{
		
		public static function outside(containerWidth:Number, containerHeight:Number, contentWidth:Number, contentHeight:Number):Point
		{
			var w1:Number = containerWidth;
			var h1:Number = containerHeight;
			
			var w0:Number = contentWidth;
			var h0:Number = contentHeight;
			
			var w2:Number = w1;
			var h2:Number = h1;
			
			var prop:Number;
			
			if ((w0 / h0) > (w1 / h1)) {
				h2 = h1;
				prop = h2 / h0;
				w2 = w0 * prop;
			} else {
				w2 = w1;
				prop = w2 / w0;
				h2 = h0 * prop;
			}
			
			return new Point(w2, h2);
		}
		
		public static function inside(containerWidth:Number, containerHeight:Number, contentWidth:Number, contentHeight:Number):Point
		{
			var w1:Number = containerWidth;
			var h1:Number = containerHeight;
			
			var w0:Number = contentWidth;
			var h0:Number = contentHeight;
			
			var w2:Number = w1;
			var h2:Number = h1;
			
			var prop:Number;
			
			if ((w0 / h0) > (w1 / h1)) {
				w2 = w1;
				prop = w2 / w0;
				h2 = h0 * prop;
			} else {
				h2 = h1;
				prop = h2 / h0;
				w2 = w0 * prop;
			}
			
			return new Point(w2, h2);
		}
		
	}

}
