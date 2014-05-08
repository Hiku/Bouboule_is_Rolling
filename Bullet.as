package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip {
		var game:Object;
		const speed:Number = 34+Math.random()*3;
		var xBase:int = 0;
		var yBase:Number = 0;
		var depla:int = 0;
		var speedY:Number = Math.random()*2-1;
		public function Bullet(X:int,Y:int,jeu:Object) {
			xBase=X;
			yBase=Y;
			game = jeu;
			x=depla+xBase-game.slide;
			y=yBase+game.hauteur*0.5;
			addEventListener(Event.ENTER_FRAME, eFrame)
		}
		function eFrame(e:Event){
			depla+=speed;
			yBase += speedY;
			x=depla+xBase-game.slide;
			y=yBase+game.hauteur*0.5;
		}

	}
	
}
