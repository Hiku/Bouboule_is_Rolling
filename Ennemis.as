package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Ennemis extends MovieClip {
		public var vie:int;
		var game:Object;
		var xBase:int;
		var yBase:int;
		public function Ennemis(X:int,Y:int,jeu:Object) {
			xBase = X;
			yBase = Y;
			game = jeu;
			x=xBase-game.slide;
			y=yBase+game.hauteur*0.5;
			addEventListener(Event.ENTER_FRAME, eFrame)
		}
		function eFrame(e:Event){
			x=xBase-game.slide;
			y=yBase+game.hauteur*0.5;
		}
	}
	
}
