package  {
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Sprite;
	
	public class Vague extends Sprite{
		public var pts:Array = [new Point(0,0)]
		var angle:Number = 0;
		var modAngle:Number = 0;
		var Randomness:Number = 0;
		var l:int = 200;
		var sp:Number = 0.2;
		var Longueur:int = 300;
		var centre:int = -100;
		public var ht:int = 0;
		public function Vague() {
			addEventListener(Event.ENTER_FRAME, eFrame)
		}

		function eFrame(e:Event){
			if(pts.length>0){
				centre+=2;
				l--;
				modAngle+=Math.random()*0.1-0.05
				angle+=modAngle;
				angle*=0.9;
				modAngle*=0.9+(Randomness*0.05);
				//trace(angle)
				//trace(l)
				if(pts.length<=Longueur){
					pts.push(new Point(pts[pts.length-1].x + (3+1-Randomness)*sp,pts[pts.length-1].y + (angle*2)*sp))
					//centre--
					//pts.shift()
					
				}
				while(pts.length>Longueur||pts.length>l/2){
					centre--
					pts.shift()
				}
			}
			Render()
		}
		function Render(){
			//trace(centre)
			graphics.clear()
			for(var i:int = 0; i<pts.length-1; i++){
				var t:Number = i<pts.length-i?i/10:(pts.length-i)/10
				graphics.lineStyle(t>3?3:t,0xFFFFFF)
				graphics.moveTo(pts[i].x, pts[i].y-Math.pow(2,2-Math.abs(centre-i)/3)*t+ht)
				graphics.lineTo(pts[i+1].x, pts[i+1].y-Math.pow(2,2-Math.abs(centre-(i+1))/3)*t+ht)
			}
		}

	}
	
}
