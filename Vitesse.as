package  {
		import flash.geom.Point;
		import flash.events.Event;
		import flash.display.Sprite;

	public class Vitesse extends Sprite{
		var pts:Array = [new Point(0,0)]
		var angle:Number = 0;
		var modAngle:Number = 0;
		var l:int = 50;
		var spX:Number = 0;
		var spY:Number = Math.random()*16-8;
		var Longueur:int = 20;
		var color:uint = Math.random()>0.8?0xFF0000:0

		public function Vitesse(c:int) {
			color=c;
			addEventListener(Event.ENTER_FRAME, eFrame)
		}
		function eFrame(e:Event){
			//trace(pts.length)
			if(pts.length>0){
				l--;
				spY+=Math.random()*1.6-0.8;
				spX-=2;
				spX*=0.9;
				spY*=0.9;
				pts.push(new Point(pts[pts.length-1].x +spX,pts[pts.length-1].y+spY))
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
				graphics.lineStyle(t>3?3:t,color)
				graphics.moveTo(pts[i].x, pts[i].y)
				graphics.lineTo(pts[i+1].x, pts[i+1].y)
			}
		}
	}
	
}
