package  {
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Nuage extends Sprite{

		public function Nuage() {
			var p:Array = []
			p.push(new Point(0,0))
			for(var i:int = 0; i<100; i++){
				while(true){
					var Pt:Point = new Point(Math.random()*400-200,Math.random()*400-200)
					var ok:Boolean = false;
					for(var j:int = 0; j<p.length; j++){
						if(Dist(p[j],Pt)<15){
							ok = true;
							break;
						}
					}
					if(ok){
						p.push(Pt)
						break;
					}
				}
			}
			for(i=0;i<p.length;i++){
				Rnd(p[i].x,p[i].y);
			}
		}
		function Dist(p1:Point, p2:Point){
			return Math.sqrt(Math.pow(p1.x-p2.x,2)+Math.pow(p1.y-p2.y,2)*3)
		}
		function Rnd(X:int,Y:int){
			graphics.beginFill(0xFFFFFF,1)
			graphics.drawCircle(X,Y,13)
			graphics.endFill()
		}

	}
	
}
