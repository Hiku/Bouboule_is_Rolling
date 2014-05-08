package  {
		import flash.geom.Point;
		import flash.events.Event;
		import flash.display.Sprite;

	public class Vent extends Sprite{
		var pts:Array = [new Point(0,0)]
		var angle:Number = 0;
		var modAngle:Number = 0;
		var Randomness:Number = 0;
		var l:int = 50;
		var sp:Number = 3;
		var Longueur:int = 20;

		public function Vent() {
			addEventListener(Event.ENTER_FRAME, eFrame)
		}
		function eFrame(e:Event){
			if(pts.length>0){
				l--;
				modAngle+=(Math.random()*2-1)*0.1
				angle+=modAngle;
				angle*=0.80;
				modAngle*=0.95+(Randomness*0.05);
				pts.push(new Point(pts[pts.length-1].x + (Math.cos(angle)*3+1-Randomness)*sp,pts[pts.length-1].y + (Math.sin(angle)*2)*sp))
				//trace(l)
				if(pts.length<=Longueur&&l%2==0)pts.shift()
				while(pts.length>Longueur||pts.length>l/2)pts.shift()
			} else {
				removeEventListener(Event.ENTER_FRAME, eFrame)
				parent.removeChild(this)
			}
			Render()
		}
		function Render(){
			graphics.clear()
			for(var i:int = 0; i<pts.length-1; i++){
				var t:Number = i<pts.length-i?i/2:(pts.length-i)/2
				graphics.lineStyle(t>3?3:t,0xFFFFFF)
				graphics.moveTo(pts[i].x, pts[i].y)
				graphics.lineTo(pts[i+1].x, pts[i+1].y)
			}
		}
	}
	
}
